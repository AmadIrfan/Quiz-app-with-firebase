import 'package:flutter/material.dart';

import '../../resizer/fetch_pixels.dart';
import '../../utility/color_scheme.dart';
import '../../utility/app_theme.dart';
import '../../resizer/widget_utils.dart';

class BackDialogView extends StatelessWidget {
  final Function function;

  const BackDialogView({super.key, required this.function});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: FetchPixels.getPixelHeight(15),
          horizontal: FetchPixels.getPixelWidth(35)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: getScreenPercentSize(context, 2)),
          getTextWidget1(
              Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.w500),
              "Quit",
              TextAlign.center,
              getScreenPercentSize(context, 3)),
          SizedBox(height: getScreenPercentSize(context, 1)),
          getTextWidget("Are you sure you want to quit?",
              FetchPixels.getPixelHeight(80), getSubFontColor(context)),
          getVerticalSpace(30),
          getTextWidget(
              "If you quit,this data will not be added to your quiz history or previously attempted quizzes.",
              FetchPixels.getPixelHeight(80),
              getFontColor(context)),
          getVerticalSpace(60),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              getButtonWidget(context, 'No'.toUpperCase(), () {
                Navigator.of(context).pop(true);
              },
                  bgColor: getSubColor(context),textColor: getFontColor(context)),
              getHorizontalSpace(45),
              getButtonWidget(context, 'YES', () {
                Navigator.of(context).pop(false);
                function();
              }),
            ],
          )
        ],
      ),
    );
  }

  Widget getButtonWidget(BuildContext context, String s, Function function,
      {double? horizontalSpace,
      IconData? icon,
      var color,
      double? verticalSpace,
      Color? bgColor,
      Color? textColor,
      double? btnHeight,
      Color? iconColor}) {
    FetchPixels(context);
    double height = FetchPixels.getPixelHeight(95);
    double radius = FetchPixels.getPixelHeight(120);
    double fontSize = FetchPixels.getPixelHeight(85);

    return InkWell(
      splashColor: Colors.black12,
      onTap: () {
        function();
      },
      child: Container(
        height: height,
        margin: EdgeInsets.symmetric(
          vertical: verticalSpace ?? FetchPixels.getDefaultHorSpace(context),
        ),
        child: Material(
          // <----------------------------- Outer Material
          shadowColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
          elevation: 0,
          child: Container(
            padding:
                EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(100)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(radius)),
              color: bgColor ?? primaryColor,
            ),
            child: Material(
              type: MaterialType.transparency,
              elevation: 1.0,
              color: Colors.transparent,
              shadowColor: Colors.black12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  s.isEmpty
                      ? Container()
                      : getCustomFont(s, fontSize,
                          textColor ?? Colors.white, 2,
                          fontWeight: FontWeight.w600),
                  getHorizontalSpace(icon == null ? 0 : 15),
                  icon == null
                      ? Container()
                      : Icon(
                        icon,
                        color:
                            iconColor ?? Colors.white,
                        size: FetchPixels.getPixelHeight(65),
                      ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
