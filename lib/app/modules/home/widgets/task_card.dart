import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whmp_app/app/core/utils/extensions.dart';
import 'package:whmp_app/app/core/values/colors.dart';
import 'package:whmp_app/app/modules/detail/view.dart';
import 'package:whmp_app/app/modules/home/controller.dart';

import '../../../data/model/task.dart';

class TaskCard extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  final Task task;
  TaskCard({super.key, required this.task});

  double calculateTotalSteps() {
    double total = 0;
    if (!homeCtrl.isTodoEmpty(task)) {
      int totalSteps = task.todos!.length;
      int currentStep = homeCtrl.getDoneTodo(task);
      if (currentStep != 0) total = currentStep / totalSteps;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final color = HexColor.fromHex(task.color);
    final squareWidth = Get.width - 12.0.wp;
    return GestureDetector(
      onTap: () {
        homeCtrl.changeTask(task);
        homeCtrl.changeTodos(task.todos ?? []);
        Get.to(() => TaskDetails());
      },
      child: Container(
        width: squareWidth,
        margin: EdgeInsets.all(3.0.wp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: kPurpleDark,
          boxShadow: const [
            BoxShadow(
              color: kDark,
              blurRadius: 3,
              offset: Offset(0, 1),
            )
          ],
        ),
        child: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.0.hp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    margin: EdgeInsets.all(3.0.wp),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircularProgressIndicator(
                          value: calculateTotalSteps(),
                          color: color,
                          backgroundColor: Colors.white,
                        ),
                        Icon(
                          IconData(task.icon, fontFamily: 'MaterialIcons'),
                          color: color,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    task.title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0.sp,
                        color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                  ),
                  //TODO
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 4.0.hp),
              child: Padding(
                padding: EdgeInsets.only(left: 4.0.wp),
                child: Obx(
                  () => homeCtrl.doingTodos.isEmpty &&
                          homeCtrl.doneTodos.isEmpty
                      ? Text(
                          '${task.todos?.length ?? 0} Tasks',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...homeCtrl.doingTodos
                                .map((element) => Row(
                                      children: [
                                        SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: Checkbox(
                                            fillColor: MaterialStateProperty
                                                .resolveWith(
                                                    (states) => Colors.grey),
                                            value: element['done'],
                                            onChanged: (value) {
                                              homeCtrl
                                                  .doneTodo(element['title']);
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: 4.0.wp,
                                        ),
                                        Text(
                                          element['title'],
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ))
                                .toList(),
                            if (homeCtrl.doingTodos.isNotEmpty)
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0.wp),
                                child: const Divider(
                                  thickness: 2,
                                ),
                              ),
                          ],
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
