import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whmp_app/app/core/utils/extensions.dart';
import 'package:whmp_app/app/core/values/colors.dart';

import '../../home/controller.dart';

class DoneList extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  DoneList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => homeCtrl.doneTodos.isNotEmpty
        ? ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.wp),
                child: Text(
                  'Completed (${homeCtrl.doneTodos.length})',
                  style: TextStyle(fontSize: 14.0.sp),
                ),
              ),
              ...homeCtrl.doneTodos
                  .map((element) => Dismissible(
                        key: ObjectKey(element),
                        direction: DismissDirection.endToStart,
                        onDismissed: (_) => homeCtrl.deleteDoneTodos(element),
                        background: Container(
                          color: kRed,
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 4.0.wp),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 3.0.wp, horizontal: 9.0.wp),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 20,
                                height: 20,
                                child: Icon(Icons.done),
                              ),
                              SizedBox(
                                width: 4.0.wp,
                              ),
                              Text(
                                element['title'],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: 12.0.sp),
                              ),
                            ],
                          ),
                        ),
                      ))
                  .toList()
            ],
          )
        : Container());
  }
}
