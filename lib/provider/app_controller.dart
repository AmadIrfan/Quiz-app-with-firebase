import 'dart:convert';

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'login_controller.dart';
import '../model/data_model.dart';
import '../model/report_model.dart';
import '../provider/data/FirebaseData.dart';

class AppController extends GetxController {
  RxBool isLoading = true.obs;
  ReportModel? reportModel;
  final bool isFetchData;

  AppController({required this.isFetchData});

  @override
  void onInit() {
    if (isFetchData) {
      setReportData();
    }
    super.onInit();
  }

  setReportData({DataModel? dataModel}) async {
    reportModel = null;
    String id = await LoginController().getUser();

    if (id.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection(FirebaseData.reportData)
          .doc(id)
          .get()
          .then((value) {
        if (value.data() == null) {
          reportModel = null;
        } else {
          reportModel = ReportModel.fromFirestore(value);

          if (dataModel != null) {
            update();
          }
        }

        if (dataModel != null) {
          uploadData(dataModel.right!, dataModel.wrong!, dataModel.skip!,
              dataModel.totalQuestion!, dataModel.time!);
        }

        update();
      });
    }
  }

  uploadData(
    int right,
    int wrong,
    int skip,
    int totalQuestion,
    int time,
  ) async {
    String user = await LoginController().getUser();
    List<dynamic> timeList = [];
    List<dynamic> wrongList = [];
    List<dynamic> skipList = [];
    List<dynamic> rightList = [];
    int totalQuiz = 1;

    if (reportModel != null) {
      skip = reportModel!.skip! + skip;
      wrong = reportModel!.wrong! + wrong;
      right = reportModel!.right! + right;
      totalQuestion = reportModel!.totalQuestion! + totalQuestion;
      time = reportModel!.time! + time;
      time = reportModel!.time! + time;
      totalQuiz = reportModel!.totalQuestion! + 1;
      timeList = jsonDecode(reportModel!.timeList!);
      wrongList = jsonDecode(reportModel!.wrongList!);
      skipList = jsonDecode(reportModel!.skipList!);
      rightList = jsonDecode(reportModel!.rightList!);
    }

    timeList.add(time);
    rightList.add(right);
    skipList.add(skip);
    wrongList.add(wrong);

    ReportModel model = ReportModel(
      wrong: wrong,
      skip: skip,
      right: right,
      totalQuiz: totalQuiz,
      time: time,
      totalQuestion: totalQuestion,
      timeList: jsonEncode(timeList),
      rightList: jsonEncode(rightList),
      wrongList: jsonEncode(wrongList),
      skipList: jsonEncode(skipList),
    );

    FirebaseFirestore.instance
        .collection(FirebaseData.reportData)
        .doc(user)
        .set(model.toJson())
        .then((value) {
      setReportData();
    });
  }
}
