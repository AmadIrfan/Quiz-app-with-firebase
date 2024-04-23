import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'data/FirebaseData.dart';

class CheckDataController extends GetxController {
  RxBool isLoading = true.obs;
  List<DocumentSnapshot> list = [];

  void fetchData(int refId, Function function) async {
    isLoading(true);

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(FirebaseData.quizList)
        .where('ref_id', isEqualTo: refId)
        .get();

    if (querySnapshot.size > 0 && querySnapshot.docs.isNotEmpty) {
      List<DocumentSnapshot> list1 = querySnapshot.docs;
      list = list1;
      function(true);
    } else {
      function(false);
    }
  }
}
