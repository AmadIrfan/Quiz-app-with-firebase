import 'history_model.dart';

class DataModel{


  int? skip=0;
  int? right=0;
  int? wrong=0;
  int? time=0;
  int? totalQuestion=0;
  int? totalTime=300;
  int? refId=1;
  List<HistoryModel> historyList = [];

  DataModel({required this.historyList,required this.skip,required this.wrong,required this.time,
  required this.right, required this.totalTime,required this.refId,required this.totalQuestion});
}