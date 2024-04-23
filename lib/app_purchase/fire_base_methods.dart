import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_logical_quiz/provider/data/FirebaseData.dart';

class FirebaseMethod {
  final FirebaseFirestore _app = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> updateStatus({String status = 'PURCHASED'}) async {
    // ProfileModel? currentUser = await LoginData.getProfileData();
   await _app
        .collection(FirebaseData.loginData)
        .doc(_auth.currentUser!.uid)
        .update({'purchase_status': status});
  }
  // pco4london@gmail.com
}
