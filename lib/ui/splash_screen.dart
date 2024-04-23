import 'dart:async';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../provider/login_controller.dart';
import '../provider/pref_data.dart';
import 'home_page.dart';
import '../utility/constants.dart';
import '../resizer/fetch_pixels.dart';
import '../resizer/widget_utils.dart';
import '../../utility/color_scheme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> with TickerProviderStateMixin {
  bool isFirst = true;
  final LoginController loginController = Get.put(LoginController());
  @override
  void initState() {
    super.initState();
    _getIsFirst();
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        // Navigator.pushNamed(
        //   context,
        //   '/message',
        //   arguments: MessageArguments(message, true),
        // );
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        // flutterLocalNotificationsPlugin.show(
        //   notification.hashCode,
        //   notification.title,
        //   notification.body,
        //   NotificationDetails(
        //     android: AndroidNotificationDetails(
        //       channel.id,
        //       channel.name,
        //       channelDescription: channel.description,
        //
        //       icon: 'launch_background',
        //     ),
        //   ),
        // );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // print('A new onMessageOpenedApp event was published!');
      // Navigator.pushNamed(
      //   context,
      //   '/message',
      //   arguments: MessageArguments(message, true),
      // );
    });
  }

  _getIsFirst() async {
    Future.delayed(Duration.zero, () async {
//       bool i = await PrefData.getIsLogin();
      String? a = await loginController.getLocalId();
      if (a == null) {
        await loginController.setLocalId();
        showSnackBar('Your Unique Id is created');
      }
      // if (isIntro) {
      // print('INTRO');
      // Get.to(const IntroPage());
      // } else {
      Timer(const Duration(seconds: 3), () async {
        // if (i) {
        Get.to(const HomePage());
        // } else {
        //   sendLoginPage(context: context, fromIntro: false, function: () {});
        // }
      });
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);

    return Scaffold(
      backgroundColor: getBackgroundColor(context),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          color: getBackgroundColor(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  "${splashAssetPath}splash_icon.png",
                  color: getFontColor(context),
                  height: FetchPixels.getPixelHeight(180),
                ),
              ),
              getVerticalSpace(30),
              Container(
                child: getCustomFont('Quiz', FetchPixels.getPixelHeight(200),
                    getFontColor(context), 5,
                    textAlign: TextAlign.start, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
      appBar: getNoneAppBar(context, isFullScreen: true),
    );
  }
}

 //
    // EmailAuth emailAuth =  new EmailAuth(sessionName: "Sample session");
    //
    // emailAuth.config({
    //   "server": "firebase-adminsdk-79hnj@programming-quiz-262eb.iam.gserviceaccount.com",
    //   "serverKey": "AAAA-FR9jV0:APA91bFoEW-A6gTXMUiuH7WM7lEeXL_mrMR7J9C3PdUXKmiGuKM29vIK_eZeUkp0tubDperwQ84mYJxHSd3goPotjRMXnVluLZpOV-a5rKiPM6R7zl1XtvL8mVw7pWdc71V64ZnYpdpm"
    // });
    //
    //
    //
    // bool result = await emailAuth.sendOtp(
    //     recipientMail: "patoliyapriyanshi.dream@gmail.com", otpLength: 5
    // );
    //
    // print("result===$result");
    // authHandler.config(
    //   otpLength: 6
    // );
    //
    // authHandler.sendOtp("patoliyapriyanshi.dream@gmail.com");
