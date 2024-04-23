import 'package:flutter/material.dart';

import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../../utility/constants.dart';
import '../../utility/app_theme.dart';
import '../../utility/color_scheme.dart';
import '../../resizer/fetch_pixels.dart';
import '../../resizer/widget_utils.dart';
import '../../provider/quiz_provider.dart';


class CommonDataWidget extends StatelessWidget {
  final String title;
  final String progress;
  final int avg;
  final String desc;
  final String title1;
  final String title2;
  final String data1;
  final String data2;
  final int? outTime;
  const CommonDataWidget({super.key, required this.title,required this.progress,required this.desc,
    required this.title1,
    required this.avg,

    required this.title2,
    required this.data1,
    required this.data2,
     this.outTime,
  });


  @override
  Widget build(BuildContext context) {
    var circle = getScreenWidthPercentSize(context, 30);
    // var circle = FetchPixels.getPixelHeight(250);
    var stepSize = FetchPixels.getPixelHeight(24);

    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: FetchPixels.getDefaultHorSpace(context),
      ),
      padding: EdgeInsets.all(
          FetchPixels.getDefaultHorSpace(context)),
      decoration: getCommonDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getCustomFont(
              title,
              FetchPixels.getPixelHeight(95),
              getFontColor(context),
              2,
              fontWeight: FontWeight.w700,textAlign: TextAlign.center),

          getVerticalSpace(30),



          Row(
            children: [

                 Expanded(flex: 1,child: Align(
                   alignment: Alignment.centerLeft,
                   child: SizedBox(
                     width: (circle),
                     height: (circle),
                     child: Stack(
                       children: [
                         CircularStepProgressIndicator(
                           totalSteps: 100,
                           currentStep: getCurrentStep(avg,100),
                           stepSize: stepSize,
                           selectedColor: primaryColor,
                           unselectedColor: getReportColor(context),
                           padding: 0,
                           width: circle,
                           height: circle,
                           selectedStepSize: stepSize,

                           roundedCap: (_, __) => true,
                         ),
                         Center(
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.center,
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               getCustomFont(
                                   progress,
                                   FetchPixels.getPixelHeight(120),
                                   getFontColor(context),
                                   1,
                                   fontWeight: FontWeight.w700),


                               getCustomFont(
                                   desc,
                                   FetchPixels.getPixelHeight(70),
                                   getFontColor(context),
                                   1,
                                   fontWeight: FontWeight.w500,textAlign: TextAlign.center),

                             ],
                           ),
                         )
                       ],

                     ),
                   ),
                 ),),



              Expanded(flex: 1,child: Column(
                children: [
                  getItemData(context: context,title: title1,isFirst: true,data: data1),
                  getVerticalSpace(30),
                  getItemData(context: context,title: title2,isFirst: false,data: data2),
                ],
              ),)

            ],
          )




        ],
      ),
    );
  }

  getItemData({required BuildContext context,
    required String title,
    required String data,
    required bool isFirst}){
    return Container(
      padding: EdgeInsets.symmetric(vertical:
          FetchPixels.getPixelHeight(40)),
      decoration: getDefaultDecoration(radius: FetchPixels.getPixelHeight(20),bgColor: getReportColor(context)),

      child: Column(
        children: [
          getCustomFont(
              title,
              FetchPixels.getPixelHeight(65),
              getFontColor(context),
              1,
              fontWeight: FontWeight.w400,textAlign: TextAlign.center),

          getVerticalSpace(15),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getCustomFont('$data/', FetchPixels.getPixelHeight(140),
                  isFirst?   greenColor:redColor, 1,
                  fontWeight: FontWeight.w700,
                  textAlign: TextAlign.end),
              Container(
                margin: EdgeInsets.only(
                    top: FetchPixels.getPixelHeight(18)),
                child: getCustomFont(
                    (outTime==null)?'100':secToTime(quizTime),
                    FetchPixels.getPixelHeight(70),
                    getFontColor(context),
                    1,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.end),
              ),
            ],
          )


        ],
      ),
    );
  }


}
