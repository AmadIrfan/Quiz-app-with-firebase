// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../utility/constants.dart';
import '../model/profile_model.dart';
import '../resizer/widget_utils.dart';
import '../utility/color_scheme.dart';
import '../provider/data/LoginData.dart';
import '../../resizer/fetch_pixels.dart';
import '../ui/login/edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() {
    return _ProfilePage();
  }
}

class _ProfilePage extends State<ProfilePage> {


  Future<bool> _requestPop() {
    backPage();
    return Future.value(false);
  }

  ProfileModel? profileModel;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget divider = Container(
      margin: EdgeInsets.symmetric(vertical: FetchPixels.getPixelHeight(45)),
      color: getSubColor(context),
      width: double.infinity,
      height: 0.7,
    );

    return WillPopScope(
        onWillPop: _requestPop,
        child: Scaffold(
          backgroundColor: getBackgroundColor(context),
          appBar: getNoneAppBar(context),
          body: SafeArea(
            child: Column(
              children: [
                getCommonAppBar(context, title: 'Profile', function: () {
                  _requestPop();
                }),
                Expanded(
                    child: FutureBuilder<ProfileModel?>(
                  future: LoginData.getProfileData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData || snapshot.data != null) {
                      profileModel = snapshot.data;
                      return Container(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                FetchPixels.getDefaultHorSpace(context)),
                        child: ListView(
                          children: [
                            getVerticalSpace(35),
                            getProfileImage(snapshot.data!.image),
                            getVerticalSpace(80),
                            getHeaderTitle('First Name'),
                            getSubTitle(profileModel!.firstName!),
                            divider,
                            getHeaderTitle('Last Name'),
                            getSubTitle(profileModel!.lastName!),
                            divider,
                            getHeaderTitle('Email'),
                            getSubTitle(profileModel!.phoneNumber!),
                            divider,
                          ],
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                )),
                getButtonWidget(
                  context,
                  'Edit Profile',
                  () {
                    if (profileModel != null) {
                      pushPage(EditProfilePage(profileModel: profileModel!),
                          function: (value) {
                        setState(() {});
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ));
  }

  getHeaderTitle(String s) {
    return Container(
      margin: EdgeInsets.only(bottom: FetchPixels.getPixelHeight(20)),
      child: getCustomFont(
          s, FetchPixels.getPixelHeight(90), getSubFontColor(context), 1,
          fontWeight: FontWeight.w400),
    );
  }

  getSubTitle(String s) {
    return getCustomFont(
        s, FetchPixels.getPixelHeight(90), getFontColor(context), 2,
        fontWeight: FontWeight.w400);
  }
}
