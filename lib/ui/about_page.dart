// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_logical_quiz/resizer/widget_utils.dart';
import 'package:flutter_logical_quiz/utility/color_scheme.dart';

import '../utility/constants.dart';
import '../../resizer/fetch_pixels.dart';


class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AboutPage();
  }
}

class _AboutPage extends State<AboutPage> {
  Future<bool> _requestPop() {
    backPage();
    return Future.value(false);
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
              children: [
                getCommonAppBar(context, title: 'About us',
                    function: () {
                      _requestPop();
                    }),

                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: FetchPixels.getDefaultHorSpace(context),
                    vertical: FetchPixels.getPixelHeight(15)),
                     child: getTextWidget(aboutUsText, FetchPixels.getPixelHeight(85),
                         getFontColor(context),
                         fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  getHeaderTitle(String s){
    return Container(margin: EdgeInsets.only(bottom: FetchPixels.getPixelHeight(20)),child: getCustomFont(
        s,
        FetchPixels.getPixelHeight(90),
        getSubFontColor(context),
        1,
        fontWeight: FontWeight.w400),);
  }

  getSubTitle(String s){
    return getCustomFont(
        s,
        FetchPixels.getPixelHeight(90),
        getFontColor(context),
        2,
        fontWeight: FontWeight.w400);
  }


}
