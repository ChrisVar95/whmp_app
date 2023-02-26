import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/constants.dart';
import '../widgets/themes.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SettingState();
}

class _SettingState extends State<SettingScreen> {
  // TODO
  int _selectedPosition = -1;
  late bool isDarkTheme;
  List themes = ["System default", "Light", "Dark"];
  late SharedPreferences prefs;
  late ThemeNotifier themeNotifier;

  @override
  Widget build(BuildContext context) {
    isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    themeNotifier = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.SETTING),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemBuilder: (context, position) {
            return _createList(context, themes[position], position);
          },
          itemCount: themes.length,
        ),
      ),
    );
  }

  _createList(context, item, position) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        _updateState(position);
      },
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Radio(
            value: _selectedPosition,
            groupValue: position,
            onChanged: (_) {
              _updateState(position);
            },
          ),
          Text(item),
        ],
      ),
    );
  }

  _updateState(int position) {
    setState(() {
      _selectedPosition = position;
    });
    onThemeChanged(themes[position]);
  }

  void onThemeChanged(String value) async {
    var prefs = await SharedPreferences.getInstance();
    if (value == Constants.SYSTEM_DEFAULT) {
      themeNotifier.setThemeMode(ThemeMode.system);
    } else if (value == Constants.DARK) {
      themeNotifier.setThemeMode(ThemeMode.dark);
    } else {
      themeNotifier.setThemeMode(ThemeMode.light);
    }
    prefs.setString(Constants.APP_THEME, value);
  }
}
