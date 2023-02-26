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
        height: squareWidth / 2,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            //TODO
            Padding(
              padding: EdgeInsets.all(6.0.wp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0.sp,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 2.0.wp,
                  ),
                  Text(
                    '${task.todos?.length ?? 0} Task',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
