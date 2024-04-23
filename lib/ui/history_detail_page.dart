

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_logical_quiz/resizer/fetch_pixels.dart';
import 'package:flutter_logical_quiz/resizer/widget_utils.dart';
import 'package:flutter_logical_quiz/utility/app_theme.dart';

import '../model/option_data.dart';
import '../model/history_model.dart';
import '../provider/quiz_provider.dart';
import 'commonWidget/common_quiz_button_widget.dart';
import 'package:flutter_logical_quiz/utility/constants.dart';
import 'package:flutter_logical_quiz/utility/color_scheme.dart';


class HistoryDetailPage extends StatefulWidget {

  final List<HistoryModel>? historyList;
  const HistoryDetailPage({super.key, this.historyList});


  @override
  State<StatefulWidget> createState() {
    return _HistoryDetailPage();
  }
}

class _HistoryDetailPage extends State<HistoryDetailPage> {
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
                      itemCount: widget.historyList!.length,
                      itemBuilder: (context, index) {

                        HistoryModel model=widget.historyList![index];




                        int quizType=model.quizType!;







                        List<String> result = [];
                        if(quizType==0){
                          OptionData  optionData = model.optionData!;


                          result = getOptionData(optionData);
                        }else{
                          result.add('True');
                          result.add('False');
                        }




                        return Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: FetchPixels.getDefaultHorSpace(context),
                              vertical: FetchPixels.getPixelHeight(25)),
                          padding: EdgeInsets.all(
                              FetchPixels.getDefaultHorSpace(context)),
                          decoration: getCommonDecoration(context),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.network(
                                height: FetchPixels.getPixelHeight(160),
                                width: FetchPixels.getPixelHeight(160),
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  } else {
                                    return getProgressDialog(context);
                                  }
                                },

                                errorBuilder: (context, error, stackTrace) {
                                  return getErrorBuilder(

                                  );
                                },
                                model.image!,


                              ),

                              getVerticalSpace(50),
                              getTextWidget(
                                  model.question!,
                                  FetchPixels.getPixelHeight(80),
                                  getFontColor(context),

                                  fontWeight: FontWeight.w600,textAlign: TextAlign.center),

                              getVerticalSpace(50),


                                ListView.builder(
                                  itemCount: result.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {


                                    Color? color;

                                    if(result[index].trim() == model.answer.toString().trim())
                                    {
                                      color=greenColor;
                                    }else if (result[index].trim() == model.selectedAnswer.toString().trim()){
                                      color=redColor;
                                    }


                                  return CommonQuizButtonWidget(optionType: model.quizType == 1?'':getOptionType(index),
                                    option: result[index],
                                    isTrue: false,
                                    color:(color==null)?null:color,
                                    isSelected: false,);
                                },),


                              getVerticalSpace(20),
                              getSelectedButton(model.type!),
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

  getSelectedButton(int type){
    if(type == wrongType){
      return getWrongButton();
    }else  if(type == correct){
      return getCorrectButton();
    }else{
    return  getSkipButton(context);
    }
  }


}
