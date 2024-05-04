import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter_logical_quiz/utility/constants.dart';
import 'package:flutter_logical_quiz/resizer/fetch_pixels.dart';
import 'package:flutter_logical_quiz/resizer/widget_utils.dart';
import 'package:flutter_logical_quiz/provider/login_controller.dart';
import 'package:flutter_logical_quiz/ui/commonWidget/log_out_dialog.dart';

import '../profile_page.dart';
import '../feedback_screen.dart';
import '../../utility/app_theme.dart';
import '../../utility/color_scheme.dart';
import '../../provider/app_controller.dart';
import '../login/change_password_page.dart';
import '../../provider/theme_controller.dart';
import '../commonWidget/rate_dialog_view.dart';
import '../commonWidget/common_profile_widget.dart';

class SettingPage extends StatelessWidget {
  final AppController appController;
  final Duration initialDelay = const Duration(milliseconds: 200);
  final LoginController loginController;
  const SettingPage(
      {super.key, required this.appController, required this.loginController});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        getCommonHeader(
          context,
          widget: getHeaderTitle("Setting", context),
        ),
        GetBuilder<ThemeController>(
          builder: (value) {
            return Container(
              margin: EdgeInsets.only(top: getHeaderTopMargin()),
              child: DelayedDisplay(
                fadeIn: true,
                slidingCurve: Curves.fastOutSlowIn,
                delay: Duration(seconds: initialDelay.inSeconds),
                child: ListView(
                  children: [
                    Obx(() {
                      return loginController.isLogin.value
                          ? Visibility(
                              visible: loginController.isLogin.value,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonProfileWidget(
                                      isEdit: true,
                                      function: () {
                                        pushPage(const ProfilePage());
                                      }),
                                  geTitle(context, 'Account'),
                                  getItem(
                                      context: context,
                                      title: 'Profile',
                                      icon: 'profile.svg',
                                      controller: value,
                                      function: () {
                                        pushPage(const ProfilePage());
                                      }),
                                  getItem(
                                      context: context,
                                      title: 'Password',
                                      icon: 'password.svg',
                                      controller: value,
                                      function: () {
                                        pushPage(const ChangePasswordPage());
                                      })
                                ],
                              ),
                            )
                          : getVerticalSpace(130);
                    }),
                    geTitle(context, 'General'),
                    GetBuilder<ThemeController>(
                      builder: (controller) {
                        return getItem(
                            context: context,
                            title: 'Dark Theme',
                            controller: controller,
                            icon: 'theme.svg',
                            isTheme: true,
                            function: () {
                              value.changeTheme();
                            });
                      },
                    ),
                    geTitle(context, 'Feedback'),
                    getItem(
                        context: context,
                        title: 'Rate Us',
                        icon: 'rate.svg',
                        controller: value,
                        function: () {
                          showCommonDialog(
                              widget: const RateViewDialog(), context: context);
                        }),
                    getItem(
                        context: context,
                        title: 'Feedback',
                        controller: value,
                        icon: 'feedback.svg',
                        function: () {
                          pushPage(const FeedbackScreen());
                        }),
                    geTitle(context, 'Feedback'),
                    getItem(
                        context: context,
                        title: 'Privacy Policy',
                        icon: 'privacy_policy.svg',
                        controller: value,
                        function: () {
                          // launchURL("https://www.officialreviewers-ph.com");
                        }),
                    getItem(
                        context: context,
                        title: 'About us',
                        icon: 'about_us.svg',
                        controller: value,
                        function: () {
                          // launchURL("https://www.officialreviewers-ph.com");
                          // pushPage(AboutPage());
                        }),
                    Obx(() {
                      return Visibility(
                        visible: loginController.isLogin.value,
                        child: getButtonWidget(context, 'Logout', () {
                          showCommonDialog(
                              widget: LogoutDialog(
                                function: () {
                                  LoginController().logout();
                                  loginController.changeData(false);
                                  appController.setReportData();
                                  showCustomToast(
                                      context: context, message: 'Logout');
                                  // sendLoginPage(
                                  //     context: context, function: () {});
                                },
                              ),
                              context: context);
                        }, verticalSpace: 10),
                      );
                    })
                  ],
                ),
              ),
            );
          },
          init: ThemeController(),
        ),
      ],
    );
  }

  launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch ';
    }
  }

  geTitle(BuildContext context, String title) {
    return Container(
      margin: EdgeInsets.only(
          top: FetchPixels.getPixelHeight(10),
          bottom: FetchPixels.getPixelHeight(40),
          right: FetchPixels.getDefaultHorSpace(context),
          left: FetchPixels.getDefaultHorSpace(context)),
      child: getCustomFont(
          title, FetchPixels.getPixelHeight(90), getSubFontColor(context), 1,
          fontWeight: FontWeight.w600),
    );
  }

  getVideoTitle(BuildContext context, String title) {
    return Container(
      margin: EdgeInsets.only(
          top: FetchPixels.getPixelHeight(10),
          bottom: FetchPixels.getPixelHeight(40),
          right: FetchPixels.getDefaultHorSpace(context),
          left: FetchPixels.getDefaultHorSpace(context)),
      child: getCustomVideoTitle(
          title, FetchPixels.getPixelHeight(90), getSubFontColor(context),
          fontWeight: FontWeight.w600),
    );
  }
  // getItem(
  //     {required BuildContext context,
  //     required Function function,
  //     required String icon,
  //     required String title,required ThemeController themeProvider}) {
  //   return InkWell(
  //     onTap: () {
  //    function();
  //     },
  //     child: Container(
  //       margin: EdgeInsets.only(
  //           bottom: FetchPixels.getPixelHeight(40),
  //           right: FetchPixels.getDefaultHorSpace(context),
  //           left: FetchPixels.getDefaultHorSpace(context)),
  //       height: FetchPixels.getPixelHeight(140),
  //       decoration: getDefaultDecoration(
  //           isShadow: true,
  //           shadowColor: getShadowColor(context),
  //           radius: FetchPixels.getPixelHeight(25),
  //           bgColor: getCardColor(context)),
  //       padding: EdgeInsets.symmetric(
  //           horizontal: FetchPixels.getDefaultHorSpace(context)),
  //       child: Row(
  //         children: [
  //           // SvgPicture.asset(
  //           //   getThemeIcon(themeProvider, icon),
  //           //   height: FetchPixels.getPixelHeight(45),
  //           //   width: FetchPixels.getPixelHeight(45),
  //           // ),
  //           // getHorizontalSpace(35),
  //           Expanded(
  //             child: getCustomFont(title, FetchPixels.getPixelHeight(85),
  //                 getFontColor(context), 1,
  //                 fontWeight: FontWeight.w600),
  //             flex: 1,
  //           ),
  //           Image.asset(
  //             assetPath + 'next.png',
  //             color: getFontColor(context),
  //             height: FetchPixels.getPixelHeight(25),
  //             width: FetchPixels.getPixelHeight(25),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  getItem({
    required BuildContext context,
    required Function function,
    required String title,
    required String icon,
    required ThemeController controller,
    bool? isTheme,
  }) {
    return InkWell(
      onTap: () {
        if (isTheme == null) {
          function();
        }
      },
      child: Container(
        margin: EdgeInsets.only(
            bottom: FetchPixels.getPixelHeight(40),
            right: FetchPixels.getDefaultHorSpace(context),
            left: FetchPixels.getDefaultHorSpace(context)),
        height: FetchPixels.getPixelHeight(140),
        decoration: getDefaultDecoration(
            isShadow: true,
            shadowColor: getShadowColor(context),
            radius: FetchPixels.getPixelHeight(25),
            bgColor: getCardColor(context)),
        padding: EdgeInsets.symmetric(
            horizontal: FetchPixels.getDefaultHorSpace(context)),
        child: Row(
          children: [
            SvgPicture.asset(
              controller.themeMode == ThemeMode.dark
                  ? '${settingPath}dark_$icon'
                  : '$settingPath$icon',
              height: FetchPixels.getPixelHeight(45),
              width: FetchPixels.getPixelHeight(45),
            ),
            getHorizontalSpace(35),
            Expanded(
              flex: 1,
              child: getCustomFont(
                title,
                FetchPixels.getPixelHeight(85),
                getFontColor(context),
                1,
                fontWeight: FontWeight.w600,
              ),
            ),
            (isTheme == null)
                ? Image.asset(
                    '${assetPath}next.png',
                    color: getFontColor(context),
                    height: FetchPixels.getPixelHeight(25),
                    width: FetchPixels.getPixelHeight(25),
                  )
                : CupertinoSwitch(
                    activeColor: primaryColor,
                    value: controller.themeMode == ThemeMode.dark,
                    onChanged: (bool value) {
                      function();
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
