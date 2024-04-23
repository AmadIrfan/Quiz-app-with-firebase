// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_logical_quiz/model/Intro_model.dart';
import 'package:flutter_logical_quiz/provider/intro_controller.dart';
import 'package:flutter_logical_quiz/provider/pref_data.dart';
import 'package:flutter_logical_quiz/utility/app_theme.dart';
import 'package:get/get.dart';

import '../../resizer/fetch_pixels.dart';
import '../../resizer/widget_utils.dart';
import '../../utility/color_scheme.dart';
import '../../utility/constants.dart';
import '../home_page.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() {
    return _IntroPage();
  }
}

class _IntroPage extends State<IntroPage> {
  PageController controller = PageController();
  ValueNotifier<int> position = ValueNotifier(0);

  final IntroController introController = Get.put(IntroController());

  @override
  void initState() {
    super.initState();
  }

  notifyWidget() {
    setState(() {});
  }

  Future<bool> _requestPop() {
    if (position.value > 0) {
      position.value--;
      changePage();
    } else {
      exitApp();
    }
    return Future.value(false);
  }

  bool isCompleteIntro = false;

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);

    Widget space = getVerticalSpace(30);

    return WillPopScope(
        onWillPop: _requestPop,
        child: Scaffold(
          backgroundColor: getBackgroundColor(context),
          appBar: getNoneAppBar(context, color: getBackgroundColor(context)),
          body: Obx(() {
            if (introController.isLoading.value) {
              return getProgressDialog(context);
            } else {
              return Column(
                children: [
                  Expanded(
                      child: PageView.builder(
                    itemCount: introController.list.length,
                    onPageChanged: (pos) {
                      position.value = pos;
                    },
                    controller: controller,
                    itemBuilder: (context, index) {
                      IntroModel model = introController.list[index];
                      return Container(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                FetchPixels.getDefaultHorSpace(context)),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Image.asset(
                                '$splashAssetPath${model.image}',
                                height: FetchPixels.getPixelHeight(400),
                              ),
                            ),
                            space,
                            Stack(
                              children: [
                                Positioned.fill(
                                    child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Image.asset(
                                    '$splashAssetPath${model.icon}',
                                  ),
                                )),
                                getCustomFont(
                                    model.title,
                                    FetchPixels.getPixelHeight(130),
                                    getFontColor(context),
                                    1,
                                    fontWeight: FontWeight.w700),
                              ],
                            ),
                            space,
                            getCustomFont(
                                model.desc,
                                FetchPixels.getPixelHeight(85),
                                getFontColor(context),
                                2,
                                fontWeight: FontWeight.w400,
                                textAlign: TextAlign.center),
                            space,
                            space,
                          ],
                        ),
                      );
                    },
                  )),
                  ValueListenableBuilder(
                      builder: (context, value, child) {
                        return Column(
                          children: [
                            space,
                            DotsIndicator(
                              dotsCount: introController.list.length,
                              position: position.value,
                              decorator: DotsDecorator(
                                color: getBaseColor(context), // Inactive color
                                activeColor: primaryColor,
                              ),
                            ),
                            space,
                            space,
                            getButtonWidget(
                                context,
                                value == introController.list.length
                                    ? 'Get Started'
                                    : 'Next', () {
                              nextAction();
                            }, verticalSpace: 0),
                            space,
                            Opacity(
                              opacity: (value == introController.list.length)
                                  ? 0
                                  : 1,
                              child: getButtonWidget(context, 'Skip', () {
                                if (value != introController.list.length) {
                                  nextAction();
                                }
                              },
                                  bgColor: Colors.transparent,
                                  verticalSpace: 0,
                                  textColor: getFontColor(context)),
                            ),
                            space,
                          ],
                        );
                      },
                      valueListenable: position)
                ],
              );
            }
          }),
        ));
  }

  changePage() {
    controller.animateToPage(position.value,
        curve: Curves.ease, duration: const Duration(seconds: 1));
  }

  nextAction() {
    if (position.value < (introController.list.length - 1)) {
      position.value++;
      changePage();
    } else {
      PrefData.setIsIntro(false);
      Get.off(const HomePage());
      // sendLoginPage(
      //     context: context,
      //     fromIntro: true,
      //     function: () {
      //     });
    }
  }
}
