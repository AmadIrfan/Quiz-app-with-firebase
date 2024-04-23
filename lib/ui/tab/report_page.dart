import 'dart:math';
import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../ui/video_page.dart';
import '../../model/report_model.dart';
import '../../resizer/fetch_pixels.dart';
import '../../utility/color_scheme.dart';
import '../../resizer/widget_utils.dart';
import '../../provider/quiz_provider.dart';
import '../../provider/app_controller.dart';
import '../../provider/login_controller.dart';

class ReportPage extends StatelessWidget {
  final AppController appController;
//   final LoginController loginController;

  ReportPage({
    super.key,
    required this.appController,
//     required this.loginController,
  });
  final String title = 'TFL SERU - Section';
  final List<Map<String, String>> videoList = [
    {
      'title': 'London PHV Driver Licensing',
      "videoUrl": "https://youtu.be/rqGOSEi-1qI",
      'thumbnail': 'assets/Thumbnails/1.png'
    },
    {
      'title': 'Licensing Requirements for PHVs',
      "videoUrl": "https://youtu.be/-EPXmrcfyVE",
      'thumbnail': 'assets/Thumbnails/2.png'
    },
    {
      'title': 'Carrying out Private Hire Journeys',
      "videoUrl": "https://youtu.be/NuRSXOUPwq0",
      'thumbnail': 'assets/Thumbnails/3.png'
    },
    {
      'title': 'Staying Safe',
      "videoUrl": "https://youtu.be/7rllUJz6Akk",
      'thumbnail': 'assets/Thumbnails/4.png'
    },
    {
      'title': 'Driver Behaviour',
      "videoUrl": "https://youtu.be/Pe1b9ItWj9Y",
      'thumbnail': 'assets/Thumbnails/5.png'
    },
    {
      'title': 'Driving and Parking in London',
      "videoUrl": "https://youtu.be/XyK0ms2uq0o",
      'thumbnail': 'assets/Thumbnails/6.png'
    },
    {
      'title': 'Safer Driving',
      "videoUrl": "https://youtu.be/GMSxFFtzZGM",
      'thumbnail': 'assets/Thumbnails/7.png'
    },
    {
      'title': 'Being Aware of Equality and Disability',
      "videoUrl": "https://youtu.be/IaSDRoTWN6k",
      'thumbnail': 'assets/Thumbnails/8.png'
    },
    {
      'title': 'Safeguarding Children and Adults at Risk',
      "videoUrl": "https://youtu.be/9lEADQl7nv4",
      'thumbnail': 'assets/Thumbnails/9.png'
    },
    {
      'title': 'Ridesharing',
      "videoUrl": "https://youtu.be/npnJoQJwVEk",
      'thumbnail': 'assets/Thumbnails/10.png'
    },
  ];

  @override
  Widget build(
    BuildContext context,
  ) {
    ReportModel? reportModel = appController.reportModel;

    // int minAccuracy = 0;
    // int maxAccuracy = 0;

    int maxTime = 0;

    int minTime = 0;
    int i = 0;
    int right = 0;
    int time = 0;

    if (reportModel != null) {
      // List<int> list = List<int>.from(jsonDecode(reportModel.rightList!));
      List<int> list1 = List<int>.from(jsonDecode(reportModel.timeList!));

      // maxAccuracy = list.reduce(max);
      // minAccuracy = list.reduce(min);

      maxTime = list1.reduce(max);
      minTime = list1.reduce(min);

      if (minTime > quizTime) {
        minTime = quizTime;
      }

      if (maxTime > quizTime) {
        maxTime = quizTime;
      }

      right = reportModel.right!;
      time = reportModel.time!;
      i = reportModel.totalQuiz!;
    }

    if (i != 0) {
      right = (right * 10) ~/ i;
      time = (time) ~/ i;
    }

    return Stack(
      children: [
        getCommonHeader(
          context,
          widget: getHeaderTitle(
            "Learn From Video",
            context,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 20,
          ),
          margin: EdgeInsets.only(top: getHeaderTopMargin()),
          child: ListView(
            children: [
              //  AnimationConfiguration.toStaggeredList(
              // duration: const Duration(milliseconds: 800),
              // childAnimationBuilder: (widget) => SlideAnimation(
              //   horizontalOffset: MediaQuery.of(
              //         context,
              //       ).size.width /
              //       2,
              //   child: FadeInAnimation(child: widget),
              // ),
              // children:
              // Obx(() {
              //   return loginController.isLogin.value
              //       ? const CommonProfileWidget()
              //       : Container();
              // }),
              SizedBox(
                height: 50,
              ),
              getCustomText(
                "$title 1 : ${videoList[0]['title']}",
                context,
              ),
              goToVideoPage(
                videoList[0]['thumbnail']!,
                videoList[0]['videoUrl']!,
                videoList[0]['title']!,
                context,
              ),

              getCustomText(
                '$title 2 : ${videoList[1]['title']}',
                context,
              ),
              goToVideoPage(
                videoList[01]['thumbnail']!,
                videoList[1]['videoUrl']!,
                videoList[1]['title']!,
                context,
              ),

              getCustomText(
                "$title 3 : ${videoList[2]['title']}",
                context,
              ),
              goToVideoPage(
                videoList[2]['thumbnail']!,
                videoList[2]['videoUrl']!,
                videoList[2]['title']!,
                context,
              ),

              getCustomText(
                '$title 4 : ${videoList[3]['title']}',
                context,
              ),
              goToVideoPage(
                videoList[3]['thumbnail']!,
                videoList[3]['videoUrl']!,
                videoList[3]['title']!,
                context,
              ),

              getCustomText(
                "$title 5 : ${videoList[4]['title']}",
                context,
              ),
              goToVideoPage(
                videoList[4]['thumbnail']!,
                videoList[4]['videoUrl']!,
                videoList[4]['title']!,
                context,
              ),

              getCustomText(
                '$title 6 :  ${videoList[5]['title']}',
                context,
              ),
              goToVideoPage(
                videoList[5]['thumbnail']!,
                videoList[5]['videoUrl']!,
                videoList[5]['title']!,
                context,
              ),

              getCustomText(
                '$title 7 : ${videoList[6]['title']}',
                context,
              ),
              goToVideoPage(
                videoList[6]['thumbnail']!,
                videoList[6]['videoUrl']!,
                videoList[6]['title']!,
                context,
              ),

              getCustomText(
                '$title 8 : ${videoList[7]['title']}',
                context,
              ),
              goToVideoPage(
                videoList[07]['thumbnail']!,
                videoList[7]['videoUrl']!,
                videoList[7]['title']!,
                context,
              ),

              getCustomText(
                '$title 9 : ${videoList[8]['title']}',
                context,
              ),
              goToVideoPage(
                videoList[8]['thumbnail']!,
                videoList[8]['videoUrl']!,
                videoList[8]['title']!,
                context,
              ),

              getCustomText(
                '$title 10 : ${videoList[9]['title']}',
                context,
              ),
              goToVideoPage(
                videoList[9]['thumbnail']!,
                videoList[9]['videoUrl']!,
                videoList[9]['title']!,
                context,
              ),

              getVerticalSpace(60),
              // CommonDataWidget(
              //     title: 'Time Taken:',
              //     desc: 'Average',
              //     avg: right,
              //     progress: secToTime(maxTime),
              //     title1: 'Maximum',
              //     title2: 'Minimum',
              //     data1: secToTime(maxTime),
              //     data2: secToTime(minTime),
              //     outTime: quizTime),
              // CommonDataWidget(
              //     title: 'Accuracy:',
              //     desc: 'Average',
              //     progress: right.toString(),
              //     avg: right,
              //     title1: 'Highest',
              //     title2: 'Lowest',
              //     data1: maxAccuracy.toString(),
              getVerticalSpace(60),
            ],
          ),
        ),
      ],
    );
    // );
  }

  getVideoTitle(BuildContext context, String title) {
    return Container(
      margin: EdgeInsets.only(
          top: FetchPixels.getPixelHeight(10),
          bottom: FetchPixels.getPixelHeight(40),
          right: FetchPixels.getDefaultHorSpace(
            context,
          ),
          left: FetchPixels.getDefaultHorSpace(
            context,
          )),
      child: getCustomVideoTitle(
          title,
          FetchPixels.getPixelHeight(90),
          getSubFontColor(
            context,
          ),
          fontWeight: FontWeight.w600),
    );
  }

  goToVideoPage(
    String thumbnail,
    String url,
    String name,
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (
              context,
            ) =>
                VideoPage(
              name: name,
              url: url,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(5),
        ),
        margin: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 2,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Hero(
            tag: url,
            child: Image.asset(
              thumbnail,
              // fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }

  getCustomText(
    String text,
    BuildContext context,
  ) {
    return getVideoTitle(
      context,
      text,
    );
  }
}
