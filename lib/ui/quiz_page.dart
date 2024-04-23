// ignore_for_file: deprecated_member_use

import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../utility/constants.dart';
import '../model/topic_model.dart';
import '../resizer/fetch_pixels.dart';
import '../resizer/widget_utils.dart';
import '../utility/color_scheme.dart';
import '../provider/quiz_provider.dart';
import '../provider/data_controller.dart';
import 'commonWidget/common_main_widget.dart';
import '../ui/commonWidget/back_dialog_view.dart';

class QuizPage extends StatefulWidget {
  final TopicModel topicModel;
  final bool isFirstPurchased;
  const QuizPage({
    super.key,
    required this.topicModel,
    required this.isFirstPurchased,
  });

  @override
  State<StatefulWidget> createState() {
    return _QuizPage();
  }
}

class _QuizPage extends State<QuizPage> {
  ValueNotifier<int> position = ValueNotifier(0);
  ValueNotifier<int> timer = ValueNotifier(0);

  DataController? dataController;

  onBackClick(QuizProvider quizProvider) {
    quizProvider.pauseTimer();

    onBackDialog(quizProvider);
  }

  @override
  void initState() {
    super.initState();
    dataController = Get.put(DataController(widget.topicModel.refId!));
    setState(() {});
  }

  onBackDialog(QuizProvider quizProvider) {
    double radius = FetchPixels.getPixelHeight(50);

    showModalBottomSheet(
      context: context,
      builder: (context) => BackDialogView(function: () {
        quizProvider.cancelTimer();
        quizProvider.removeObserver();
        backPage(value: true);
      }),
      backgroundColor: getBackgroundColor(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radius),
            topRight: Radius.circular(radius)),
      ),
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
    ).then((value) {
      if (value) {
        quizProvider.resumeTimer();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getNoneAppBar(context, color: getBackgroundColor(context)),
      body: SafeArea(
        child: Obx(() {
          print(dataController!.isLoading.value);
          if (dataController!.isLoading.value) {
            return getProgressDialog(context);
          } else {
            if (dataController!.list.isNotEmpty) {
              return GetBuilder<QuizProvider>(
                  init: QuizProvider(
                      buildContext: context,
                      topicModel: widget.topicModel,
                      documentList: dataController!.list),
                  builder: (model) {
                    if (model.quizModel == null) {
                      return getProgressDialog(context);
                    }
                    return WillPopScope(
                        child: Column(
                          children: [
                            getCommonAppBar(context,
                                title: widget.topicModel.title!, function: () {
                              onBackClick(model);
                            }, widget: Container()),
                            getVerticalSpace(20),
                            Expanded(
                              child: CommonMainWidget(
                                quizModel: model.quizModel!,
                                controller: model,
                                isFirstPurchased: widget.isFirstPurchased,
                                onQuit: () {
                                  onBackClick(model);
                                  if (widget.isFirstPurchased) {
                                    Get.back();
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                        onWillPop: () async {
                          onBackClick(model);
                          return false;
                        });
                  });
            }
            return Container();
          }
        }),
      ),
    );
  }
}
