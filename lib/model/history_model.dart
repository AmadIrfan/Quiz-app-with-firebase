import '../model/option_data.dart';
import '../provider/quiz_provider.dart';

class HistoryModel {
  String? question;
  String? image;
  String? answer = "";
  String? selectedAnswer = "";
  String? optionList = "";
  OptionData? optionData;
  int? type = skipped;
  int? quizType = 0;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['"question"'] = '"$question"';
    data['"image"'] = '"$image"';
    data['"answer"'] = '"$answer"';
    data['"type"'] = '"$type"';
    data['"selectedAnswer"'] = '"$selectedAnswer"';
    data['"quizType"'] = '$quizType';
    data['"optionList"'] = optionList ?? '""';
    return data;
  }

  factory HistoryModel.fromJson(Map<String, dynamic> data) {
    return HistoryModel(
      question: data["question"],
      image: data["image"],
      answer: data["answer"],
      type: (data["type"] == null) ? skipped : int.parse(data["type"]),
      selectedAnswer: data["selectedAnswer"],
      optionData: (data["optionList"].isEmpty)
          ? null
          : OptionData.fromFirestore(
              Map<String, dynamic>.from(data['optionList'])),
      quizType: data["quizType"],
    );
  }

  HistoryModel({
    this.image,
    this.question,
    this.type,
    this.answer,
    this.selectedAnswer,
    this.optionList,
    this.quizType,
    this.optionData,
  });
}
