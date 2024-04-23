// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:auth_handler/auth_handler.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

import '../../utility/constants.dart';
import '../../resizer/widget_utils.dart';
import '../../resizer/fetch_pixels.dart';
import '../../utility/color_scheme.dart';
import '../../ui/login/reset_password_page.dart';

class VerificationPage extends StatefulWidget {
  final String? phone;
  final bool? isSignUp;
  final Function? onVerify;
  const VerificationPage({super.key, this.phone, this.isSignUp, this.onVerify});
  @override
  State<VerificationPage> createState() {
    return _VerificationPage();
  }
}

class _VerificationPage extends State<VerificationPage> {
  Future<bool> _requestPop() {
    backPage();

    return Future.value(false);
  }

  void sendOTP() async {
    authHandler.config(otpLength: 6);
    await authHandler.sendOtp(widget.phone!);

    // await FirebaseAuth.instance.verifyPhoneNumber(
    //   verificationFailed: (FirebaseAuthException e) {
    //
    //
    //     print("eCode===${e.code}===${widget.phone}");
    //     if (e.code == 'invalid-phone-number') {
    //     }
    //
    //   },
    //   verificationCompleted: (PhoneAuthCredential credential) async {
    //
    //   },
    //   codeSent: (String? id, int? resendToken) async {
    //     verificationId= id!;
    //
    //     print("send===true");
    //   },
    //   phoneNumber: widget.phone!,
    //
    //
    //   codeAutoRetrievalTimeout: (String verificationId) {
    //
    //   },
    // );
  }

  AuthHandler authHandler = AuthHandler();

  String verificationId = '';
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      sendOTP();
    });
  }

  void _signInWithPhoneNumber(String smsCode) async {
    bool i = await authHandler.verifyOtp(_pinEditingController.text);

    if (i) {
      if (widget.isSignUp == null) {
        Get.off(const ResetPasswordPage());
      } else {
        widget.onVerify!();
        Navigator.of(context).pop();
      }
    } else {
      showCustomToast(context: context, message: "Invalid OTP");
    }

    // PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
    //     verificationId: verificationId, smsCode: smsCode);
    // try{
    //   await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential).then((value) {
    //
    //
    //     // if(FirebaseAuth.instance.currentUser!=null) {
    //     //   User user = FirebaseAuth.instance.currentUser!;
    //     //   print("user===${user.refreshToken}===${}");
    //     //
    //     // }
    //     // print("user===${phoneAuthCredential.accessToken}===${}");
    //
    //
    //     if(widget.isSignUp==null) {
    //       Get.off(const ResetPasswordPage());
    //     }else{
    //       widget.onVerify!();
    //
    //       showCommonDialog(
    //           widget: CreateAccountDialog(clickListener: (context) {
    //             Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
    //
    //           }),
    //           context: context);
    //     }
    //   });
    // }on FirebaseAuthException catch(e){
    //   showCustomToast(context: context, message: e.message.toString());
    // }
  }

  final GlobalKey<FormFieldState<String>> _formKey =
      GlobalKey<FormFieldState<String>>(debugLabel: '_formkey');
  final TextEditingController _pinEditingController =
      TextEditingController(text: '');
  final bool _enable = true;

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
              getCommonAppBar(context, title: 'Verify', function: () {
                _requestPop();
              }),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(
                    horizontal: FetchPixels.getDefaultHorSpace(context),
                  ),
                  children: [
                    getVerticalSpace(55),
                    getCustomFont(
                        'Please enter the code sent to your\nphone number',
                        FetchPixels.getPixelHeight(80),
                        getFontColor(context),
                        2,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.center),
                    getVerticalSpace(50),
                    Container(
                      height: FetchPixels.getPixelHeight(125),
                      margin:
                          EdgeInsets.only(top: FetchPixels.getPixelHeight(20)),
                      child: PinInputTextFormField(
                        key: _formKey,
                        pinLength: 6,
                        decoration: BoxLooseDecoration(
                          textStyle: TextStyle(
                              color: getFontColor(context),
                              fontFamily: fontFamily,
                              fontSize: FetchPixels.getPixelHeight(50),
                              fontWeight: FontWeight.w700),
                          radius:
                              Radius.circular(FetchPixels.getPixelHeight(25)),
                          strokeWidth: 0.4,
                          strokeColorBuilder: PinListenColorBuilder(
                            getSubFontColor(context),
                            getSubFontColor(context),
                          ),
                          obscureStyle: ObscureStyle(
                            isTextObscure: false,
                            obscureText: '🤪',
                          ),
                        ),
                        controller: _pinEditingController,
                        textInputAction: TextInputAction.go,
                        enabled: _enable,
                        keyboardType: TextInputType.number,
                        textCapitalization: TextCapitalization.characters,
                        onSubmit: (pin) {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                          }
                        },
                        onChanged: (pin) {
                          setState(() {});
                        },
                        onSaved: (pin) {},
                        validator: (pin) {
                          if (pin!.isEmpty) {
                            setState(() {});
                            return 'Pin cannot empty.';
                          }
                          setState(() {});
                          return null;
                        },
                        cursor: Cursor(
                          width: 2,
                          color: Colors.white,
                          radius: const Radius.circular(1),
                          enabled: true,
                        ),
                      ),
                    ),
                    getVerticalSpace(15),
                    getButtonWidget(
                      context,
                      'Verify',
                      () {
                        if (_pinEditingController.text.isEmpty) {
                          showCustomToast(
                              context: context, message: "Please enter pin");
                        } else {
                          _signInWithPhoneNumber(_pinEditingController.text);
                        }
                      },
                      horizontalSpace: 0,
                      verticalSpace: FetchPixels.getPixelHeight(80),
                    ),
                    getVerticalSpace(15),
                    getCommonOtherWidget(
                      context: context,
                      s1: 'Didn\'t receive code?',
                      s2: 'Resend',
                      function: () {
                        _pinEditingController.text = '';
                        setState(() {});
                        Future.delayed(
                          const Duration(seconds: 1),
                          () {
                            sendOTP();
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
