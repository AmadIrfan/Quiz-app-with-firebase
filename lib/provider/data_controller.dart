import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'data/FirebaseData.dart';

class DataController extends GetxController {
  RxBool isLoading = true.obs;
  int refId = 1;
  List<DocumentSnapshot> list = [];

  DataController(this.refId);

  @override
  void onInit() {
    fetchData(refId);
    super.onInit();
  }

  void fetchData(int refId) async {
    isLoading(true);

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(FirebaseData.quizList)
        .where('ref_id', isEqualTo: refId)
        .orderBy(FirebaseData.timeStamp, descending: false)
        .get();

    if (querySnapshot.size > 0) {
      if (querySnapshot.docs.isNotEmpty) {
        List<DocumentSnapshot> list1 = querySnapshot.docs;

        if (list1.isNotEmpty) {
          list1.shuffle();

          list = list1.take(50).toList();
          isLoading(false);
        }
      }
    }
  }
}
