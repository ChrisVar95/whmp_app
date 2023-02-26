import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/login_controller.dart';
import '../app/modules/home/home_screen_stateful.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final controller = Get.put(LoginController());
  static const String _title = 'Lilac: Daily Checklist';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
          () {
            if (controller.googleAccount.value == null) {
              return buildLoginButton();
            } else {
              return const HomeScreenStatefulWidget(title: _title);
            }
          },
        ),
      ),
    );
  }

  FloatingActionButton buildLoginButton() {
    return FloatingActionButton.extended(
      onPressed: () {
        controller.login();
      },
      icon: Image.asset(
        'lib/assets/icons/google_logo.png',
        height: 32,
        width: 32,
      ),
      label: const Text('Sign in with Google'),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    );
  }
}
