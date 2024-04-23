import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../login_controller.dart';
import '../../utility/constants.dart';
import '../../model/firebase_history.dart';

class FirebaseData {
  static String topicList = 'topic_list';
  static String quizList = 'quizData';
  // static String quizList='quiz_list';
  static String historyList = 'historyData';
  static String dataList = 'data';
  static String detailList = 'dataList';
  static String coinData = 'coinData';
  static String loginData = 'loginData';
  static String reportData = 'reportData';
  static String coinKey = 'coin';
  static String currentCoin = 'currentCoin';
  static String timeStamp = 'index';

  static addHistoryData(
      {required String list,
      required int right,
      required int skip,
      required int wrong,
      required int refId,
      required int time,
      required int totalQuestion}) async {
    FirebaseHistory firebaseHistory = FirebaseHistory();
    firebaseHistory.list = list;
    firebaseHistory.date = getFormattedDate();
    firebaseHistory.right = right;
    firebaseHistory.wrong = wrong;
    firebaseHistory.skip = skip;
    firebaseHistory.refId = refId;
    firebaseHistory.time = time;
    firebaseHistory.totalQuestion = totalQuestion;
    String currentUser = await LoginController().getUser();
    FirebaseFirestore.instance
        .collection(historyList)
        .doc(currentUser)
        .collection('$dataList$refId')
        .add(firebaseHistory.toJson());
  }

  Future<String> getImageUrl(String image) async {
    Reference ref = FirebaseStorage.instance.ref().child('').child(image);
    var url = await ref.getDownloadURL();
    return url.toString();
  }

  static checkLogin({required Function loginStatus}) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        loginStatus(false);
      } else {
        loginStatus(true);
      }
    });
  }
}
