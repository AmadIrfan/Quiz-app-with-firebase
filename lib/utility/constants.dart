import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../resizer/fetch_pixels.dart';
import '../ui/login/login_page.dart';

String fontFamily = 'OpenSans';
String assetPath = "assets/images/";
String quizAssetPath = "assets/quizImages/";
String splashAssetPath = "assets/splashIcons/";
String tabAssetPath = "assets/tabIcons/";
String settingPath = "assets/settingIcons/";
String aboutUsText =
    'In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available.';

void exitApp() {
  if (Platform.isIOS) {
    exit(0);
  } else {
    SystemNavigator.pop();
  }
}

String getAppLink() {
  String pkgName = "com.pco4london.serutest";
  String appStoreIdentifier = "1491556149";
  if (Platform.isAndroid) {
    return "https://play.google.com/store/apps/details?id=$pkgName";
  } else if (Platform.isIOS) {
    return "https://apps.apple.com/us/app/apple-store/id$appStoreIdentifier";
  }
  return "";
}

Color getColorFromHex(String colors) {
  var color = "0xFF$colors";
  try {
    return Color(int.parse(color));
  } catch (e) {
    return const Color(0xFFFFFFFF);
  }
}

bool isNotEmpty(String s) {
  return (s.isNotEmpty);
}

bool emailValid(String s) {
  final bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(s);
  return emailValid;
}

showCommonDialog({required Widget widget, required BuildContext context}) {
  showDialog(
    context: context,
    builder: (_) {
      return widget;
    },
  );
}

String secToTime(int sec) {
  if (sec == 0) {
    return "00:00";
  }
  int second = sec % 60;
  double minute = sec / 60;
  if (minute >= 60) {
    double hour = minute / 60;
    minute %= 60;
    return "${hour.toInt()}:${minute < 10 ? minute == 0 ? "00" : "0${minute.toInt()}" : minute.toInt().toString()}:${second < 10 ? "00${second.toInt()}" : second.toInt().toString()}";
  }
  return "${minute < 10 ? minute == 0 ? "00" : "0${minute.toInt()}" : minute.toInt().toString()}:${second < 10 ? minute == 0 ? "00" : "0${second.toInt()}" : second.toInt().toString()}";
}

getCurrentDate() {
  DateFormat addDateFormat = DateFormat("hh:mm dd-MM-yyyy", "en-US");
  return addDateFormat.format(DateTime.now());
}

getFormattedDate() {
  DateFormat addDateFormat = DateFormat("hh:mm a dd-MMM-yyyy", "en-US");
  return addDateFormat.format(DateTime.now());
}

String getSeconds(int sec) {
  if (sec == 0) {
    return "00:00";
  }
  int second = sec % 60;
  double minute = sec / 60;
  if (minute >= 60) {
    return second.toInt().toString();
  }
  return second.toInt().toString();
}

sendLoginPage(
    {required BuildContext context,
    Function? function,
    bool fromIntro = false}) {
  pushPage(LoginPage(fromIntro), function: (value) {
    if (function != null) {
      function();
    }
  });
}

pushPage(var className, {Function? function}) {
  Get.to(className)!.then((value) {
    if (function != null) {
      function(value);
    }
  });
}

backPage({bool? value}) {
  if (value == null) {
    Get.back();
  } else {
    Get.back(result: value);
  }
}

String getMinute(int sec) {
  if (sec == 0) {
    return "00:00";
  }
  double minute = sec / 60;
  if (minute >= 60) {
    minute %= 60;
    return minute.toInt().toString();
  }
  return minute.toInt().toString();
}

hideKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

getCurrentStep(int i, int total) {
  return i > total ? total : i;
}

showSnackBar(String message) {
  Get.snackbar(
    '',
    '',
    snackPosition: SnackPosition.BOTTOM,
    borderRadius: 0,
    margin: EdgeInsets.all(FetchPixels.getPixelHeight(0)),
    padding: EdgeInsets.symmetric(
        vertical: FetchPixels.getPixelHeight(20),
        horizontal: FetchPixels.getPixelWidth(40)),
    colorText: Colors.white,
    duration: const Duration(seconds: 3),
    isDismissible: true,
    titleText: const Text(
      '',
      style: TextStyle(fontSize: 0),
    ),
    messageText: Container(
      margin: EdgeInsets.only(bottom: FetchPixels.getPixelHeight(15)),
      child: Text(
        message,
        style: TextStyle(
          fontSize: FetchPixels.getPixelHeight(40),
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
  );
}
