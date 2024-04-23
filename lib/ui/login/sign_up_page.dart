// import 'package:country_pickers/country_picker_dropdown.dart';
// import 'package:country_pickers/utils/utils.dart';
// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';

import '../../utility/app_theme.dart';
import '../commonWidget/icon_button.dart';
import '../commonWidget/progress_button.dart';
import '../home_page.dart';
import '../../utility/constants.dart';
import '../../resizer/fetch_pixels.dart';
import '../../resizer/widget_utils.dart';
import '../../utility/color_scheme.dart';
import '../../provider/data/LoginData.dart';
import '../../provider/login_controller.dart';
import '../../dialogUtil/create_account_dialog.dart';

class SignUpPage extends StatefulWidget {
  final LoginController loginController;

  const SignUpPage({super.key, required this.loginController});

  @override
  State<SignUpPage> createState() {
    return _SignUpPage();
  }
}

class _SignUpPage extends State<SignUpPage> {
  Future<bool> _requestPop() {
    backPage();

    return Future.value(false);
  }

  // String countryCode = "+91";

  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  int firstPosition = 4;
  int lastPosition = 5;
  int phonePosition = 6;
  int currentPosition = -1;
  int passPosition = 2;
  int confirmPosition = 3;
  bool _isObscureText = true;
  bool _isObscureText1 = true;

  ButtonState stateTextWithIcon = ButtonState.idle;

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
                getCommonAppBar(context, title: 'Sign Up', function: () {
                  _requestPop();
                }),
                Expanded(
                    child: ListView(
                  padding: EdgeInsets.symmetric(
                      horizontal: FetchPixels.getDefaultHorSpace(context)),
                  children: [
                    getVerticalSpace(55),
                    getCustomFont(
                        'Welcome to the world of MCQs & Learning',
                        FetchPixels.getPixelHeight(80),
                        getFontColor(context),
                        1,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.center),
                    getVerticalSpace(50),
                    getDefaultTextFiledWidget(
                        context, "First Name", firstNameController,
                        focus: (currentPosition == firstPosition),
                        onTapFunction: () {
                      setState(() {
                        currentPosition = firstPosition;
                      });
                    }),
                    getVerticalSpace(40),
                    getDefaultTextFiledWidget(
                        context, "Last Name", lastNameController,
                        focus: (currentPosition == lastPosition),
                        onTapFunction: () {
                      setState(() {
                        currentPosition = lastPosition;
                      });
                    }),
                    getVerticalSpace(40),

                    getDefaultTextFiledWidget(context, "Email", emailController,
                        focus: (currentPosition == phonePosition),
                        onTapFunction: () {
                      setState(() {
                        currentPosition = phonePosition;
                      });
                    }),

                    // Row(
                    //   children: [
                    //     Container(
                    //       height: getDefaultButtonSize(),
                    //       decoration: getDefaultDecorationWithBorder(
                    //           radius: getDefaultRadius(),
                    //           borderColor: getSubFontColor(context),
                    //           borderWidth: 0.4),
                    //       child: CountryPickerDropdown(
                    // onInit: (code){
                    //
                    //       countryCode = code!.dialCode!;
                    //
                    // },
                    // onChanged: (value) {
                    //   countryCode = value.dialCode!;
                    //
                    // },
                    // initialSelection: 'IN',
                    // favorite: ['+91','IN'],
                    // backgroundColor: Colors.transparent,
                    // dialogBackgroundColor: getBackgroundColor(context),
                    // dialogTextStyle: TextStyle(
                    //   fontFamily: fontFamily,
                    //   fontWeight: FontWeight.w600,
                    //   fontSize: FetchPixels.getPixelHeight(35)
                    // ),
                    //
                    // dialogSize: Size(FetchPixels.getWidthPercentSize(80),FetchPixels.getHeightPercentSize(60)),
                    // searchDecoration: InputDecoration(
                    //   contentPadding: EdgeInsets.zero,
                    //   border: OutlineInputBorder(borderSide: BorderSide(
                    //     width: 0.3,
                    //     color: getFontColor(context)
                    //   )),
                    //
                    //   ),
                    //
                    //
                    //
                    // showCountryOnly: false,
                    // showOnlyCountryWhenClosed: false,
                    // alignLeft: false,
                    // closeIcon: Icon(Icons.close,color: getFontColor(context),
                    // size: FetchPixels.getPixelHeight(50),),
                    //
                    //         initialValue: 'IN',
                    //         isExpanded: false,
                    //         isDense: false,
                    //         itemBuilder: (country) {
                    //
                    //           String code=country.phoneCode.trim();
                    //
                    //           print("code==${code}===");
                    //           return Row(
                    //             mainAxisSize: MainAxisSize.min,
                    //             children: <Widget>[
                    //               const SizedBox(
                    //                 width: 8.0,
                    //               ),
                    //               CountryPickerUtils.getDefaultFlagImage(
                    //                   country),
                    //               const SizedBox(
                    //                 width: 8.0,
                    //               ),
                    //               Text("+${country.phoneCode}(${country.isoCode})"),
                    //
                    //             ],
                    //           );
                    //         },
                    //
                    // itemFilter:  ['AR', 'DE', 'GB', 'CN'].contains(c.isoCode),
                    // priorityList:[
                    //   CountryPickerUtils.getCountryByIsoCode('GB'),
                    //   CountryPickerUtils.getCountryByIsoCode('CN'),
                    // ],
                    // sortComparator: (Country a, Country b) => a.isoCode.compareTo(b.isoCode),
                    //         onValuePicked: (value) {
                    //           countryCode = value.phoneCode;
                    //           print("countryCode===$countryCode");
                    //         },
                    //       ),
                    //     ),
                    //     getHorizontalSpace(30),
                    //     Expanded(
                    //       child: getDefaultTextFiledWidget(
                    //           context, "Phone Number", emailController,
                    //           inputType: TextInputType.phone,
                    //           inputFormatters: <TextInputFormatter>[
                    //             FilteringTextInputFormatter.digitsOnly
                    //           ],
                    //           focus: (currentPosition == phonePosition),
                    //           onTapFunction: () {
                    //         setState(() {
                    //           currentPosition = phonePosition;
                    //         });
                    //       }),
                    //     )
                    //   ],
                    // ),
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

                    // getButtonWidget(
                    //   context,
                    //   '',
                    //   () async {
                    // checkValidation();
                    //   },
                    //   horizontalSpace: 0,
                    //   verticalSpace: FetchPixels.getPixelHeight(80),
                    // ),
                    // ProgressButton.icon(
                    //   radius: getDefaultBtnRadius(),
                    //   iconButtons: {
                    //     ButtonState.idle: CustomIconButton(
                    //         text: "Sign Up", color: primaryColor),
                    //     ButtonState.loading: CustomIconButton(
                    //         text: "Loading", color: primaryColor),
                    //     ButtonState.success: CustomIconButton(
                    //       text: "",
                    //       icon: const Icon(
                    //         Icons.check,
                    //         color: Colors.white,
                    //       ),
                    //       color: primaryColor,
                    //     ),
                    //   },
                    //   onPressed: checkValidation,
                    //   state: stateTextWithIcon,
                    // ),
                    Wrap(
                      children: [
                        Center(
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: FetchPixels.getPixelHeight(80)),
                            child: buildTextWithIcon(),
                          ),
                        )
                      ],
                    ),
                    getVerticalSpace(15),
                    getCommonOtherWidget(
                        context: context,
                        s1: 'Already have an account?',
                        s2: 'Log In',
                        function: () {
                          backPage();
                        })
                  ],
                ))
              ],
            ),
          ),
        ));
  }

  checkValidation() {
    setState(() {
      stateTextWithIcon = ButtonState.loading;
    });

    print('checkValidation');
    if (isNotEmpty(firstNameController.text) &&
        isNotEmpty(lastNameController.text)) {
      if (isNotEmpty(emailController.text)) {
        if (emailValid(emailController.text)) {
          if (isNotEmpty(passwordController.text) &&
              isNotEmpty(confirmPasswordController.text)) {
            if ((passwordController.text.length >= 6) &&
                confirmPasswordController.text.length >= 6) {
              if (passwordController.text == confirmPasswordController.text) {
                _register();
              } else {
                showCustomToast(
                    message: 'Password does not match', context: context);
              }
            } else {
              showCustomToast(
                  message: 'You must have 6 characters in your password',
                  context: context);
            }
          } else {
            showCustomToast(message: 'Enter password', context: context);
          }
        } else {
          showCustomToast(message: 'Enter valid email', context: context);
        }
      } else {
        showCustomToast(message: 'Enter your phone number', context: context);
      }
    } else {
      showCustomToast(message: 'Fill details', context: context);
    }
  }

  void _register() async {
    bool isAlreadyRegister = await LoginData.userAlreadyRegister(context,
        phoneNumber: emailController.text, password: passwordController.text);
    // phoneNumber: countryCode + emailController.text);

    if (!mounted) {
      return;
    }
    if (isAlreadyRegister) {
      showCustomToast(context: context, message: 'User already register..');
    } else {
      LoginData.createUser(
        context: context,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        phoneNumber: emailController.text,
        // phoneNumber: countryCode + emailController.text,
        password: passwordController.text,
        function: () async {
          bool isLogin = await LoginData.login(
            context,
            phoneNumber: emailController.text,
            // phoneNumber: countryCode + emailController.text,
            password: passwordController.text,
            loginController: widget.loginController,
          );
          widget.loginController.changeData(isLogin);
          if (isLogin) {
            showCommonDialog(
              widget: CreateAccountDialog(
                clickListener: (context) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                },
              ),
              context: context,
            );
          }
        },
      );
      // pushPage(
      //     VerificationPage(
      //         phone: emailController.text,
      //         isSignUp: true,
      //         onVerify: () async {

      //         }),
      //     function: (value) {});
    }
  }

  Widget buildTextWithIcon() {
    return ProgressButton.icon(
      radius: getDefaultBtnRadius(),
      iconButtons: {
        ButtonState.idle:
            CustomIconButton(text: "Register", color: primaryColor),
        ButtonState.loading:
            CustomIconButton(text: "Loading", color: primaryColor),
        ButtonState.success: CustomIconButton(
          text: "",
          icon: const Icon(
            Icons.check,
            color: Colors.white,
          ),
          color: primaryColor,
        ),
      },
      onPressed: checkValidation,
      state: stateTextWithIcon,
    );
  }
}
