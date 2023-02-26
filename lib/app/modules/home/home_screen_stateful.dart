import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:whmp_app/app/core/values/colors.dart';
import 'package:whmp_app/app/core/values/icons.dart';
import 'package:whmp_app/app/data/model/task.dart';
import 'package:whmp_app/app/modules/home/widgets/add_dialog.dart';

import 'view.dart';
import '../../../screens/progress.dart';
import '../../../nav/bottom_nav.dart';
import '../../../nav/pop_up_menu.dart';
import '../../../nav/drawer_nav.dart';

class HomeScreenStatefulWidget extends StatefulWidget {
  const HomeScreenStatefulWidget({super.key, required this.title});

  final String title;

  @override
  State<HomeScreenStatefulWidget> createState() =>
      _HomeScreenStatefulWidgetState();
}

class _HomeScreenStatefulWidgetState extends State<HomeScreenStatefulWidget> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    ProgressPage(),
  ];

  void databaseReferenceTest() {
    final counter = DateTime.now();
    DatabaseReference testRef = FirebaseDatabase.instance.ref().child("test");
    testRef.set("Hello World $counter");
  }

  void _onItemTapped(int index) {
    setState(() {
      databaseReferenceTest();
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: const [TopNav()],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      drawer: DrawerNav(),
      bottomNavigationBar: BottomNav(_onItemTapped, _selectedIndex),
      /********************
      Floating action Button
      *********************/
      floatingActionButton: DragTarget<Task>(
        builder: (_, __, ___) {
          return Obx(
            () => FloatingActionButton(
              backgroundColor: const HomePage().controller.deleting.value
                  ? kRed
                  : kYellowDark,
              onPressed: () {
                if (HomePage().controller.tasks.isEmpty) {
                  var task = const Task(
                    title: 'General Task',
                    icon: personIcon,
                    color: 'FFA39431',
                  );
                  HomePage().controller.addTask(task);
                }
                Get.to(() => AddDialog(), transition: Transition.downToUp);
              },
              tooltip: 'Create New Task',
              child: Icon(const HomePage().controller.deleting.value
                  ? Icons.delete
                  : Icons.add),
            ),
          );
        },
        onAccept: (Task task) {
          const HomePage().controller.deleteTask(task);
          EasyLoading.showSuccess('Delete Success');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
