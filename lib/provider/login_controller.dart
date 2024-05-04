import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/FirebaseData.dart';
import '../provider/pref_data.dart';

class LoginController extends GetxController {
  RxBool isLogin = false.obs;
  String currentUser = '';
  String keyLogin = "${PrefData.pkgName}keyLogin";
  String keyCurrentUser = "${PrefData.pkgName}currentUser";

  @override
  void onInit() {
    setData();
    super.onInit();
  }

  Future<void> setData() async {
    bool i = await PrefData.getIsLogin();
    isLogin(i);
    currentUser = await getUser();
    update();
  }

  Future<void> changeData(bool isLogin) async {
    PrefData.setLogin(isLogin);
    setData();
  }

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(keyLogin, false);
    prefs.setString(keyCurrentUser, '');

    await FirebaseAuth.instance.signOut();
    update();
  }

  login(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(keyLogin, true);
    prefs.setString(keyCurrentUser, id);
    currentUser = id;
    update();
  }

  Future<String> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString(keyCurrentUser) ?? '';
    if (id.isNotEmpty) {
      DocumentSnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(FirebaseData.loginData)
          .doc(id)
          .get();
      if (querySnapshot.exists) {
        return id;
      } else {
        logout();
        changeData(false);
        return '';
      }
    } else {
      isLogin(false);
      if (isLogin.value) {
        changeData(false);
      }
      return '';
    }
  }
}
