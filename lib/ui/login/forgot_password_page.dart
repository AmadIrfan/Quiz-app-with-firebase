// ignore_for_file: deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../resizer/widget_utils.dart';
import '../../utility/color_scheme.dart';
import '../../resizer/fetch_pixels.dart';
import '../../utility/constants.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() {
    return _ForgotPasswordPage();
  }
}

class _ForgotPasswordPage extends State<ForgotPasswordPage> {
  Future<bool> _requestPop() {
    backPage();

    return Future.value(false);
  }

  // String countryCode = "+91";
  TextEditingController emailController = TextEditingController();

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
                getCommonAppBar(context, title: 'Forgot Password',
                    function: () {
                  _requestPop();
                }),
                Expanded(
                    child: ListView(
                  padding: EdgeInsets.symmetric(
                      horizontal: FetchPixels.getDefaultHorSpace(context)),
                  children: [
                    getVerticalSpace(55),
                    getCustomFont(
                        'We need your registration phone to send you\npassword reset code!',
                        FetchPixels.getPixelHeight(80),
                        getFontColor(context),
                        2,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.center),
                    getVerticalSpace(70),

                    // Row(
                    //   children: [
                    //
                    //     Container(
                    //       height: getDefaultButtonSize(),
                    //       decoration: getDefaultDecorationWithBorder(
                    //           radius: getDefaultRadius(),
                    //           borderColor: getSubFontColor(context),
                    //           borderWidth: 0.4),
                    //       child: CountryPickerDropdown(
                    //         // onInit: (code){
                    //         //
                    //         //   countryCode = code!.dialCode!;
                    //         //   // });
                    //         //   // }
                    //         // },
                    //         // onChanged: (value) {
                    //         //   countryCode = value.dialCode!;
                    //         //
                    //         //
                    //         // },
                    //         // initialSelection: 'IN',
                    //         // favorite: ['+91','IN'],
                    //         // backgroundColor: Colors.transparent,
                    //         // dialogBackgroundColor: getBackgroundColor(context),
                    //         // dialogTextStyle: TextStyle(
                    //         //     fontFamily: fontFamily,
                    //         //     fontWeight: FontWeight.w600,
                    //         //     fontSize: FetchPixels.getPixelHeight(35)
                    //         // ),
                    //         //
                    //         // dialogSize: Size(FetchPixels.getWidthPercentSize(80),FetchPixels.getHeightPercentSize(60)),
                    //         // searchDecoration: InputDecoration(
                    //         //   contentPadding: EdgeInsets.zero,
                    //         //   border: OutlineInputBorder(borderSide: BorderSide(
                    //         //       width: 0.3,
                    //         //       color: getFontColor(context)
                    //         //   )),
                    //         //
                    //         // ),
                    //         //
                    //         //
                    //         //
                    //         // showCountryOnly: false,
                    //         // showOnlyCountryWhenClosed: false,
                    //         // alignLeft: false,
                    //         // closeIcon: Icon(Icons.close,color: getFontColor(context),
                    //         //   size: FetchPixels.getPixelHeight(50),),
                    //
                    //         initialValue: 'IN',
                    //         itemBuilder: (country) {
                    //           return Row(
                    //             children: <Widget>[
                    //               const SizedBox(
                    //                 width: 8.0,
                    //               ),
                    //               CountryPickerUtils.getDefaultFlagImage(country),
                    //               const SizedBox(
                    //                 width: 8.0,
                    //               ),
                    //               Text("+${country.phoneCode}(${country.isoCode})"),
                    //             ],
                    //           );
                    //         },
                    //
                    //
                    //         // itemFilter:  ['AR', 'DE', 'GB', 'CN'].contains(c.isoCode),
                    //         // priorityList:[
                    //         //   CountryPickerUtils.getCountryByIsoCode('GB'),
                    //         //   CountryPickerUtils.getCountryByIsoCode('CN'),
                    //         // ],
                    //         // sortComparator: (Country a, Country b) => a.isoCode.compareTo(b.isoCode),
                    //         onValuePicked: (value) {
                    //           countryCode = value.phoneCode;
                    //         },
                    //       ),
                    //     ),
                    //     getHorizontalSpace(30),
                    //
                    //     Expanded(child:  getDefaultTextFiledWidget(
                    //       context, "Phone Number", emailController,inputType:TextInputType.phone,
                    //       inputFormatters: <TextInputFormatter>[
                    //         FilteringTextInputFormatter.digitsOnly
                    //       ],
                    //       focus: true
                    //     ),)
                    //   ],
                    // ),

                    getDefaultTextFiledWidget(
                      context,
                      "Email",
                      emailController,
                      focus: true,
                      onTapFunction: () {},
                    ),

                    getButtonWidget(
                      context,
                      'Next',
                      () async {
                        if (isNotEmpty(emailController.text)) {
                          // bool isAlreadyRegister = await     LoginData.userAlreadyRegister(context,phoneNumber:
                          // emailController.text,password: "");

                          // if(isAlreadyRegister){

                          FirebaseAuth.instance
                              .sendPasswordResetEmail(
                                  email: emailController.text)
                              .then((value) {
                            backPage();

                            showCustomToast(
                                context: context,
                                message:
                                    "We have sent you instructions to reset your password!");
                          }).catchError((e) {});

                          // backPage();
                          // Get.off(const ResetPasswordPage());
                          // pushPage(VerificationPage(phone: countryCode+emailController.text));
                          // }
                          // else{
                          //     if (!mounted) {
                          //       return;
                          //     }
                          //     showCustomToast(context: context, message: 'User not register');
                          //   }
                          // }else{
                          //   showCustomToast(context: context, message: 'Enter your phone number');
                          // }

                          // if(isNotEmpty(emailController.text)){
                          //   bool isAlreadyRegister = await     LoginData.userAlreadyRegister(context,phoneNumber:
                          //   countryCode+emailController.text);
                          //
                          //
                          //   if(isAlreadyRegister){
                          //     backPage();
                          //
                          //     Get.off(const ResetPasswordPage());
                          //
                          //     // pushPage(VerificationPage(phone: countryCode+emailController.text));
                          //
                          //   }else{
                          //     if (!mounted) {
                          //       return;
                          //     }
                          //
                          //     showCustomToast(context: context, message: 'User not register');
                          //   }
                          //
                          //
                        } else {
                          showCustomToast(
                              context: context,
                              message: 'Enter your phone number');
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
