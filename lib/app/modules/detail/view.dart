import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:whmp_app/app/core/utils/extensions.dart';
import 'package:whmp_app/app/modules/detail/widgets/done_list.dart';

import '../home/controller.dart';
import 'widgets/doing_list.dart';

class TaskDetails extends StatelessWidget {
  TaskDetails({super.key});

  final homeCtrl = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    var task = homeCtrl.task.value!;
    var color = HexColor.fromHex(task.color);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        leading: BackButton(onPressed: () {
          homeCtrl.updateTodos();
          homeCtrl.changeTask(null);
          homeCtrl.editController.clear();
          Get.back();
        }),
      ),
      body: Form(
        key: homeCtrl.formKey,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8.0.wp, top: 4.0.wp),
              child: Row(
                children: [
                  Icon(
                    IconData(
                      task.icon,
                      fontFamily: 'MaterialIcons',
                    ),
                    color: color,
                    size: 8.0.wp,
                  ),
                  SizedBox(
                    width: 3.0.wp,
                  ),
                  Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 16.0.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            Obx(() {
              var totalTodos =
                  homeCtrl.doingTodos.length + homeCtrl.doneTodos.length;
              return Padding(
                padding: EdgeInsets.only(
                  left: 16.0.wp,
                  bottom: 3.0.wp,
                  right: 16.0.wp,
                ),
                child: Row(
                  children: [
                    Text(
                      '$totalTodos Tasks',
                      style: TextStyle(
                        fontSize: 12.0.sp,
                        //TODO change color
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      width: 5.0.wp,
                    ),
                    Expanded(
                        child: StepProgressIndicator(
                      totalSteps: totalTodos == 0 ? 1 : totalTodos,
                      currentStep: homeCtrl.doneTodos.length,
                      size: 5,
                      padding: 0,
                      //TODO change color
                      selectedGradientColor: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [color.withOpacity(0.5), color],
                      ),
                      unselectedGradientColor: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.grey[300]!, Colors.grey[300]!],
                      ),
                    ))
                  ],
                ),
              );
            }),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.0.wp),
              child: TextFormField(
                controller: homeCtrl.editController,
                decoration: InputDecoration(
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  prefixIcon: const Icon(
                    Icons.check_box_outline_blank,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      if (homeCtrl.formKey.currentState!.validate()) {
                        var success =
                            homeCtrl.addTodo(homeCtrl.editController.text);
                        if (success) {
                          EasyLoading.showSuccess(
                              'Todo item added successfully');
                        } else {
                          EasyLoading.showError('Todo item already exists');
                        }
                        homeCtrl.editController.clear();
                      }
                    },
                    icon: const Icon(Icons.done),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your todo item';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 5.0.wp,
            ),
            DoingList(),
            DoneList(),
          ],
        ),
      ),
    );
  }
}
