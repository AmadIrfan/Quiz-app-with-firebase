import 'package:flutter/material.dart';
import 'package:flutter_logical_quiz/utility/constants.dart';
import 'package:flutter_logical_quiz/resizer/fetch_pixels.dart';
import 'package:flutter_logical_quiz/resizer/widget_utils.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../utility/color_scheme.dart';
import '../provider/theme_controller.dart';

class NewLoginScreen extends StatelessWidget {
  final Function notify;

  const NewLoginScreen(this.notify, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GetBuilder<ThemeController>(
            builder: (value) {
              return Image.asset(
                getThemeIcon(value, 'login.png'),
                height: FetchPixels.getPixelHeight(400),
              );
            },
            init: ThemeController(),
          ),
          getVerticalSpace(200),
          getCustomFont('Authenticate', FetchPixels.getPixelHeight(110),
              getFontColor(context), 1,
              fontWeight: FontWeight.w700),
          getVerticalSpace(30),
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: FetchPixels.getDefaultHorSpace(context)),
            child: getCustomFont(
                'You need to verify that you\'re the right bee!',
                FetchPixels.getPixelHeight(80),
                getFontColor(context),
                1,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.center),
          ),
          getVerticalSpace(30),
          getButtonWidget(
            context,
            'Log In',
            () {
              sendLoginPage(
                context: context,
                function: () {
                  notify();
                },
              );
            },
            horizontalSpace: FetchPixels.getPixelWidth(200),
          )
        ],
      ),
    );
  }
}
