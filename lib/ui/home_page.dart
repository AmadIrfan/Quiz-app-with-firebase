// ignore_for_file: deprecated_member_use

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_logical_quiz/app_purchase/dash_purchases.dart';

import '../utility/app_theme.dart';
import '../utility/constants.dart';
import '../../ui/tab/topic_page.dart';
import '../resizer/fetch_pixels.dart';
import '../../ui/tab/report_page.dart';
import '../../ui/tab/setting_page.dart';
import '../../ui/tab/history_page.dart';
import '../../resizer/widget_utils.dart';
import '../../utility/color_scheme.dart';
import '../provider/app_controller.dart';
import '../provider/theme_controller.dart';
import '../../provider/login_controller.dart';
import '../customWidget/custom_animated_bottom_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  // AdsFile? adsFile;
  List<Widget> list = [];

  Future<bool> _requestPop() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex = 0;
      });
    } else {
      exitApp();
    }
    return Future.value(false);
  }

  bool _visible = false;
  @override
  void dispose() {
    super.dispose();
    // disposeInterstitialAd(adsFile);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      // adsFile = AdsFile(context);
      // adsFile!.createInterstitialAd();
      _visible = true;
      setState(() {});
    });
  }

  final AppController appController = Get.put(AppController(isFetchData: true));
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    if (list.isEmpty && _visible) {
      list.add(
        ReportPage(
          appController: appController,
          loginController: loginController,
        ),
      );
      list.add(
        TopicPage(
          // adsFile: adsFile!,
          loginController: loginController,
        ),
      );
      list.add(
        HistoryPage(
          // adsFile: adsFile!,
          appController: appController,
          loginController: loginController,
        ),
      );
      list.add(
        SettingPage(
          appController: appController,
          loginController: loginController,
        ),
      );
    }

    return WillPopScope(
        onWillPop: _requestPop,
        child: GetBuilder<LoginController>(
          init: LoginController(),
          builder: (value) {
            return Scaffold(
              backgroundColor: getBackgroundColor(context),
              appBar: getNoneAppBar(context,
                  color: value.isLogin.value || _currentIndex != 1
                      ? subColor
                      : getBackgroundColor(context)),
              bottomNavigationBar: _buildBottomBar(),
              body: SafeArea(
                child: Container(
                  child: list.isNotEmpty ? list[_currentIndex] : Container(),
                ),
              ),
            );
          },
        ));
  }

  int _currentIndex = 1 ;

  Widget _buildBottomBar() {
    const inactiveColor = Colors.transparent;
    final activeColor = primaryColor;

    double height = FetchPixels.getPixelHeight(160);
    double iconHeight = FetchPixels.getPixelHeight(60);

    return GetBuilder<ThemeController>(
      builder: (value) {
        return CustomAnimatedBottomBar(
          containerHeight: height,
          backgroundColor: value.themeMode != ThemeMode.dark
              ? getBackgroundColor(context)
              : getCardColor(context),
          selectedIndex: _currentIndex,
          showElevation: value.themeMode != ThemeMode.dark,
          isDarkMode: value.themeMode == ThemeMode.dark,
          itemCornerRadius: 0,
          curve: Curves.easeIn,
          onItemSelected: (index) {
            setState(() {
              _currentIndex = index;
            });

            loginController.getUser();
          },
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              title: 'Learn',
              activeColor: activeColor,
              inactiveColor: inactiveColor,
              textAlign: TextAlign.center,
              iconSize: iconHeight,
              imageName: "video.png",
            ),
            BottomNavyBarItem(
              title: 'Topic',
              activeColor: activeColor,
              inactiveColor: inactiveColor,
              textAlign: TextAlign.center,
              iconSize: iconHeight,
              imageName: "topic.png",
            ),
            BottomNavyBarItem(
              title: 'History',
              activeColor: activeColor,
              inactiveColor: inactiveColor,
              textAlign: TextAlign.center,
              iconSize: iconHeight,
              imageName: "history.png",
            ),
            BottomNavyBarItem(
              title: 'Setting',
              activeColor: activeColor,
              inactiveColor: inactiveColor,
              textAlign: TextAlign.center,
              iconSize: iconHeight,
              imageName: "setting.png",
            ),
          ],
        );
      },
      init: ThemeController(),
    );
  }
}
