import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:flutter_logical_quiz/utility/app_theme.dart';
import 'package:flutter_logical_quiz/utility/constants.dart';
import 'package:flutter_logical_quiz/resizer/widget_utils.dart';
import 'package:flutter_logical_quiz/resizer/fetch_pixels.dart';
import 'package:flutter_logical_quiz/utility/color_scheme.dart';
import '../../model/data_model.dart';
import '../../model/detail_model.dart';
import '../../provider/data/FirebaseData.dart';
import '../../provider/quiz_provider.dart';
import 'common_result_button.dart';

class CommonResultWidget extends StatelessWidget {
  final DataModel dataModel;
  final String user;

  const CommonResultWidget({super.key, required this.dataModel,required this.user});

  @override
  Widget build(BuildContext context) {
    double marginTop = FetchPixels.getPixelHeight(250);
    double appBarHeight = FetchPixels.getPixelHeight(330);
    var circle = FetchPixels.getPixelHeight(235);
    var margin = FetchPixels.getDefaultHorSpace(context);
    var radius = FetchPixels.getPixelHeight(30);
    var stepSize = FetchPixels.getPixelHeight(20);
    var horMargin = margin * 2.3;



    return Stack(
      children: [
        Wrap(
          children: [
            Container(
              width: double.infinity,
              margin:
              EdgeInsets.only(left: margin, right: margin, top: marginTop),
              decoration: getCommonDecoration(context),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: (horMargin / 2)),
                margin: EdgeInsets.only(
                    top: FetchPixels.getPixelHeight(270),
                    bottom: FetchPixels.getPixelHeight(60)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        CommonResultButton(
                            data: '${dataModel.right}',
                            title: 'Correct',
                            color: greenColor),
                        getHorizontalSpace(70),
                        CommonResultButton(
                            data: '${dataModel.skip}',
                            title: 'Skipped',
                            color: skipColor),
                        getHorizontalSpace(70),
                        CommonResultButton(
                            data: '${dataModel.wrong}',
                            title: 'Wrong',
                            color: redColor),
                      ],
                    ),
                    getVerticalSpace(120),
                    Row(
                      children: [
                        Image.asset(
                          '${assetPath}timer.png',
                          color: getFontColor(context),
                          height: FetchPixels.getPixelHeight(55),
                          width: FetchPixels.getPixelHeight(55),
                        ),
                        getHorizontalSpace(20),
                        Expanded(
                          flex: 1,
                          child: getCustomFont(
                              'Time Taken',
                              FetchPixels.getPixelHeight(85),
                              getFontColor(context),
                              1,
                              fontWeight: FontWeight.w500,
                              textAlign: TextAlign.start),
                        ),
                        getCustomFont(
                            getMinute(dataModel.time!),
                            FetchPixels.getPixelHeight(140),
                            getFontColor(context),
                            1,
                            fontWeight: FontWeight.w700,
                            textAlign: TextAlign.end),
                        Container(
                          margin: EdgeInsets.only(
                              top: FetchPixels.getPixelHeight(22)),
                          child: getCustomFont(
                              'min',
                              FetchPixels.getPixelHeight(70),
                              getFontColor(context),
                              1,
                              fontWeight: FontWeight.w500,
                              textAlign: TextAlign.end),
                        ),
                        getHorizontalSpace(20),
                        getCustomFont(
                            getSeconds(dataModel.time!),
                            FetchPixels.getPixelHeight(140),
                            getFontColor(context),
                            1,
                            fontWeight: FontWeight.w700,
                            textAlign: TextAlign.end),
                        Container(
                          margin: EdgeInsets.only(
                              top: FetchPixels.getPixelHeight(22)),
                          child: getCustomFont(
                              'sec',
                              FetchPixels.getPixelHeight(70),
                              getFontColor(context),
                              1,
                              fontWeight: FontWeight.w500,
                              textAlign: TextAlign.end),
                        )
                      ],
                    ),
                    getVerticalSpace(50),

                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection(FirebaseData.historyList)
                          .doc(user).collection(
                          '${FirebaseData.dataList}${dataModel.refId}')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData &&
                            snapshot.connectionState ==
                                ConnectionState.active) {
                          List<DocumentSnapshot> list = snapshot.data!
                              .docs;



                          int totalTime = 0;

                          for (int i = 0; i < list.length; i++) {
                            DetailModel model = DetailModel.fromFirestore(
                                list[0]);
                            totalTime = totalTime + model.time!;
                          }




                          return getCustomSlider(
                              context, 'Average', (totalTime).toInt(),
                              totalTime: 2);
                        } else {
                          return Container();
                        }
                      },
                    ),

                    getVerticalSpace(50),
                    getCustomSlider(context, 'Now', dataModel.time!),
                  ],
                ),
              ),
            )
          ],
        ),
        Container(
          height: appBarHeight,
          color: Colors.transparent,
          margin: EdgeInsets.only(
              left: horMargin, right: horMargin, top: (horMargin * 1.2)),
          child: Stack(
            children: [
              SizedBox(
                height: appBarHeight,
                child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  backgroundColor: Colors.transparent,
                  primary: false,
                  appBar: AppBar(
                    bottomOpacity: 0.0,
                    title: const Text(''),
                    toolbarHeight: 0,
                    elevation: 0,
                  ),
                  floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
                  floatingActionButton: SizedBox(
                    width: (circle),
                    height: (circle),
                    child: Stack(
                      children: [
                        CircularStepProgressIndicator(
                          totalSteps: dataModel.totalQuestion!,
                          currentStep: getCurrentStep(dataModel.right!, dataModel.totalQuestion!),

                          stepSize: stepSize,
                          selectedColor: greenColor,
                          unselectedColor: cellColor,
                          padding: 0,
                          width: circle,
                          height: circle,
                          selectedStepSize: stepSize,
                          roundedCap: (_, __) => true,
                        ),
                        Center(
                          child: RichText(
                            text: TextSpan(
                              text: '${(dataModel.right! * 100)~/dataModel.totalQuestion!}',
                              // text: '${dataModel.right! * 10}',
                              style: TextStyle(
                                  fontFamily: fontFamily,
                                  fontWeight: FontWeight.w700,
                                  color: getFontColor(context),
                                  fontSize: FetchPixels.getPixelHeight(60)),
                              children: <TextSpan>[
                                TextSpan(
                                    text: '%',
                                    style: TextStyle(
                                        fontFamily: fontFamily,
                                        fontWeight: FontWeight.w600,
                                        color: getFontColor(context),
                                        fontSize:
                                        FetchPixels.getPixelHeight(40))),
                              ],
                            ),

                          ),
                        )
                      ],
                    ),
                  ),
                  bottomNavigationBar: Container(
                    height: (appBarHeight),
                    decoration: getDefaultDecoration(radius: radius,shadowColor: getQuizShadowColor(context)),
                    child: ClipRRect(
                      clipBehavior: Clip.antiAlias,
                      borderRadius: BorderRadius.all(
                        Radius.circular(radius),
                      ),
                      child: BottomAppBar(
                        color: subColor,
                        elevation: 0,
                        shape: const CircularNotchedRectangle(),
                        notchMargin: (10),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const <Widget>[
                            Expanded(
                              flex: 1,
                              child: SizedBox(width: 0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: FetchPixels.getPixelHeight(185),
                  child: Center(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          vertical: FetchPixels.getPixelHeight(23)),
                      margin: EdgeInsets.symmetric(horizontal: (horMargin / 2)),
                      decoration: BoxDecoration(
                          color: getBackgroundColor(context),
                          borderRadius:
                          BorderRadius.all(Radius.circular((radius * 2)))),
                      child: getCustomFont(
                          'Submitted at: ${getCurrentDate()}',
                          FetchPixels.getPixelHeight(85),
                          getFontColor(context),
                          1,
                          fontWeight: FontWeight.w600,
                          textAlign: TextAlign.center),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  getCustomSlider(BuildContext context, String s, int current,
      {int? totalTime}) {


    int i = totalTime == null ? quizTime : (quizTime * totalTime);
    return Row(
      children: [
        SizedBox(
          width: FetchPixels.getPixelWidth(200),
          child: getCustomFont(
              s, FetchPixels.getPixelHeight(85), getFontColor(context), 1,
              fontWeight: FontWeight.w500, textAlign: TextAlign.start),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            clipBehavior: Clip.antiAlias,
            child: StepProgressIndicator(
              totalSteps: i,
              currentStep:getCurrentStep (current,i),
              size: FetchPixels.getPixelHeight(25),
              padding: 0,
              selectedColor: primaryColor,
              unselectedColor: cellColor,
              roundedEdges: const Radius.circular(10),
            ),
          ),
        )
      ],
    );
  }
}
