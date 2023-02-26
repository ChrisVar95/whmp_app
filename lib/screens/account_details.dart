import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/login_controller.dart';

class AccountDetails extends StatelessWidget {
  AccountDetails({super.key});
  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundImage:
                  Image.network(controller.googleAccount.value?.photoUrl ?? '')
                      .image,
              radius: 50,
            ),
            Text(
              controller.googleAccount.value?.displayName ?? '',
              style: Get.textTheme.headlineMedium,
            ),
            Text(
              controller.googleAccount.value?.email ?? '',
              style: Get.textTheme.bodySmall,
            ),
            const SizedBox(
              height: 300,
            )
          ],
        ),
      ),
    );
  }
}
