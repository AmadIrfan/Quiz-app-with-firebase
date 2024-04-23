// ignore_for_file: use_build_context_synchronously, file_names

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'FirebaseData.dart';
import '../login_controller.dart';
import '../../model/profile_model.dart';
import '../../resizer/widget_utils.dart';

class LoginData {
  static String keyFirstName = 'first_name';
  static String keyLastName = 'last_name';
  static String keyPassword = 'password';
  static String purchase_status = 'purchase_status';
  static String keyPhoneNumber = 'phone_number';
  static String keyActive = 'active';
  static String keyImage = 'image';
  // static String keyUser = '_user';
  static String keyUId = '_uid';

  static createUser(
      {required BuildContext context,
      required String firstName,
      required String lastName,
      required String phoneNumber,
      required String password,
      required Function function}) async {
    bool isCreated = await registerUsingEmailPassword(
      context,
      password: password,
      email: phoneNumber,
    );
    if (isCreated) {
      FirebaseFirestore.instance
          .collection(FirebaseData.loginData)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        keyFirstName: firstName,
        keyLastName: lastName,
        keyPassword: password,
        keyPhoneNumber: phoneNumber,
        keyUId: FirebaseAuth.instance.currentUser!.uid,
        keyActive: '1',
        keyImage: '',
        purchase_status: 'PENDING'
      }).then((value) {
        FirebaseAuth.instance.signOut();
        function();
      });
    }
  }

  static Future<bool> registerUsingEmailPassword(BuildContext context,
      {email, password}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        auth.currentUser != null;
      });
      return auth.currentUser != null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showCustomToast(message: "weak-password", context: context);
      } else if (e.code == 'email-already-in-use') {
        if (auth.currentUser != null) {
          auth.currentUser != null;
        }
        showCustomToast(
            message: "The account already exists for that email.",
            context: context);
        return false;
      }
    } catch (e) {
      return false;
    }

    return false;
  }

  //
  //
  // static Future<bool> loginUsingEmailPassword(BuildContext context,{phone}) async {
  //
  //
  //   const firebaseConfig = {
  //     'apiKey': 'AIzaSyDHnliY4o-8Oo3rQvVl2_4pipJKW_Hw48E',
  //     'authDomain': 'programming-quiz-262eb.firebaseapp.com',
  //     'projectId': 'programming-quiz-262eb',
  //     'storageBucket': 'programming-quiz-262eb.appspot.com',
  //     'messagingSenderId': '1066569403741',
  //     'appId': '1:1066569403741:web:5559fe75327516bd84ecb4',
  //     'measurementId': "G-JL48MV5BWW"
  //   };
  //
  //   FirebaseRecaptchaVerifierModal(
  //     firebaseConfig: firebaseConfig,
  //     onVerify: (token) => print('token: ' + token),
  //     onLoad: () => print('onLoad'),
  //     onError: () => print('onError'),
  //     onFullChallenge: () => print('onFullChallenge'),
  //     attemptInvisibleVerification: true,
  //   );
  //
  //
  // FirebaseAuth auth = FirebaseAuth.instance;
  //
  // ConfirmationResult confirmationResult = await auth.signInWithPhoneNumber('+919067601186');
  //
  // UserCredential userCredential = await confirmationResult.confirm('123456');
  //
  // print("user===${userCredential.user!.phoneNumber}");
  //   return true;
  //
  // }

  static Future<bool> loginUsingEmailPassword(BuildContext context,
      {email, password, required isCheck}) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    print("user===${email}==$password");

    try {
      await auth
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        auth.currentUser != null;
      });

      return auth.currentUser != null;
    } on FirebaseAuthException catch (e) {
      if (!isCheck) {
        if (e.code == 'user-not-found') {
          showCustomToast(
              context: context, message: 'No user found for that email.');
        } else if (e.code == 'wrong-password') {
          showCustomToast(
              context: context,
              message: 'Wrong password provided for that user.');
        }
      }
    }
    return false;
  }

  static Future<bool> userAlreadyRegister(BuildContext context,
      {required phoneNumber, required password}) async {
    bool isRegister = await loginUsingEmailPassword(context,
        password: password, email: phoneNumber, isCheck: true);

    // print("isRegister===$isRegister");

    if (!isRegister) {
      return false;
    }

    // QuerySnapshot querySnapshot = await FirebaseFirestore.instance
    //     .collection(FirebaseData.loginData)
    //     .where(keyPhoneNumber, isEqualTo: phoneNumber)
    //     .get();
    //
    // if (FirebaseAuth.instance.currentUser != null) {
    FirebaseAuth.instance.signOut();
    // }
    // if (querySnapshot.size > 0) {
    return true;
    // } else {
    //   return false;
    // }
  }

  static Future<String> getUserId({phoneNumber}) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(FirebaseData.loginData)
        .where(keyPhoneNumber, isEqualTo: phoneNumber)
        .get();

    if (querySnapshot.size > 0) {
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs[0].id;
      }

      return '';
    } else {
      return '';
    }
  }

  static Future<bool> login(BuildContext context,
      {phoneNumber, password, loginController}) async {
    bool isLogin = await loginUsingEmailPassword(
      context,
      password: password,
      email: phoneNumber,
      isCheck: false,
    );
    if (!isLogin) {
      return false;
    }
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(FirebaseData.loginData)
        .where(keyPhoneNumber, isEqualTo: phoneNumber)
        .where(keyUId, isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where(keyActive, isEqualTo: '1')
        .get();
    if (querySnapshot.size > 0) {
      for (var element in querySnapshot.docs) {
        loginController.login(element.id);
      }
      return true;
    } else {
      return false;
    }
  }

  static Future<void> changePassword(
      {id, phoneNumber, password, required oldPassword, function}) async {
    User? user = FirebaseAuth.instance.currentUser!;
    final cred =
        EmailAuthProvider.credential(email: user.email!, password: oldPassword);
    await user.reauthenticateWithCredential(cred).then((value) async {
      await user.updatePassword(password).then((_) {
        // print("dsf33");
        //   FirebaseFirestore.instance
        //       .collection(FirebaseData.loginData)
        //       .doc(id)
        //       .update({
        //     keyPassword: password,
        //   }).then((value) {
        //
        //     print("dsf");
        //     function();
        //   });

        function();
      }).catchError((error) {
        // print(error);
      });
    }).catchError((err) {
      // print(err);
    });
  }

  static Future<void> updateProfile(
      {id, firstName, lastName, required String image}) async {
    var map = {
      keyFirstName: firstName,
      keyLastName: lastName,
    };
    if (image.isNotEmpty) {
      map['image'] = image;
    }
    FirebaseFirestore.instance
        .collection(
          FirebaseData.loginData,
        )
        .doc(id)
        .update(map);
  }

  static Future<ProfileModel?> getProfileData() async {
    String id = await LoginController().getUser();
    DocumentSnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(FirebaseData.loginData)
        .doc(id)
        .get();
    if (querySnapshot.data() != null) {
      ProfileModel profileModel = ProfileModel.fromFirestore(querySnapshot);
      profileModel.id = id;
      return profileModel;
    }
    return null;
  }
}
