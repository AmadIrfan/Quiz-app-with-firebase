import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController{
  static String pkgName = "o_level_quiz_";
  static String isDarkMode = "${pkgName}themeMode";

  ThemeMode themeMode = ThemeMode.dark;

  SharedPreferences? prefs;


  @override
  void onInit() {
    setTheme();
    super.onInit();
  }


  Future<void> setTheme() async {
    prefs = await SharedPreferences.getInstance();
    themeMode = ThemeMode.values[prefs!.getInt(isDarkMode) ?? 1];
    update();
  }

  void changeTheme() async {
    if (themeMode == ThemeMode.light) {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.light;
    }

    update();

    if (prefs != null) {
      await prefs!.setInt(isDarkMode, themeMode.index);
    } else {
      prefs = await SharedPreferences.getInstance();
      await prefs!.setInt(isDarkMode, themeMode.index);
    }
  }

}