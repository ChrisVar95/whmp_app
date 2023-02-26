import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whmp_app/app/core/utils/extensions.dart';
import 'package:whmp_app/app/core/values/colors.dart';
import 'package:whmp_app/app/modules/home/controller.dart';
import 'package:whmp_app/app/modules/home/widgets/task_card.dart';

import 'widgets/add_card.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(4.0.wp),
            child: Text(
              'My List',
              style: TextStyle(
                  fontSize: 24.0.sp,
                  fontWeight: FontWeight.bold,
                  color: kPurpleDark),
            ),
          ),
          Obx(
            () => Column(
              children: [
                ...controller.tasks
                    .map(
                      (element) => LongPressDraggable(
                        data: element,
                        onDragStarted: () => controller.changeDeleting(true),
                        onDraggableCanceled: (_, __) =>
                            controller.changeDeleting(false),
                        onDragEnd: (_) => controller.changeDeleting(false),
                        feedback: Opacity(
                          opacity: 0.8,
                          child: TaskCard(task: element),
                        ),
                        child: TaskCard(task: element),
                      ),
                    )
                    .toList(),
                AddCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
