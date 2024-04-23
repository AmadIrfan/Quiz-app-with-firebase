// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_logical_quiz/model/profile_model.dart';
import 'package:flutter_logical_quiz/provider/data/LoginData.dart';
import 'package:flutter_logical_quiz/resizer/widget_utils.dart';
import 'package:flutter_logical_quiz/utility/color_scheme.dart';
import 'package:get/get.dart';

import '../../resizer/fetch_pixels.dart';
import '../../utility/constants.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() {
    return _ChangePasswordPage();
  }
}

class _ChangePasswordPage extends State<ChangePasswordPage> {
  Future<bool> _requestPop() {
    backPage();

    return Future.value(false);
  }

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  int currentPosition = -1;
  int oldPosition = 1;
  int passPosition = 2;
  int confirmPosition = 3;
  bool _isObscureText = true;
  bool _isObscureText1 = true;
  bool _isObscureText2 = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _requestPop,
        child: Scaffold(
          backgroundColor: getBackgroundColor(context),
          appBar: getNoneAppBar(context),
          body: SafeArea(
            child: Column(
              children: [
                getCommonAppBar(context, title: 'Change Password',
                    function: () {
                  _requestPop();
                }),
                Expanded(
                    child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: FetchPixels.getDefaultHorSpace(context),
                  ),
                  child: Column(
                    children: [
                      getVerticalSpace(40),
                      getPasswordTextFiledWidget(
                          context,
                          "Old Password",
                          oldPasswordController,
                          focus: (currentPosition == oldPosition),
                          onTapFunction: () {
                            setState(() {
                              currentPosition = oldPosition;
                            });
                          },
                          isObscureText: _isObscureText,
                          (value) {
                            setState(() {
                              _isObscureText = value;
                            });
                          }),
                      getVerticalSpace(40),
                      getPasswordTextFiledWidget(
                          context,
                          "New Password",
                          passwordController,
                          focus: (currentPosition == passPosition),
                          onTapFunction: () {
                            setState(() {
                              currentPosition = passPosition;
                            });
                          },
                          isObscureText: _isObscureText1,
                          (value) {
                            setState(() {
                              _isObscureText1 = value;
                            });
                          }),
                      getVerticalSpace(40),
                      getPasswordTextFiledWidget(
                          context,
                          "Confirm Password",
                          confirmPasswordController,
                          focus: (currentPosition == confirmPosition),
                          onTapFunction: () {
                            setState(() {
                              currentPosition = confirmPosition;
                            });
                          },
                          isObscureText: _isObscureText2,
                          (value) {
                            setState(() {
                              _isObscureText2 = value;
                            });
                          }),
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                    ],
                  ),
                )),
                Obx(
                  () => getButtonWidget(
                    context,
                    isProcess: isProcess.value,
                    'Confirm',
                    () {
                      changePassword();
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }

  RxBool isProcess = false.obs;

  changePassword() async {
    if (isNotEmpty(oldPasswordController.text) &&
        isNotEmpty(passwordController.text) &&
        isNotEmpty(confirmPasswordController.text)) {
      ProfileModel? profileModel = await LoginData.getProfileData();
      //
      // if (profileModel != null) {
      //   if (oldPasswordController.text ==
      //       profileModel.password) {
      if (passwordController.text == confirmPasswordController.text) {
        isProcess.value = true;
        LoginData.changePassword(
            id: profileModel!.id,
            phoneNumber: profileModel.phoneNumber,
            password: passwordController.text,
            oldPassword: oldPasswordController.text,
            function: () {
              isProcess.value = false;
              showCustomToast(context: context, message: 'Password changed');
              Navigator.of(context).pop();
            });
      } else {
        if (!mounted) {
          return;
        }
        showCustomToast(context: context, message: 'Password don\'t match');
      }
      // } else {
      //   if (!mounted){
      //     return;
      //   }
      //   showCustomToast(
      //       context: context,
      //       message: 'Old password is wrong');
      // }
      // }
    } else {
      showCustomToast(context: context, message: 'Fill all filed');
    }
  }
}
