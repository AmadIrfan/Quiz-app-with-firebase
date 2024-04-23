// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_logical_quiz/utility/app_theme.dart';
import 'package:flutter_logical_quiz/utility/constants.dart';
import 'package:flutter_logical_quiz/resizer/fetch_pixels.dart';
import 'package:flutter_logical_quiz/resizer/widget_utils.dart';
import 'package:flutter_logical_quiz/utility/color_scheme.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../ads/AdsFile.dart';
import 'history_detail_page.dart';
import '../model/detail_model.dart';
import '../model/FetchHistoryData.dart';
import 'commonWidget/common_result_button.dart';

class OverViewPanelPage extends StatefulWidget {
  final List<DocumentSnapshot> list;

  const OverViewPanelPage(this.list, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _OverViewPanelPage();
  }
}

class _OverViewPanelPage extends State<OverViewPanelPage> {
  ValueNotifier<int> position = ValueNotifier(0);
  ValueNotifier<int> timer = ValueNotifier(0);
  AdsFile? adsFile;

  onBackClick() {
    backPage();
  }

  @override
  void dispose() {
    super.dispose();
    disposeBannerAd(adsFile);
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      adsFile = AdsFile(context);
      adsFile!.createAnchoredBanner(context, setState);
    });
  }

  @override
  Widget build(BuildContext context) {
    double btnHeight = FetchPixels.getPixelHeight(100);
    double fontSize = FetchPixels.getPixelHeight(60);

    var circle = FetchPixels.getPixelHeight(165);
    var stepSize = FetchPixels.getPixelHeight(17);

    return WillPopScope(
        child: Scaffold(
          appBar: getNoneAppBar(context, color: getBackgroundColor(context)),
          body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getCommonAppBar(context, title: '', function: () {
                    onBackClick();
                  }),
                  getVerticalSpace(20),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: FetchPixels.getDefaultHorSpace(context)),
                    child: getCustomFont('Overview Panel',
                        FetchPixels.getPixelHeight(100), getFontColor(context), 1,
                        fontWeight: FontWeight.w700),
                  ),
                  Expanded(
                    flex: 1,
                    child: ListView.builder(
                      itemCount: widget.list.length,
                      itemBuilder: (context, index) {
                        DetailModel model =
                            DetailModel.fromFirestore(widget.list[index]);

                        int i = 0;
                        int right = 0;




                        FetchHistoryData historyData =
                            FetchHistoryData.fromJson(jsonDecode(model.list!));

                        if (i != 0) {
                          right = (right * 10) ~/ i;
                        }

                        return Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: FetchPixels.getDefaultHorSpace(context),
                              vertical: FetchPixels.getPixelHeight(25)),
                          padding: EdgeInsets.all(
                              FetchPixels.getDefaultHorSpace(context)),
                          decoration: getCommonDecoration(context),
                          child: Stack(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      getCustomFont(
                                          'Date',
                                          FetchPixels.getPixelHeight(75),
                                          getSubFontColor(context),
                                          1,
                                          fontWeight: FontWeight.w400),

                                      getVerticalSpace(13),

                                      getCustomFont(
                                          model.date!,
                                          FetchPixels.getPixelHeight(80),
                                          getFontColor(context),
                                          2,
                                          fontWeight: FontWeight.w600),

                                      getVerticalSpace(50),

                                      getCustomFont(
                                          'Time Taken',
                                          FetchPixels.getPixelHeight(75),
                                          getSubFontColor(context),
                                          1,
                                          fontWeight: FontWeight.w400),

                                      getVerticalSpace(13),
                                      Row(
                                        children: [
                                          getCustomFont(
                                              getMinute(model.time!),
                                              FetchPixels.getPixelHeight(80),
                                              getFontColor(context),
                                              1,
                                              fontWeight: FontWeight.w700,
                                              textAlign: TextAlign.end),
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: FetchPixels.getPixelHeight(
                                                    5)),
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
                                              getSeconds(model.time!),
                                              FetchPixels.getPixelHeight(80),
                                              getFontColor(context),
                                              1,
                                              fontWeight: FontWeight.w700,
                                              textAlign: TextAlign.end),
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: FetchPixels.getPixelHeight(
                                                    5)),
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

                                      getCustomFont(
                                          'Attempts',
                                          FetchPixels.getPixelHeight(75),
                                          getSubFontColor(context),
                                          1,
                                          fontWeight: FontWeight.w400),

                                      getVerticalSpace(18),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          CommonResultButton(
                                              btnHeight: btnHeight,
                                              fontSize: fontSize,
                                              data: '${model.right!}',
                                              title: 'Correct',
                                              color: greenColor),
                                          getHorizontalSpace(40),
                                          CommonResultButton(
                                              btnHeight: btnHeight,
                                              data: '${model.skip!}',
                                              title: 'Skipped',
                                              fontSize: fontSize,
                                              color: skipColor),
                                          getHorizontalSpace(40),
                                          CommonResultButton(
                                              btnHeight: btnHeight,
                                              fontSize: fontSize,
                                              data: '${model.wrong!}',
                                              title: 'Wrong',
                                              color: redColor),
                                        ],
                                      ),
                                    ],
                                  )),
                                  getHorizontalSpace(40),
                                  SizedBox(
                                    width: (circle),
                                    height: (circle),
                                    child: Stack(
                                      children: [
                                        CircularStepProgressIndicator(
                                          totalSteps: model.totalQuestion!,
                                          // totalSteps: 100,
                                          currentStep:
                                              getCurrentStep(model.right!, model.totalQuestion!),
                                              // getCurrentStep(model.right!, 100),
                                          stepSize: stepSize,
                                          selectedColor: primaryColor,
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
                                              text: '${(model.right! * 100)~/model.totalQuestion!}',
                                              // text: '${model.right! * 10}',
                                              style: TextStyle(
                                                  fontFamily: fontFamily,
                                                  fontWeight: FontWeight.w700,
                                                  color: getFontColor(context),
                                                  fontSize:
                                                      FetchPixels.getPixelHeight(
                                                          35)),
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: '%',
                                                    style: TextStyle(
                                                        fontFamily: fontFamily,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            getFontColor(context),
                                                        fontSize: FetchPixels
                                                            .getPixelHeight(20))),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Positioned.fill(
                                  child: Align(
                                alignment: Alignment.bottomRight,
                                child: Wrap(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        pushPage(HistoryDetailPage(
                                            historyList:
                                                historyData.list!));
                                      },
                                      child: Container(
                                        width: FetchPixels.getPixelWidth(210),
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                FetchPixels.getPixelHeight(25)),
                                        decoration: getDefaultDecoration(
                                            borderColor: getFontColor(context),
                                            borderWidth: 1,
                                            radius:
                                                FetchPixels.getPixelHeight(20)),
                                        child: Center(
                                          child: getCustomFont(
                                              'Detail',
                                              FetchPixels.getPixelWidth(75),
                                              getFontColor(context),
                                              2,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ))
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  getBanner(context, adsFile)
                ],
              )),
        ),
        onWillPop: () async {
          onBackClick();
          return false;
        });
  }
}
