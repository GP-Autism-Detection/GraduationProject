import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:graduation_project_app/LoginScreen.dart';
import 'package:graduation_project_app/MenuScreen.dart';
import 'package:graduation_project_app/Provider/dark_theme.dart';
import 'package:graduation_project_app/Provider/light_theme.dart';
import 'package:graduation_project_app/Provider/theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

String? uid;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  runApp(
      // ChangeNotifierProvider<ThemeProvider>(
      // create: (_) => ThemeProvider()..initialize(), child: MyApp()),
      EasyLocalization(
          supportedLocales: const [Locale('en', 'US'), Locale('ar', 'AE')],
          path: 'assets/Translations',
          fallbackLocale: const Locale('en', 'US'),
          child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  Future getuid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uid = prefs.getString("ID");
  }

  @override
  Widget build(BuildContext context) {
    getuid();
    return ChangeNotifierProvider(
        create: (context) => ThemeProvider()..initialize(),
        builder: (context, child) {
          final provider = Provider.of<ThemeProvider>(context);
          return GetMaterialApp(
            //change to MaterialApp and remove transitions for on-time translations
            debugShowCheckedModeBanner: false,
            home: uid == null ? LoginScreen() : MenuScreen(),
            theme: lightTheme, //lightTheme,
            darkTheme: darkTheme,
            themeMode: provider.theme,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
          );
        });
  }
}
