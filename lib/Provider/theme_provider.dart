import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  late String Current_theme;
  ThemeMode _theme = ThemeMode.light;
  ThemeMode get theme => _theme;
  Future<void> toggleTheme() async {
    final isDark = _theme == ThemeMode.dark;
    if (isDark) {
      _theme = ThemeMode.light;
      Current_theme = 'light';
    } else {
      _theme = ThemeMode.dark;
      Current_theme = 'dark';
    }
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    await _pref.setString('theme', Current_theme);
    notifyListeners();
  }

  initialize() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    Current_theme = _prefs.getString('theme') ?? 'light';
    if (Current_theme == 'light') {
      _theme = ThemeMode.light;
    } else if (Current_theme == 'dark') {
      _theme = ThemeMode.dark;
    }
    notifyListeners();
  }
}
