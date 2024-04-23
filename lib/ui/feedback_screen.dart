
// ignore_for_file: deprecated_member_use

import 'package:mailto/mailto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../resizer/fetch_pixels.dart';
import '../resizer/widget_utils.dart';




class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FeedbackScreen();
  }
}

class _FeedbackScreen extends State<FeedbackScreen> {
  void backClicks() {
    if(kIsWeb){
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pop();
      });
    }else {
      Navigator.of(context).pop();
    }
  }

  ValueNotifier darkMode = ValueNotifier(false);


  double rate=0;
  @override
  void initState() {
    super.initState();


    getSpeakerVol();
  }

  getSpeakerVol() async {

    Future.delayed(Duration.zero,(){
      darkMode.value = Theme.of(context).brightness != Brightness.light;
    });
  }

  double fontTitleSize = 30;


  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    int selection = 1;







    EdgeInsets edgeInsets = EdgeInsets.symmetric(
        horizontal: FetchPixels.getDefaultHorSpace(context));
    double starSize = FetchPixels.getPixelHeight(80);

    return WillPopScope(
      child: Scaffold(
        appBar: getNoneAppBar(context),

        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: getScreenPercentSize(context, 2),),


              getCommonAppBar(context, title: '', function: () {
                backClicks();
              }),




              buildExpandedData(edgeInsets, starSize, selection, context),
              getButtonWidget(
                context,
                'Submit Feedback',
                    () async {

                  if(rate >= 3) {
                    String feedback = "";

                    if (feedbackController.value.text.isNotEmpty) {
                      feedback = feedbackController.text.toString();
                    }
                    final mailtoLink = Mailto(
                      to: ['amadirfan443@gmail.com.com'],
                     
                      subject: 'Feedback',
                      body: feedback,
                    );
                    await launchUrl(Uri.parse('$mailtoLink'));

                  }
                },
              ),

            ],
          ),
        ),
      ),
      onWillPop: () async {
        backClicks();
        return false;
      },
    );
  }
  TextEditingController feedbackController = TextEditingController();




  Expanded buildExpandedData(EdgeInsets edgeInsets, double starSize,
      int selection, BuildContext context) {

    Color fontColor= Theme.of(context).textTheme.titleSmall!.color!;
    return Expanded(
      flex: 1,
      child: ListView(
        shrinkWrap: true,
        primary: true,
        padding: edgeInsets,
        children: [
          getVerticalSpace((40)),
          getCustomFont("Give Feedback", 50, fontColor, 1,
              fontWeight: FontWeight.w700),
          getVerticalSpace(10),
          getCustomFont("Give your feedback about our app", 35, fontColor, 1,
              fontWeight: FontWeight.w500),
          getVerticalSpace(100),
          getCustomFont("Are you satisfied with this app?", 35, fontColor, 1,
              fontWeight: FontWeight.w700),
          getVerticalSpace(45),
          RatingBar(
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(
                  horizontal: FetchPixels.getPixelWidth(30)),
              allowHalfRating: false,
              itemSize: starSize,
              initialRating: 0,
              updateOnDrag: true,
              glowColor: Theme.of(context).scaffoldBackgroundColor,
              ratingWidget: RatingWidget(
                full: getSvgImageWithSize(
                    context, "star_fill.svg", starSize, starSize),
                empty: getSvgImageWithSize(
                    context, "star.svg", starSize, starSize),
                half: getSvgImageWithSize(
                    context, "star_fill.svg", starSize, starSize),
              ),
              onRatingUpdate: (rating) {
                setState(() {

                  rate = rating;
                });

              }),
          getVerticalSpace(140),
          getCustomFont("Tell us what can be improved!", 35, fontColor, 1,
              fontWeight: FontWeight.w700
          ),
          getVerticalSpace(40),
          getDefaultTextFiled(context, "Write your feedback...",
              feedbackController, fontColor, Colors.grey,
              minLines: true)
        ],
      ),
    );
  }




}

