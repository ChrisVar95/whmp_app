import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'package:whmp_app/app/core/utils/extensions.dart';
import 'package:whmp_app/app/core/values/colors.dart';
import '../../../data/model/task.dart';
import '../../../widgets/icons.dart';
import '../controller.dart';

class AddCard extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  AddCard({super.key});

  @override
  Widget build(BuildContext context) {
    final icons = getIcons();
    var sqareWidth = Get.width - 12.0.wp;

    final cardDatabaseRef = homeCtrl.database.child('/taskCard');

    //TODO change container size
    return Container(
      width: sqareWidth,
      height: sqareWidth / 2,
      margin: EdgeInsets.symmetric(horizontal: 10.0.wp, vertical: 3.0.wp),
      child: InkWell(
        onTap: () async {
          await Get.defaultDialog(
            titlePadding: EdgeInsets.symmetric(vertical: 5.0.wp),
            radius: 5,
            title: 'Task Type',
            content: Form(
              key: homeCtrl.formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
                    child: TextFormField(
                      controller: homeCtrl.editController,
                      decoration: const InputDecoration(
                        //border: OutlineInputBorder(),
                        labelText: 'Title',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your task title';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0.wp),
                    child: Wrap(
                      spacing: 2.0.wp,
                      children: icons
                          .map(
                            (e) => Obx(
                              () {
                                final index = icons.indexOf(e);
                                return ChoiceChip(
                                  //TODO choose color
                                  selectedColor: kYellowLight,
                                  backgroundColor: Colors.transparent,
                                  pressElevation: 0,
                                  label: e,
                                  selected: homeCtrl.chipIndex.value == index,
                                  onSelected: (bool selected) {
                                    homeCtrl.chipIndex.value =
                                        selected ? index : 0;
                                  },
                                );
                              },
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      //TODO change button color
                      backgroundColor: kYellow,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      minimumSize: const Size(150, 40),
                    ),
                    onPressed: () async {
                      if (homeCtrl.formKey.currentState!.validate()) {
                        int icon =
                            icons[homeCtrl.chipIndex.value].icon!.codePoint;
                        String color =
                            icons[homeCtrl.chipIndex.value].color!.toHex();
                        var task = Task(
                          title: homeCtrl.editController.text,
                          icon: icon,
                          color: color,
                        );
                        Get.back();
                        homeCtrl.addTask(task)
                            ? EasyLoading.showSuccess('Successfully created')
                            : EasyLoading.showError('Duplicate Task');

                        //How to insert data into database
                        try {
                          await cardDatabaseRef
                              .child('/cards')
                              .push()
                              .set(task.toJson());
                          log('Card has been written to database');
                        } catch (e) {
                          log('You got an error $e');
                        }
                      }
                    },
                    child: const Text('Confirm'),
                  ),
                ],
              ),
            ),
          );
          homeCtrl.editController.clear();

          homeCtrl.changeChipIndex(0);
        },
        child: DottedBorder(
          color: kYellow,
          dashPattern: const [8, 4],
          child: Center(
            child: Icon(
              Icons.add,
              size: 10.0.wp,
              color: kYellow,
            ),
          ),
        ),
      ),
    );
  }
}
