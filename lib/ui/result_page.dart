// ignore_for_file: deprecated_member_use

import 'package:flutter_logical_quiz/ui/home_page.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../ads/AdsFile.dart';
import '../model/data_model.dart';
import '../utility/constants.dart';
import '../ui/quiz_detail_page.dart';
import '../model/history_model.dart';
import '../resizer/fetch_pixels.dart';
import '../utility/color_scheme.dart';
import '../resizer/widget_utils.dart';
import '../provider/app_controller.dart';
import '../provider/login_controller.dart';
import '../ui/commonWidget/common_result_widget.dart';

class ResultPage extends StatefulWidget {
  final DataModel dataModel;
  final List<HistoryModel> historyDetail;
  const ResultPage({
    super.key,
    required this.dataModel,
    required this.historyDetail,
  });

  @override
  State<StatefulWidget> createState() {
    return _ResultPage();
  }
}

class _ResultPage extends State<ResultPage> {
  ValueNotifier<int> position = ValueNotifier(0);
  ValueNotifier<int> timer = ValueNotifier(0);

  String user = '';
  // AdsFile? adsFile;

  onBackClick() {
    backPage();
  }

  @override
  void dispose() {
    super.dispose();
    // disposeInterstitialAd(adsFile);
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      // adsFile = AdsFile(context);
      // adsFile!.createInterstitialAd();

      AppController appController = Get.put(AppController(isFetchData: false));
      appController.setReportData(dataModel: widget.dataModel);

      user = await LoginController().getUser();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: getNoneAppBar(context, color: getBackgroundColor(context)),
          body: SafeArea(
              child: Column(
            children: [
              getCommonAppBar(context, title: 'Result', function: () {
                onBackClick();
              }, widget: Container()),
              // }, widget: CommonCoinWidget()),
              getVerticalSpace(20),
              Expanded(
                flex: 1,
                child: user.isNotEmpty
                    ? CommonResultWidget(
                        dataModel: widget.dataModel, user: user)
                    : Container(),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: FetchPixels.getDefaultHorSpace(context)),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: getBorderButtonWidget(context, 'Back To Topic',
                          () {
                        Get.to(
                          HomePage(),
                        );
                        // backPage();
                      },
                          borderColor: getFontColor(context),
                          horizontalSpace: 0),
                    ),
                    getHorizontalSpace(defaultWidth),
                    Expanded(
                      flex: 1,
                      child: getButtonWidget(context, 'Review Answer', () {
                        // showInterstitialAd(adsFile, () {
                        pushPage(QuizDetailPage(
                            historyDetail: widget.historyDetail));
                        // });
                      }, horizontalSpace: 0),
                    )
                  ],
                ),
              )
            ],
          )),
        ),
        onWillPop: () async {
          onBackClick();
          return false;
        });
  }
}
