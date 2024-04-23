import 'package:flutter/material.dart';
import 'package:flutter_logical_quiz/provider/theme_controller.dart';
import 'package:flutter_logical_quiz/resizer/widget_utils.dart';
import 'package:flutter_logical_quiz/utility/color_scheme.dart';
import 'package:get/get.dart';

import '../resizer/fetch_pixels.dart';
// import '../utility/constants.dart';

class CreateAccountDialog extends StatefulWidget {
  final Function clickListener;

  const CreateAccountDialog({super.key, required this.clickListener});

  @override
  State<CreateAccountDialog> createState() => _CreateAccountDialog();
}

class _CreateAccountDialog extends State<CreateAccountDialog> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double radius = FetchPixels.getPixelHeight(40);

    double height = FetchPixels.getPixelHeight(880);
    double width = FetchPixels.getDialogWidth();

    return StatefulBuilder(
      builder: (context, setState) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          elevation: 0.0,
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          child: Container(
            height: height,
            width: width,
            padding: EdgeInsets.all(FetchPixels.getDefaultHorSpace(context)),
            decoration: getDefaultDecoration(
                radius: radius, bgColor: getCardColor(context)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: FetchPixels.getPixelHeight(280),
                  width: FetchPixels.getPixelHeight(280),
                  padding: EdgeInsets.all(FetchPixels.getPixelHeight(80)),
                  decoration: BoxDecoration(
                      color: getSubSelected(context), shape: BoxShape.circle),
                  child: Center(
                    child: GetBuilder<ThemeController>(
                       init: ThemeController(),
                      builder: (value) {
                        return Image.asset(
                          getThemeIcon(value, 'account1.png'),
                        );
                      },
                    ),
                  ),
                ),
                getVerticalSpace(50),
                getCustomFont('Account Created',
                    FetchPixels.getPixelHeight(100), getFontColor(context), 1,
                    fontWeight: FontWeight.w700),

                getVerticalSpace(20),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: FetchPixels.getDefaultHorSpace(context)),
                  child: getCustomFont(
                      'Your account has been successfully created!',
                      FetchPixels.getPixelHeight(80),
                      getFontColor(context),
                      2,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.center),
                ),
                getVerticalSpace(70),
                getButtonWidget(context, "Ok", () {
                  widget.clickListener(context);
// Navigator.of(context).pop();
                }, horizontalSpace: 0, verticalSpace: 0)
              ],
            ),
          ),
        );
      },
    );
  }
}
