
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:flutter_logical_quiz/provider/history_controller.dart';

import '../overview_panel_page.dart';
import '../../model/topic_model.dart';
import '../../utility/constants.dart';
import '../../utility/app_theme.dart';
import '../../model/detail_model.dart';
import '../../resizer/fetch_pixels.dart';
import '../../resizer/widget_utils.dart';
import '../../utility/color_scheme.dart';
import '../../provider/theme_controller.dart';
import '../../provider/topic_controller.dart';
import '../../provider/data/FirebaseData.dart';

class MainHistoryPage extends StatelessWidget {
  final String? currentUser;
  // final AdsFile adsFile;
  MainHistoryPage({
    super.key,
    this.currentUser,
    // required this.adsFile,
  });

  final TopicController topicController = Get.put(TopicController());

  final HistoryController historyController = Get.put(HistoryController());

  @override
  Widget build(BuildContext context) {
    var circle = FetchPixels.getPixelHeight(145);
    var stepSize = FetchPixels.getPixelHeight(14);
    return Builder(
      builder: (context) {
        return Stack(
          children: [
            getCommonHeader(
              context,
              widget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getHeaderTitle("History", context),
                  getVerticalSpace(10),
                  getCustomFont('Choose a topic to view history',
                      FetchPixels.getPixelHeight(80), Colors.white, 1,
                      fontWeight: FontWeight.w400)
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: getHeaderTopMargin()),
              child: Obx(() {
                if (topicController.isLoading.value) {
                  return getProgressDialog(context);
                } else {
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(
                        horizontal: FetchPixels.getDefaultHorSpace(context)),
                    itemCount: topicController.list.length,
                    itemBuilder: (context, index) {
                      TopicModel model =
                          TopicModel.fromFirestore(topicController.list[index]);

                      return DelayedDisplay(
                        delay: Duration(milliseconds: (index + 1) * 100),
                        slidingCurve: Curves.decelerate,
                        child: Container(
                          margin: EdgeInsets.only(
                              bottom: FetchPixels.getPixelHeight(40)),
                          decoration: getDefaultDecoration(
                              isShadow: true,
                              shadowColor: getShadowColor(context),
                              radius: FetchPixels.getPixelHeight(25),
                              bgColor: getCardColor(context)),
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  FetchPixels.getDefaultHorSpace(context),
                              vertical: FetchPixels.getPixelHeight(40)),
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection(FirebaseData.historyList)
                                .doc(currentUser)
                                .collection(
                                    '${FirebaseData.dataList}${model.refId}')
                                .snapshots(),
                            builder: (context, snapshot) {
                              int i = 0;
                              int right = 0;
                              List<DocumentSnapshot> list = [];
                              if (snapshot.hasData &&
                                  snapshot.connectionState ==
                                      ConnectionState.active) {
                                i = snapshot.data!.docs.length;
                                list = snapshot.data!.docs;

                                for (int i = 0; i < list.length; i++) {
                                  DetailModel model =
                                      DetailModel.fromFirestore(list[i]);
                                  right = right + model.right!;
                                }
                              }

                              if (i != 0) {
                                right = (right * 10) ~/ i;
                              }
                              return InkWell(
                                onTap: () {
                                  if (i > 0) {
                                    // showInterstitialAd(adsFile, () {
                                    pushPage(OverViewPanelPage(list));
                                    // });
                                  } else {
                                    showCustomToast(
                                      context: context,
                                      message:
                                          'Please read the practice to unlock history.',
                                    );
                                  }
                                },
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: (circle),
                                      height: (circle),
                                      child: Stack(
                                        children: [
                                          CircularStepProgressIndicator(
                                            totalSteps: 100,
                                            currentStep: getCurrentStep(i, 100),
                                            stepSize: stepSize,
                                            selectedColor: primaryColor,
                                            unselectedColor: cellColor,
                                            padding: 0,
                                            width: circle,
                                            height: circle,
                                            selectedStepSize: stepSize,
                                            roundedCap: (_, __) => true,
                                          ),
                                          i == 0
                                              ? Center(
                                                  child: GetBuilder<
                                                      ThemeController>(
                                                    builder: (value) {
                                                      return SvgPicture.asset(
                                                        getThemeIcon(
                                                            value, 'lock.svg'),
                                                        width: FetchPixels
                                                            .getPixelHeight(50),
                                                        height: FetchPixels
                                                            .getPixelHeight(50),
                                                      );
                                                    },
                                                    init: ThemeController(),
                                                  ),
                                                )
                                              : Center(
                                                  child: getCustomFont(
                                                      '$right',
                                                      FetchPixels
                                                          .getPixelHeight(80),
                                                      getFontColor(context),
                                                      1,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                        ],
                                      ),
                                    ),
                                    getHorizontalSpace(30),
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          getCustomFont(
                                              model.title!,
                                              FetchPixels.getPixelHeight(85),
                                              getFontColor(context),
                                              1,
                                              fontWeight: FontWeight.w600),
                                          getVerticalSpace(20),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    FetchPixels.getPixelWidth(
                                                        18),
                                                vertical:
                                                    FetchPixels.getPixelHeight(
                                                        15)),
                                            decoration: BoxDecoration(
                                                color: i > 0
                                                    ? getSubSelected(context)
                                                    : getSubColor(context),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(FetchPixels
                                                        .getPixelHeight(50)))),
                                            child: getCustomFont(
                                                'Quizzes attempted : $i',
                                                FetchPixels.getPixelHeight(75),
                                                getFontColor(context),
                                                1,
                                                fontWeight: FontWeight.w500,
                                                textAlign: TextAlign.center),
                                          )
                                        ],
                                      ),
                                    ),
                                    Image.asset(
                                      '${assetPath}next.png',
                                      color: getFontColor(context),
                                      height: FetchPixels.getPixelHeight(25),
                                      width: FetchPixels.getPixelHeight(25),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  );
                }
              }),
            )
          ],
        );
      },
    );
  }
}
