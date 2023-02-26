import 'dart:developer';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whmp_app/app/data/services/storage/services.dart';
import 'package:whmp_app/app/modules/home/binding.dart';
import 'package:whmp_app/app/modules/home/home_screen_stateful.dart';

import 'screens/login_screen.dart';
import 'widgets/themes.dart';
import 'widgets/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());
  prefs.then((value) {
    runApp(
      ChangeNotifierProvider<ThemeNotifier>(
        create: (BuildContext context) {
          String? theme = value.getString(Constants.APP_THEME);
          if (theme == null ||
              theme == "" ||
              theme == Constants.SYSTEM_DEFAULT) {
            value.setString(Constants.APP_THEME, Constants.SYSTEM_DEFAULT);
            return ThemeNotifier(ThemeMode.system);
          }
          return ThemeNotifier(
              theme == Constants.DARK ? ThemeMode.dark : ThemeMode.light);
        },
        child: MyApp(),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _firebaseApp = Firebase.initializeApp(
    name: 'WHMP App',
    options: const FirebaseOptions(
      apiKey: 'AIzaSyDA4UznYIhaVCJjS6V_7PY7r1Q03KVihX4',
      appId: "1:109372866360:web:bca9b851749e4434494bcd",
      messagingSenderId: "109372866360",
      projectId: "whmp-app",
    ),
  );
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme().lightTheme,
      darkTheme: AppTheme().darkTheme,
      themeMode: themeNotifier.getThemeMode(),
      home: FutureBuilder(
        future: _firebaseApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            log('Error within Futurebuilder! ${snapshot.error.toString()}');
            return const Text('Something went wrong');
          } else if (snapshot.hasData) {
            //return LoginScreen();
            return HomeScreenStatefulWidget(title: 'Lilac: Daily Checklist');
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      initialBinding: HomeBindng(),
      builder: EasyLoading.init(),
    );
  }
}
