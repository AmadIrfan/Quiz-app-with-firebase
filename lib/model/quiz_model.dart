import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'option_data.dart';
import '../provider/quiz_provider.dart';

class QuizModel {
  String? question;
  String? image;
  String? answer = "";
  int? answerPosition = -1;
  String? id;
  List<String>? optionList = [];
  String? options;

  int? type;

  QuizModel(
      {this.id,
      this.image,
      this.question,
      this.answer,
      this.optionList,
      this.type,
      this.options});

  factory QuizModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;

    int quizType = data['type'];

    String list = '""';

    List<String> result = [];
    if (quizType == 0) {
      list = '${data['option_list']}';
      OptionData optionData = OptionData.fromFirestore(jsonDecode(list));
      list = jsonEncode(optionData);
      result = getOptionData(optionData);
    }

    return QuizModel(
      id: doc.id,
      question: data['question'],
      answer: data['answer'],
      type: data['type'],
      image: (data['image'] == null) ? '' : data['image'],
      optionList: result,
      options: list,
    );
  }
}
