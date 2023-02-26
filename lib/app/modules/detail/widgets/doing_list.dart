import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whmp_app/app/core/utils/extensions.dart';

import '../../home/controller.dart';

class DoingList extends StatelessWidget {
  DoingList({super.key});

  final homeCtrl = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => homeCtrl.doingTodos.isEmpty && homeCtrl.doneTodos.isEmpty
        ? Column(
            children: [
              Image.asset(
                'lib/assets/icons/document.png',
                fit: BoxFit.cover,
                width: 65.0.wp,
              ),
              Text(
                'Add Task',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0.sp,
                ),
              ),
            ],
          )
        : ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              ...homeCtrl.doingTodos
                  .map((element) => Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 3.0.wp, horizontal: 9.0.wp),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: Checkbox(
                                fillColor: MaterialStateProperty.resolveWith(
                                    (states) => Colors.grey),
                                value: element['done'],
                                onChanged: (value) {
                                  homeCtrl.doneTodo(element['title']);
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
                        ),
                      ))
                  .toList(),
              if (homeCtrl.doingTodos.isNotEmpty)
                const Divider(
                  thickness: 2,
                )
            ],
          ));
  }
}
