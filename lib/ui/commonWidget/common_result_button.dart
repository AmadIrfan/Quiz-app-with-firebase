import 'package:flutter/material.dart';

import 'package:flutter_logical_quiz/utility/app_theme.dart';
import 'package:flutter_logical_quiz/resizer/fetch_pixels.dart';
import 'package:flutter_logical_quiz/resizer/widget_utils.dart';
import 'package:flutter_logical_quiz/utility/color_scheme.dart';

class CommonResultButton extends StatelessWidget {
  final Color color;
  final String data;
  final String title;
  final double? btnHeight;
  final double? fontSize;
  const CommonResultButton(
      {super.key,
      required this.data,
      required this.title,
      required this.color,
      this.btnHeight,
      this.fontSize});
  @override
  Widget build(BuildContext context) {
    double? height = btnHeight ?? FetchPixels.getPixelWidth(140);
    double radius = FetchPixels.getPixelHeight(25);

    return Column(
      children: [
        Container(
          width: height,
          height: height,
          decoration: getDefaultDecoration(bgColor: color, radius: radius),
          child: Center(
            child: getCustomFont(
                data,
                FetchPixels.getPixelHeight(fontSize == null ? 120 : 100),
                color == skipColor ? Colors.black : Colors.white,
                1,
                fontWeight: FontWeight.w700,
                textAlign: TextAlign.center),
          ),
        ),
        getVerticalSpace(10),
        getCustomFont(
            title,
            fontSize == null ? FetchPixels.getPixelHeight(70) : fontSize!,
            getFontColor(context),
            1,
            fontWeight: FontWeight.w700,
            textAlign: TextAlign.center)
      ],
    );
  }
}
