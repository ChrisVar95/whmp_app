import 'package:flutter/material.dart';
import 'package:whmp_app/app/core/values/colors.dart';

class BottomNav extends StatelessWidget {
  final Function(int) onItemTapped;
  final int selectedIndex;
  const BottomNav(this.onItemTapped, this.selectedIndex, {super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart_rounded),
          label: 'Stats',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: kYellowDark,
      onTap: onItemTapped,
    );
  }
}
