
import 'package:shared_preferences/shared_preferences.dart';

class PrefData {
  static String pkgName = "o_level_quiz_";
  static String isIntro = "${pkgName}isIntro";
  static String isLogin = "${pkgName}isLogin";
  static String coin = "${pkgName}coin";


  static setCoin(int sizes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(coin, sizes);
  }

  static getCoin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int intValue = prefs.getInt(coin) ?? 0;
    return intValue;
  }


  static setIsIntro(bool sizes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isIntro, sizes);
  }

  static getIsIntro() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool intValue = prefs.getBool(isIntro) ?? true;
    return intValue;
  }



  static setLogin(bool sizes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isLogin, sizes);
  }

  static getIsLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool intValue = prefs.getBool(isLogin) ?? false;
    return intValue;
  }

}
