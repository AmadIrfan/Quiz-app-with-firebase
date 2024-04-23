import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'data/FirebaseData.dart';

class TopicController extends GetxController {
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
        .orderBy(
          "ref_id",
        )
        .get();
    if (querySnapshot.size > 0) {
      if (querySnapshot.docs.isNotEmpty) {
        List<DocumentSnapshot> list1 = querySnapshot.docs;
        if (list1.isNotEmpty) {
          list = list1;
          isLoading(false);
          isLoading = false.obs;
        }
      }
    }
  }
}
