import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:launch_review/launch_review.dart';

import '../../resizer/fetch_pixels.dart';
import '../../resizer/widget_utils.dart';
import '../../utility/Constants.dart';
import '../../utility/color_scheme.dart';
import '../feedback_screen.dart';


class RateViewDialog extends StatelessWidget {

  const RateViewDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double starSize = FetchPixels.getPixelHeight(80);
    double radius = FetchPixels.getPixelHeight(40);

    double width = FetchPixels.getDialogWidth();
    double rate=0;
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

              width: width,
              padding: EdgeInsets.all(FetchPixels.getDefaultHorSpace(context)),
              decoration: getDefaultDecoration(
                  radius: radius, bgColor: getCardColor(context)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(80),
                        vertical: FetchPixels.getPixelHeight(80)),
                    child: Align(
                      alignment: Alignment.topRight,
                      child:  Image.asset("${assetPath}rate.png"),
                    ),
                  ),

                  getTextWidget1(Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                      "Give Your Opinion", TextAlign.center, getScreenPercentSize(context,2.5)),


                  SizedBox(height: getScreenPercentSize(context, 1.5)),

                  getTextWidget1(Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w400,
                  ),
                      "Make better math goal for you,and would love to know how would rate our app?",
                      TextAlign.center, getScreenPercentSize(context,1.8)),



                  SizedBox(height: getScreenPercentSize(context, 3)),

                  RatingBar(
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(
                          horizontal: FetchPixels.getPixelHeight(15)),
                      allowHalfRating: false,
                      itemSize: starSize,
                      initialRating: 0,
                      updateOnDrag: true,
                      glowColor: Theme.of(context).scaffoldBackgroundColor,
                      ratingWidget: RatingWidget(
                        full: getSvgImageWithSize(
                            context, "star_fill.svg", starSize, starSize),
                        empty: getSvgImageWithSize(
                            context, "star.svg", starSize, starSize),
                        half: getSvgImageWithSize(
                            context, "star_fill.svg", starSize, starSize),
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {

                          rate = rating;
                        });

                      }),

                  SizedBox(height: getScreenPercentSize(context, 5)),
                  Row(
                    children: [

                      Expanded(child: getBorderButtonWidget(context,  "Cancel", (){
                        Navigator.pop(context);
                      },horizontalSpace: 0,verticalSpace: 0,borderColor: getFontColor(context),textColor: getFontColor(context),
                      borderWidth: 1,color: Colors.transparent)),

                      getHorizontalSpace(35),

                      Expanded(child: getButtonWidget(context,  "Submit", (){
                        Navigator.pop(context);
                        if(rate >= 3) {
                          pushPage(const FeedbackScreen());
                        }else{
                          LaunchReview.launch();
                        }

                      },horizontalSpace: 0,verticalSpace: 0)),


                    ],
                  )



                ],
              ),
            ),
          );


        }
    );
  }
}
