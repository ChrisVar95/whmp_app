import 'package:flutter/material.dart';

import '../screens/settings_screen.dart';

class TopNav extends StatelessWidget {
  const TopNav({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) {
        return const [
          PopupMenuItem<int>(
            value: 0,
            child: Text('Setings'),
          ),
          PopupMenuItem<int>(
            value: 1,
            child: Text('Help'),
          ),
        ];
      },
      onSelected: (value) {
        if (value == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SettingScreen()),
          );
        } else if (value == 1) {
          print('Help selected');
        }
      },
    );
  }
}
