// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../../utility/constants.dart';
import '../../resizer/fetch_pixels.dart';
import '../../resizer/widget_utils.dart';
import '../../utility/color_scheme.dart';
import '../../provider/data/LoginData.dart';

class ResetPasswordPage extends StatefulWidget {
  final String? phone;

  const ResetPasswordPage({super.key, this.phone});

  @override
  State<ResetPasswordPage> createState() {
    return _ResetPasswordPage();
  }
}

class _ResetPasswordPage extends State<ResetPasswordPage> {
  Future<bool> _requestPop() {
    backPage();

    return Future.value(false);
  }

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  int currentPosition = -1;
  int passPosition = 2;
  int confirmPosition = 3;
  bool _isObscureText = true;
  bool _isObscureText1 = true;

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
                getCommonAppBar(context, title: 'Reset Password', function: () {
                  _requestPop();
                }),
                Expanded(
                    child: ListView(
                  padding: EdgeInsets.symmetric(
                      horizontal: FetchPixels.getDefaultHorSpace(context)),
                  children: [
                    getVerticalSpace(55),
                    getCustomFont(
                        'Enter a new password',
                        FetchPixels.getPixelHeight(80),
                        getFontColor(context),
                        2,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.center),
                    getVerticalSpace(70),
                    getVerticalSpace(40),
                    getPasswordTextFiledWidget(
                        context,
                        "Password",
                        passwordController,
                        focus: (currentPosition == passPosition),
                        onTapFunction: () {
                          setState(() {
                            currentPosition = passPosition;
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
                        "Confirm Password",
                        confirmPasswordController,
                        focus: (currentPosition == confirmPosition),
                        onTapFunction: () {
                          setState(() {
                            currentPosition = confirmPosition;
                          });
                        },
                        isObscureText: _isObscureText1,
                        (value) {
                          setState(() {
                            _isObscureText1 = value;
                          });
                        }),
                    getVerticalSpace(15),
                    getButtonWidget(
                      context,
                      'Confirm',
                      () async {
                        if (passwordController.text ==
                            confirmPasswordController.text) {
                          String id = await LoginData.getUserId(
                              phoneNumber: widget.phone);

                          await LoginData.changePassword(
                              phoneNumber: widget.phone,
                              password: passwordController.text,
                              id: id,
                              oldPassword: '');
                          backPage();
                        } else {
                          showCustomToast(
                              context: context, message: 'Password not match');
                        }
                      },
                      horizontalSpace: 0,
                      verticalSpace: FetchPixels.getPixelHeight(80),
                    ),
                    getVerticalSpace(15),
                  ],
                ))
              ],
            ),
          ),
        ));
  }
}
