import 'package:cloud_firestore/cloud_firestore.dart';



class ReportModel{


  int? skip=0;
  int? right=0;
  int? wrong=0;
  int? time=0;
  int? totalQuestion=0;
  int? totalQuiz=0;
  String? timeList='';
  String? rightList='';
  String? wrongList='';
  String? skipList='';

  factory ReportModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;


    return ReportModel(


      time: data['time'],
      right: data['right'],
      timeList: data['timeList'],
      skip: data['skip'],
      wrong: data['wrong'],
      totalQuiz: data['totalQuiz'],
      totalQuestion: data['totalQuestion'],
      rightList: data['rightList'],
      wrongList: data['wrongList'],
      skipList: data['skipList'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['time'] = time;
    data['right'] = right;
    data['timeList'] = timeList;
    data['skip'] = skip;
    data['wrong'] = wrong;
    data['totalQuiz'] = totalQuiz;
    data['totalQuestion'] = totalQuestion;
    data['rightList'] = rightList;
    data['wrongList'] = wrongList;
    data['skipList'] = skipList;
    return data;
  }

  ReportModel({this.skip,this.right,this.timeList,this.wrong,this.time,
    this.totalQuestion,this.totalQuiz,this.rightList,this.wrongList,this.skipList});




}