import 'package:flutter/material.dart';

import '../../resizer/fetch_pixels.dart';
import '../../resizer/widget_utils.dart';
import '../../utility/color_scheme.dart';

class LogoutDialog extends StatelessWidget {
  final Function function;

  const LogoutDialog({
    Key? key,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double radius = FetchPixels.getPixelHeight(40);

    double height = FetchPixels.getPixelHeight(90);
    double width = FetchPixels.getDialogWidth();
    return StatefulBuilder(builder: (context, setState) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        elevation: 0.0,
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        child: Container(
          // height: height,
          width: width,
          padding: EdgeInsets.all(FetchPixels.getDefaultHorSpace(context)),
          decoration: getDefaultDecoration(
              radius: radius, bgColor: getCardColor(context)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: getScreenPercentSize(context, 2)),
              getTextWidget1(
                  Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                  "Are you sure you want to\nlogout",
                  TextAlign.center,
                  getScreenPercentSize(context, 2.5)),


              SizedBox(height: getScreenPercentSize(context, 4)),
              Row(
                children: [


                  Expanded(
                      child: getBorderButtonWidget(context, "Cancel", () {
                    Navigator.pop(context);
                  },
                          horizontalSpace: 0,
                          verticalSpace: 0,
                          borderColor: getFontColor(context),
                          textColor: getFontColor(context),
                          borderWidth: 1,
                          btnHeight: height,
                          color: Colors.transparent)),

                  getHorizontalSpace(35),

                  Expanded(
                      child: getButtonWidget(context, "Yes", () {
                    Navigator.pop(context);

                    function();
                  }, horizontalSpace: 0, verticalSpace: 0,btnHeight: height)),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
