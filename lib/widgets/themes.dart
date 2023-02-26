import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  get lightTheme => ThemeData();
}
