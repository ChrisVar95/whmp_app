import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:whmp_app/app/core/utils/extensions.dart';
import 'package:whmp_app/app/core/values/colors.dart';
import 'package:whmp_app/app/modules/home/controller.dart';

class ReportPage extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Obx(() {
      var createdTasks = homeCtrl.getTotalTask();
      var completedTasks = homeCtrl.getTotalDoneTasks();
      var liveTasks = createdTasks - completedTasks;
      var percent = (completedTasks / createdTasks * 100).toStringAsFixed(0);
      return ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(4.0.wp),
            child: Text(
              'My Report',
              style: TextStyle(
                fontSize: 24.0.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
            child: Text(
              DateFormat.yMMMd().format(DateTime.now()),
              style: TextStyle(
                fontSize: 14.0.sp,
                color: Colors.grey,
              ),
            ),
          ),
          Container(
            color: kPurpleDark,
            child: Padding(
              padding:
                  EdgeInsets.symmetric(vertical: 5.0.wp, horizontal: 5.0.wp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatus(Colors.green, liveTasks, 'Live Tasks'),
                  _buildStatus(Colors.orange, completedTasks, 'Completed'),
                  _buildStatus(Colors.blue, createdTasks, 'Created ')
                ],
              ),
            ),
          ),
          SizedBox(
            height: 8.0.wp,
          ),
          UnconstrainedBox(
            child: SizedBox(
              width: 70.0.wp,
              height: 70.0.wp,
              child: CircularStepProgressIndicator(
                totalSteps: createdTasks == 0 ? 1 : createdTasks,
                currentStep: completedTasks,
                stepSize: 20,
                selectedColor: kYellowDark,
                unselectedColor: Colors.white10,
                padding: 0,
                width: 150,
                height: 150,
                selectedStepSize: 22,
                roundedCap: (_, __) => true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('${createdTasks == 0 ? 0 : percent}%')],
                ),
              ),
            ),
          )
        ],
      );
    }));
  }

  Row _buildStatus(Color color, int number, String title) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          height: 3.0.wp,
          width: 3.0.wp,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: color,
              width: 0.5.wp,
            ),
          ),
        ),
        SizedBox(
          width: 3.0.wp,
        ),
        Column(
          children: [
            Text(
              '$number',
              style: TextStyle(
                  fontSize: 16.0.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(
              height: 2.0.wp,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 12.0.sp,
                color: Colors.grey,
              ),
            ),
          ],
        )
      ],
    );
  }
}
