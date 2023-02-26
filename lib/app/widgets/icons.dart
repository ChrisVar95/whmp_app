import 'package:flutter/material.dart';
import 'package:whmp_app/app/core/values/colors.dart';

import '../core/values/icons.dart';

List<Icon> getIcons() {
  //TODO change colours
  return const [
    Icon(
      IconData(personIcon, fontFamily: 'MaterialIcons'),
      color: Colors.purple,
    ),
    Icon(
      IconData(workIcon, fontFamily: 'MaterialIcons'),
      color: Colors.indigo,
    ),
    Icon(
      IconData(movieIcon, fontFamily: 'MaterialIcons'),
      color: Colors.orange,
    ),
    Icon(
      IconData(sportIcon, fontFamily: 'MaterialIcons'),
      color: kYellow,
    ),
    Icon(
      IconData(travelIcon, fontFamily: 'MaterialIcons'),
      color: Colors.lightGreen,
    ),
    Icon(
      IconData(shopIcon, fontFamily: 'MaterialIcons'),
      color: Colors.lightBlue,
    ),
  ];
}
