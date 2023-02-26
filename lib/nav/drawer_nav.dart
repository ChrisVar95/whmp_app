import 'package:flutter/material.dart';
import '../screens/account_details.dart';
import '../app/core/values/colors.dart';
import '../widgets/login_controller.dart';
import 'package:get/get.dart';

class DrawerNav extends Drawer {
  final controller = Get.put(LoginController());

  DrawerNav({super.key});
  static double sizedBoxHeight = 36;

  void selectDrawerItem(BuildContext ctx, Widget pageCalled) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return pageCalled;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // backgroundColor: kDark,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: kPurpleDark,
            ),
            child: Center(
                child: Image(
              image: AssetImage('lib/assets/images/logo.png'),
            )),
          ),
          ListTile(
            leading: const Icon(
              Icons.person,
            ),
            title: const Text('Account'),
            onTap: () {
              // Update the state of the app
              selectDrawerItem(context, AccountDetails());
              // Then close the drawer
              //Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.calendar_month_rounded,
            ),
            title: const Text('Calendar'),
            onTap: () {
              // Update the state of the app
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.collections_bookmark_rounded,
            ),
            title: const Text('Saved Items'),
            onTap: () {
              // Update the state of the app
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          SizedBox(
            height: sizedBoxHeight,
          ),
          ListTile(
            leading: const Icon(
              Icons.email_rounded,
            ),
            title: const Text('Email Us'),
            onTap: () {
              // Update the state of the app
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.info_rounded,
            ),
            title: const Text('About Us'),
            onTap: () {
              // Update the state of the app
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.description_rounded,
            ),
            title: const Text('Privacy Policy'),
            onTap: () {
              // Update the state of the app
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          SizedBox(
            height: sizedBoxHeight,
          ),
          ListTile(
            leading: const Icon(
              Icons.logout_rounded,
            ),
            title: const Text('Logout'),
            onTap: () {
              controller.logout();
            },
          ),
        ],
      ),
    );
  }
}
