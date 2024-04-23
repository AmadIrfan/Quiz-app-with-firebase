import 'package:cloud_firestore/cloud_firestore.dart';

// import '../app_purchase/purchaseable_product.dart';

class ProfileModel {
  String? lastName;
  String? firstName;
  String? phoneNumber;
  String? image;
  String? purchase_status;
  String? password;
  String? id;

  ProfileModel({
    this.phoneNumber,
    this.lastName,
    this.firstName,
    this.password,
    this.image,
    this.purchase_status = "PENDING",
  });

  factory ProfileModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return ProfileModel(
      lastName: data['last_name'],
      firstName: data['first_name'],
      phoneNumber: data['phone_number'],
      password: data['password'],
      image: (data['image'] == null) ? '' : data['image'],
      purchase_status: (data['purchase_status'] == null
          ? "PENDING"
          : data['purchase_status']),
    );
  }
}
