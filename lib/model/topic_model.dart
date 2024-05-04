import 'package:cloud_firestore/cloud_firestore.dart';

class TopicModel {
  String? title;
  int? refId;
  String? id;

  TopicModel({this.id, this.title, this.refId});

  factory TopicModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    // print(data);
    return TopicModel(
      id: doc.id,
      title: data['title'],
      refId: data['ref_id'],
    );
  }
}
