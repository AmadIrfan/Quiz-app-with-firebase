
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_logical_quiz/ui/tab/main_history_page.dart';
import 'package:flutter_logical_quiz/provider/login_controller.dart';

import '../new_login_screen.dart';
import '../../provider/app_controller.dart';

class HistoryPage extends StatelessWidget {
  // final AdsFile adsFile;
  final AppController appController;
  final LoginController loginController;

  const HistoryPage(
      {super.key,
      // required this.adsFile,
      required this.appController,
      required this.loginController});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return loginController.isLogin.value
          ? loginController.currentUser.isNotEmpty
              ? MainHistoryPage(
                  currentUser: loginController.currentUser,
                  // adsFile: adsFile,
                )
              : Container()
          : NewLoginScreen(() {
              loginController.setData();
              appController.setReportData();
            });
    });
  }
}
