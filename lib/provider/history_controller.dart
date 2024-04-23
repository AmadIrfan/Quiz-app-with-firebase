import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'data/FirebaseData.dart';

class HistoryController extends GetxController {
  RxBool isLoading = true.obs;
  List<DocumentSnapshot> list = [];

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    isLoading(true);

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(FirebaseData.topicList)
        .orderBy("ref_id", descending: false)
        .get();

    if (querySnapshot.size > 0) {
      if (querySnapshot.docs.isNotEmpty) {
        List<DocumentSnapshot> list1 = querySnapshot.docs;
        if (list1.isNotEmpty) {
          list = list1;
          isLoading(false);
        }
      }
    }
  }
}
