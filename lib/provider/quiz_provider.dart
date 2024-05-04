import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../ui/result_page.dart';
import 'data/FirebaseData.dart';
import '../model/quiz_model.dart';
import '../model/data_model.dart';
import '../model/option_data.dart';
import '../model/topic_model.dart';
import '../utility/constants.dart';
import '../model/history_model.dart';
import '../provider/timer_provider.dart';

int quizTime = 300;
int skipped = 1;
int trueFalse = 1;
int correct = 2;
int wrongType = 3;

class QuizProvider extends TimeProvider with WidgetsBindingObserver {
  QuizModel? quizModel;
  List<QuizModel> list = [];
  List<HistoryModel> historyList = [];
  List<String> mapList = [];
  int position = 0;
  TopicModel topicModel;
  BuildContext buildContext;
  List<DocumentSnapshot> documentList = [];
  bool isFirstPurchased = false;
  QuizProvider(
      {required this.buildContext,
      required this.topicModel,
      required this.documentList})
      : super(totalTime: quizTime) {
    setQuizData();
  }

  @override
  void timeOver() {
    print('=========================is First ${this.isFirstPurchased}');
    nextQuiz(isDone: true, this.isFirstPurchased);
  }

  Future<List<QuizModel>> getQuizList() async {
    List<QuizModel> quizList = [];

    for (var value in documentList) {
      QuizModel quizModel = QuizModel.fromFirestore(value);
      quizList.add(quizModel);
    }

    return quizList;
  }

  setQuizData() async {
    list = await getQuizList();

    if (list.isNotEmpty) {
      quizModel = list[position];
      startTimer();
      WidgetsBinding.instance.addObserver(this);
      update();
    }
  }

  setAnswer(int index) {
    list[position].answerPosition = index;
    quizModel!.answerPosition = index;
    update();
  }

  int right = 0;
  int skip = 0;
  int wrong = 0;

  getHistory() {
    HistoryModel historyModel = HistoryModel(
        image: quizModel!.image,
        answer: quizModel!.answer,
        optionList: quizModel!.options,
        quizType: quizModel!.type,
        question: quizModel!.question);
    return historyModel;
  }

  nextQuiz(bool isFirstPurchased, {bool? isDone}) {
    HistoryModel historyModel = getHistory();
    this.isFirstPurchased = isFirstPurchased;
    int answer = quizModel!.answerPosition!;
    if (answer == -1) {
      skip = skip + 1;
      historyModel.selectedAnswer = '-';
      historyModel.type = skipped;
    } else {
      String trueAnswer;
      if (quizModel!.type == trueFalse) {
        trueAnswer = answer == 0 ? 'True' : 'False';
      } else {
        trueAnswer = quizModel!.optionList![answer];
      }
      if (trueAnswer == quizModel!.answer) {
        right = right + 1;
        historyModel.selectedAnswer = quizModel!.answer;
        historyModel.type = correct;
      } else {
        historyModel.selectedAnswer = trueAnswer;
        wrong = wrong + 1;
        historyModel.type = wrongType;
      }
    }
    mapList.add(historyModel.toJson().toString());

    historyList.add(historyModel);

    if (isDone == null) {
      if (position < (list.length - 1)) {
        position++;
        quizModel = list[position];

        update();
      } else {
        doneQuiz();
      }
    } else {
      doneQuiz();
    }
  }

  removeObserver() {
    WidgetsBinding.instance.removeObserver(this);
  }

  doneQuiz() {
    cancelTimer();
    removeObserver();

    DataModel dataModel = DataModel(
        totalQuestion: list.length,
        totalTime: currentTime,
        time: (totalTime - currentTime),
        right: right,
        historyList: historyList,
        refId: topicModel.refId!,
        skip: skip,
        wrong: wrong);

    Map<String, dynamic> toJson() {
      return {
        "\"${FirebaseData.detailList}\"": mapList.toString(),
      };
    }

    FirebaseData.addHistoryData(
        list: toJson().toString(),
        right: right,
        skip: skip,
        wrong: wrong,
        refId: topicModel.refId!,
        time: dataModel.time!,
        totalQuestion: list.length);

    Future.delayed(const Duration(microseconds: 100), () {
      backPage(value: false);

      pushPage(ResultPage(
        dataModel: dataModel,
        historyDetail: historyList,
      ));
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        resumeTimer();
        update();
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        pauseTimer();
        update();
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
    }
  }
}

getOptionData(OptionData optionData) {
  List<String> result = [];
  result.add(optionData.optionA!);
  result.add(optionData.optionB!);
  result.add(optionData.optionC!);
  result.add(optionData.optionD!);
  return result;
}
