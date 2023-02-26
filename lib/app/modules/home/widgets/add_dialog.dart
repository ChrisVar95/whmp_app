import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:whmp_app/app/core/utils/extensions.dart';
import 'package:whmp_app/app/core/values/colors.dart';
import 'package:whmp_app/app/modules/home/controller.dart';

class AddDialog extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  AddDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
            homeCtrl.editController.clear();
            homeCtrl.changeTask(null);
          },
          icon: const Icon(
            Icons.close,
          ),
        ),
        title: Text(
          'New Task',
          style: TextStyle(
            fontSize: 16.0.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
            ),
            onPressed: () {
              if (homeCtrl.formKey.currentState!.validate()) {
                if (homeCtrl.task.value == null) {
                  EasyLoading.showError('Please Select task type!');
                } else {
                  var success = homeCtrl.updateTask(
                    homeCtrl.task.value!,
                    homeCtrl.editController.text,
                  );
                  if (success) {
                    EasyLoading.showSuccess('Todo item was added successfully');
                    Get.back();
                    homeCtrl.changeTask(null);
                  } else {
                    EasyLoading.showError('Todo item already exists!');
                  }
                  homeCtrl.editController.clear();
                }
              }
            },
            child: Text(
              'Done',
              style: TextStyle(fontSize: 14.0.sp, color: Colors.white),
            ),
          ),
        ],
      ),
      body: Form(
        key: homeCtrl.formKey,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
              child: TextFormField(
                controller: homeCtrl.editController,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400]!),
                  ),
                ),
                autofocus: true,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your todo item';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 5.0.wp,
                left: 5.0.wp,
                right: 5.0.wp,
                bottom: 2.0.wp,
              ),
              child: Text(
                'Add to',
                style: TextStyle(
                  fontSize: 14.0.sp,
                  color: Colors.grey,
                ),
              ),
            ),
            ...homeCtrl.tasks
                .map(
                  (element) => Obx(
                    () => InkWell(
                      onTap: () => homeCtrl.changeTask(element),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 3.0.wp,
                          horizontal: 5.0.wp,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              IconData(
                                element.icon,
                                fontFamily: 'MaterialIcons',
                              ),
                              color: HexColor.fromHex(element.color),
                            ),
                            SizedBox(
                              width: 3.0.wp,
                            ),
                            Text(
                              element.title,
                              style: TextStyle(
                                fontSize: 12.0.sp,
                                fontWeight: FontWeight.bold,
                                color: kPurpleDark,
                              ),
                            ),
                            const Spacer(),
                            if (homeCtrl.task.value == element)
                              const Icon(
                                Icons.check,
                                color: kYellowDark,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                .toList()
          ],
        ),
      ),
    );
  }
}
