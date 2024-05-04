import 'package:flutter/material.dart';

import '../../utility/app_theme.dart';
import '../../resizer/fetch_pixels.dart';
import '../../resizer/widget_utils.dart';
import '../../utility/color_scheme.dart';

class CommonQuizButtonWidget extends StatelessWidget {
  final String optionType;
  final String option;
  final Function? function;
  final bool isSelected;
  final bool isTrue;
  final Color? color;

  const CommonQuizButtonWidget(
      {super.key, required this.optionType, required this.option, this.function,required this.isSelected,
      this.color,required this.isTrue});

  @override
  Widget build(BuildContext context) {
    double height = FetchPixels.getPixelHeight(120);
    double radius = FetchPixels.getPixelHeight(25);

    Color cellColor=(color==null)?isSelected?greenColor:getSubColor(context):color!;

    return InkWell(
      onTap: () {
        if (function != null) {
          function!();
        }
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: FetchPixels.getPixelHeight(35)),
        padding: EdgeInsets.symmetric(
            horizontal: FetchPixels.getDefaultHorSpace(context)),
        height: isTrue?height*2:height,
        decoration:
            getDefaultDecoration(bgColor: cellColor, radius: radius),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: getCustomFont(optionType, FetchPixels.getPixelHeight(80),
                  isSelected || (color!=null)?Colors.white:  getFontColor(context), 2,
                  fontWeight: FontWeight.w600, textAlign: TextAlign.center),
            ),
            Center(
              child: getCustomFont(option, FetchPixels.getPixelHeight(80),
                  isSelected || (color!=null)?Colors.white:  getFontColor(context), 2,
                  fontWeight: FontWeight.w600, textAlign: TextAlign.center),
            )
          ],
        ),
      ),
    );
  }
}
