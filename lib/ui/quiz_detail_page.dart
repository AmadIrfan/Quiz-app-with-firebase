// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../utility/constants.dart';
import '../model/history_model.dart';
import '../resizer/widget_utils.dart';
import '../utility/color_scheme.dart';
import '../resizer/fetch_pixels.dart';
import '../provider/quiz_provider.dart';

class QuizDetailPage extends StatefulWidget {
  final List<HistoryModel> historyDetail;

  const QuizDetailPage({super.key, required this.historyDetail});

  @override
  State<StatefulWidget> createState() {
    return _QuizDetailPage();
  }
}

class _QuizDetailPage extends State<QuizDetailPage> {
  ValueNotifier<int> position = ValueNotifier(0);
  ValueNotifier<int> timer = ValueNotifier(0);

  onBackClick() {
    backPage();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: getNoneAppBar(context, color: getBackgroundColor(context)),
          body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getCommonAppBar(context, title: 'Answer Key', function: () {
                    onBackClick();
                  }),
                  getVerticalSpace(20),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: FetchPixels.getDefaultHorSpace(context)),
                    child: getCustomFont('Quiz Details',
                        FetchPixels.getPixelHeight(100), getFontColor(context), 1,
                        fontWeight: FontWeight.w700),
                  ),
                  Expanded(
                    flex: 1,
                    child: ListView.builder(
                      itemCount: widget.historyDetail.length,
                      itemBuilder: (context, index) {
                        HistoryModel model = widget.historyDetail[index];

                        return Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: FetchPixels.getDefaultHorSpace(context),
                              vertical: FetchPixels.getPixelHeight(25)),
                          padding: EdgeInsets.all(
                              FetchPixels.getDefaultHorSpace(context)),
                          decoration: getCommonDecoration(context),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Image.network(
                                  errorBuilder: (context, error, stackTrace) {
                                    return getErrorBuilder();
                                  },
                                  '${model.image}',
                                  height: FetchPixels.getPixelHeight(160),
                                  width: FetchPixels.getPixelHeight(160),
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    } else {
                                      return getProgressDialog(context);
                                    }
                                  },
                                ),
                              ),
                              getVerticalSpace(40),
                              getCustomFont(
                                  'Question ${(index+1)}:',
                                  FetchPixels.getPixelHeight(75),
                                  getSubFontColor(context),
                                  1,
                                  fontWeight: FontWeight.w400),
                              getVerticalSpace(13),
                              getTextWidget(
                                  model.question!,
                                  FetchPixels.getPixelHeight(80),
                                  getFontColor(context),
                                  fontWeight: FontWeight.w600),
                              getVerticalSpace(45),
                              getCustomFont(
                                  'Selected answer:',
                                  FetchPixels.getPixelHeight(75),
                                  getSubFontColor(context),
                                  1,
                                  fontWeight: FontWeight.w400),
                              getVerticalSpace(13),
                              getTextWidget(
                                  model.selectedAnswer!,
                                  FetchPixels.getPixelHeight(80),
                                  getFontColor(context),
                                  fontWeight: FontWeight.w600),
                              getVerticalSpace(45),
                              getCustomFont(
                                  'Correct answer:',
                                  FetchPixels.getPixelHeight(75),
                                  getSubFontColor(context),
                                  1,
                                  fontWeight: FontWeight.w400),
                              getVerticalSpace(13),
                              getTextWidget(
                                  model.answer!,
                                  FetchPixels.getPixelHeight(80),
                                  getFontColor(context),
                                  fontWeight: FontWeight.w600),
                              getVerticalSpace(50),
                              getSelectedButton(
                                  (model.type == null) ? skipped : model.type!)
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )),
        ),
        onWillPop: () async {
          onBackClick();
          return false;
        });
  }

  getSelectedButton(int type) {
    if (type == wrongType) {
      return getWrongButton();
    } else if (type == correct) {
      return getCorrectButton();
    } else {
      return getSkipButton(context);
    }
  }
}
