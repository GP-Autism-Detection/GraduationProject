import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_app/ChildExamStartScreen.dart';
import 'package:graduation_project_app/ExamStartScreen.dart';
import 'package:graduation_project_app/LoginScreen.dart';
import 'package:graduation_project_app/MenuScreen.dart';
import 'package:graduation_project_app/OTPGeneratorScreen.dart';
import 'package:graduation_project_app/Provider/dark_theme.dart';
import 'package:graduation_project_app/Provider/light_theme.dart';
import 'package:graduation_project_app/Provider/theme_provider.dart';
import 'package:graduation_project_app/QuizScreen.dart';
import 'package:graduation_project_app/QuizInfoScreen.dart';
import 'package:graduation_project_app/RegisterScreen.dart';
import 'package:graduation_project_app/TestScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

String? uid;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider<ThemeProvider>(
      create: (_) => ThemeProvider()..initialize(), child: MyApp()));
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
    return Consumer<ThemeProvider>(builder: (context, provider, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: uid == null ? LoginScreen() : MenuScreen(),
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: provider.theme,
      );
    });
  }
}
