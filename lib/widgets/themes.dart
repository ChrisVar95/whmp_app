import 'package:flutter/material.dart';
import 'package:whmp_app/app/core/values/colors.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeMode _themeMode;

  ThemeNotifier(this._themeMode);

  getThemeMode() => _themeMode;

  setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();
  }
}

class AppTheme {
  get darkTheme => ThemeData.dark();

  get lightTheme => ThemeData(
          appBarTheme: AppBarTheme(
        color: kPurpleDark,
      ));
}
