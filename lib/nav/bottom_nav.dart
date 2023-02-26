import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final Function(int) onItemTapped;
  final int selectedIndex;
  const BottomNav(this.onItemTapped, this.selectedIndex, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BottomNavigationBar(
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
        selectedItemColor: Colors.amber,
        onTap: onItemTapped,
      ),
    );
  }
}
