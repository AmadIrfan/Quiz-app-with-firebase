import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../../model/quiz_model.dart';
import '../../utility/constants.dart';
import '../../utility/app_theme.dart';
import '../../utility/color_scheme.dart';
import '../../resizer/fetch_pixels.dart';
import '../../resizer/widget_utils.dart';
import '../../provider/quiz_provider.dart';
import 'common_quiz_button_widget.dart';

class CommonMainWidget extends StatelessWidget {
  final QuizModel quizModel;
  final QuizProvider controller;
  final Function onQuit;
  final bool isFirstPurchased;

  const CommonMainWidget(
      {super.key,
      required this.quizModel,
      required this.controller,
      required this.onQuit,
      required this.isFirstPurchased});

  @override
  Widget build(BuildContext context) {
    print('============= $isFirstPurchased  ]]]]');
    double marginTop = FetchPixels.getPixelHeight(230);
    double appBarHeight = FetchPixels.getPixelHeight(270);
    var circle = FetchPixels.getPixelHeight(200);
    var margin = FetchPixels.getDefaultHorSpace(context);
    var radius = FetchPixels.getPixelHeight(30);
    var stepSize = FetchPixels.getPixelHeight(17);
    var imageSize = FetchPixels.getPixelHeight(230);

    return Stack(
      children: [
        SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(
                      left: margin, right: margin, top: marginTop),
                  decoration: getCommonDecoration(context),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  FetchPixels.getDefaultHorSpace(context)),
                          margin: EdgeInsets.only(
                              top: FetchPixels.getPixelHeight(150),
                              bottom: FetchPixels.getPixelHeight(60)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              getVerticalSpace(20),
                              quizModel.image == null ||
                                      quizModel.image!.isEmpty
                                  ? Container()
                                  : Image.network(
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return getErrorBuilder();
                                      },
                                      '${quizModel.image}',
                                      height: imageSize,
                                      width: imageSize,
                                    ),
                              getVerticalSpace(10),
                              Expanded(
                                  child: Center(
                                child: SingleChildScrollView(
                                  child: getTextWidget(
                                      quizModel.question!,
                                      FetchPixels.getPixelHeight(80),
                                      getFontColor(context),
                                      fontWeight: FontWeight.w600,
                                      textAlign: TextAlign.center),
                                ),
                              ))
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal:
                                FetchPixels.getDefaultHorSpace(context)),
                        child: Column(
                            children: quizModel.type == 1
                                ? List.generate(
                                    2,
                                    (index) {
                                      String answer = 'False';
                                      if (index == 0) {
                                        answer = 'True';
                                      }

                                      bool isSelected =
                                          quizModel.answerPosition == index;

                                      return CommonQuizButtonWidget(
                                        optionType: '',
                                        option: answer,
                                        isTrue: true,
                                        isSelected: isSelected,
                                        function: () {
                                          controller.setAnswer(index);
                                        },
                                      );
                                    },
                                  )
                                : List.generate(
                                    quizModel.optionList!.length,
                                    (index) {
                                      String answer =
                                          quizModel.optionList![index];
                                      bool isSelected =
                                          quizModel.answerPosition == index;

                                      return CommonQuizButtonWidget(
                                        optionType: getOptionType(index),
                                        option: answer,
                                        isSelected: isSelected,
                                        isTrue: false,
                                        function: () {
                                          controller.setAnswer(index);
                                        },
                                      );
                                    },
                                  )),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: FetchPixels.getDefaultHorSpace(context)),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: getBorderButtonWidget(context, 'Quit', () {
                        // backPage();
                        onQuit();
                      },
                          borderColor: getFontColor(context),
                          horizontalSpace: 0),
                    ),
                    getHorizontalSpace(defaultWidth),
                    Expanded(
                      flex: 1,
                      child: getButtonWidget(context, 'Next', () {
                        print('2===============> $isFirstPurchased');
                        controller.nextQuiz(isFirstPurchased);
                      }, horizontalSpace: 0),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          height: appBarHeight,
          color: getCardColor(context),
          margin: EdgeInsets.symmetric(horizontal: (margin * 2.3)),
          child: Transform.rotate(
            angle: math.pi,
            child: SizedBox(
              height: appBarHeight,
              child: Scaffold(
                extendBody: true,

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
                  child: Transform.rotate(
                    angle: math.pi,
                    child: Stack(
                      children: [
                        CircularStepProgressIndicator(
                          totalSteps: controller.totalTime,
                          currentStep: getCurrentStep(
                              controller.currentTime, controller.totalTime),
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
                          child: getCustomFont(
                              secToTime(controller.currentTime),
                              FetchPixels.getPixelHeight(90),
                              getFontColor(context),
                              1,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                ),
                bottomNavigationBar: Container(
                    height: (appBarHeight),
                    decoration: getDefaultDecoration(
                        radius: radius,
                        shadowColor: getQuizShadowColor(context)),
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
                      ),
                    )),

                //
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: (appBarHeight),
            // color: Colors.red,
            // alignment: Alignment.center,
            margin: EdgeInsets.only(top: FetchPixels.getPixelHeight(42)),
            child: getCustomFont(
                'Question:${(controller.position + 1)}/${controller.list.length}',
                FetchPixels.getPixelHeight(110),
                Colors.white,
                1,
                fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}
