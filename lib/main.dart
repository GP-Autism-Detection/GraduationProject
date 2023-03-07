import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_app/ExamStartScreen.dart';
import 'package:graduation_project_app/LoginScreen.dart';
import 'package:graduation_project_app/MenuScreen.dart';
import 'package:graduation_project_app/OTPGeneratorScreen.dart';
import 'package:graduation_project_app/RegisterScreen.dart';
import 'package:graduation_project_app/TestScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
