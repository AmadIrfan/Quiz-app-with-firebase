// import 'package:country_pickers/country_picker_dropdown.dart';
// import 'package:country_pickers/utils/utils.dart';
// ignore_for_file: deprecated_member_use

import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../home_page.dart';
import '../../utility/constants.dart';
import '../../utility/app_theme.dart';
import '../../utility/color_scheme.dart';
import '../../resizer/widget_utils.dart';
import '../../resizer/fetch_pixels.dart';
import '../../ui/login/sign_up_page.dart';
import '../../provider/data/LoginData.dart';
import '../../provider/login_controller.dart';
import '../../ui/commonWidget/icon_button.dart';
import '../../ui/login/forgot_password_page.dart';
import '../../ui/commonWidget/progress_button.dart';

class LoginPage extends StatefulWidget {
  final bool fromIntro;

  const LoginPage(this.fromIntro, {super.key});

  @override
  State<LoginPage> createState() {
    return _LoginPage();
  }
}

class _LoginPage extends State<LoginPage> with TickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  // String countryCode = "+91";
  bool isLogin = false;

  Future<bool> _requestPop() {
    // exitApp();
    Get.back();
    return Future.value(false);
  }

  bool _isObscureText = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginController loginController = Get.put(LoginController());
  int currentPosition = -1;
  int emailPosition = 1;
  int passPosition = 2;
  var animationStatus = 0;
  ButtonState stateTextWithIconMinWidthState = ButtonState.idle;

  AnimationController? _loginButtonController;

  @override
  void initState() {
    super.initState();
    _loginButtonController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _loginButtonController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        backgroundColor: getBackgroundColor(context),
        appBar: getNoneAppBar(context),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getCommonAppBar(context, title: 'Login', function: () {
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
                    getDefaultTextFiledWidget(context, "Email", emailController,
                        focus: (currentPosition == emailPosition),
                        onTapFunction: () {
                      setState(() {
                        currentPosition = emailPosition;
                      });
                    }),
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
                    getVerticalSpace(15),
                    InkWell(
                      onTap: () {
                        Get.to(const ForgotPasswordPage());
                      },
                      child: getCustomFont(
                          'Forgot Password?',
                          FetchPixels.getPixelHeight(80),
                          getFontColor(context),
                          1,
                          fontWeight: FontWeight.w700,
                          textAlign: TextAlign.end),
                    ),
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
                      s1: 'Don\'t have an account?',
                      s2: 'Sign Up',
                      function: () async {
                        // print("isRegister===true");
                        // bool isRegister = await LoginData.loginUsingEmailPassword(context,phone:  "+919067601186");
                        // print("isRegister===${isRegister}");

                        pushPage(
                          SignUpPage(
                            loginController: loginController,
                          ),
                        );
                        passwordController.text = '';
                        emailController.text = '';
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  checkValidation() async {
    await _login();
  }

  Widget buildTextWithIcon() {
    return ProgressButton.icon(
      radius: getDefaultBtnRadius(),
      iconButtons: {
        ButtonState.idle: CustomIconButton(text: "Log In", color: primaryColor),
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
      onPressed: onPressedIconWithText,
      state: stateTextWithIcon,
    );
  }

  ButtonState stateTextWithIcon = ButtonState.idle;

  void onPressedIconWithText() async {
    checkValidation();
  }

  Future<void> _login() async {
    bool isLogin = await LoginData.login(
      context,
      phoneNumber: emailController.text,
      password: passwordController.text,
      loginController: loginController,
    );

    if (isLogin) {
      setState(() {
        stateTextWithIcon = ButtonState.loading;
      });
      Future.delayed(const Duration(seconds: 1), () {
        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            stateTextWithIcon = ButtonState.success;
          });
          loginController.changeData(true);

          if (widget.fromIntro) {
            Get.to(HomePage());
          } else {
            backPage();
          }

          showCustomToast(context: context, message: 'Login successfully');
        });
      });
    } else {
      if (!mounted) {
        return;
      }
      showCustomToast(context: context, message: 'Password not match');
    }
    // }
    // else {
    //   if (!mounted){
    //     return;
    //   }
    //   showCustomToast(context: context, message: 'User not register');
    // }
    // }
  }
}



                    // Row(
                    //   children: [
                    //     Container(
                    //       height: getDefaultButtonSize(),
                    //       decoration: getDefaultDecorationWithBorder(
                    //           radius: getDefaultRadius(),
                    //           borderColor: getSubFontColor(context),
                    //           borderWidth: 0.4),
                    //       child: CountryPickerDropdown(
                    // onInit: (code) {
                    //   countryCode = code!.dialCode!;
                    // },
                    // onChanged: (value) {
                    //   countryCode = value.dialCode!;
                    // },
                    // initialSelection: 'IN',
                    // favorite: ['+91', 'IN'],
                    // backgroundColor: Colors.transparent,
                    // dialogBackgroundColor: getBackgroundColor(context),
                    // dialogTextStyle: TextStyle(
                    //     fontFamily: fontFamily,
                    //     fontWeight: FontWeight.w600,
                    //     fontSize: FetchPixels.getPixelHeight(35)),
                    // dialogSize: Size(
                    //     FetchPixels.getWidthPercentSize(80),
                    //     FetchPixels.getHeightPercentSize(60)),
                    // searchDecoration: InputDecoration(
                    //   contentPadding: EdgeInsets.zero,
                    //   border: OutlineInputBorder(
                    //       borderSide: BorderSide(
                    //           width: 0.3,
                    //           color: getFontColor(context))),
                    // ),
                    // showCountryOnly: false,
                    // showOnlyCountryWhenClosed: false,
                    // alignLeft: false,
                    // closeIcon: Icon(
                    //   Icons.close,
                    //   color: getFontColor(context),
                    //   size: FetchPixels.getPixelHeight(50),
                    // ),
                    //
                    //
                    //         initialValue: 'IN',
                    //         itemBuilder: (country) {
                    //           return Row(
                    //           children: <Widget>[
                    //             const SizedBox(
                    //               width: 8.0,
                    //             ),
                    //           CountryPickerUtils.getDefaultFlagImage(country),
                    //           const SizedBox(
                    //           width: 8.0,
                    //           ),
                    //           Text("+${country.phoneCode}(${country.isoCode})"),
                    //           ],
                    //           );
                    //         },
                    //
                    //
                    // itemFilter:  ['AR', 'DE', 'GB', 'CN'].contains(c.isoCode),
                    // priorityList:[
                    //   CountryPickerUtils.getCountryByIsoCode('GB'),
                    //   CountryPickerUtils.getCountryByIsoCode('CN'),
                    // ],
                    // sortComparator: (Country a, Country b) => a.isoCode.compareTo(b.isoCode),
                    //         onValuePicked: (value) {
                    //           countryCode = value.phoneCode;
                    //         },
                    //
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
                    //           focus: (currentPosition == emailPosition),
                    //           onTapFunction: () {
                    //         setState(() {
                    //           currentPosition = emailPosition;
                    //         });
                    //       }),
                    //     )
                    //   ],
                    // ),
