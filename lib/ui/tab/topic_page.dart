import 'package:flutter_logical_quiz/app_purchase/purchaseable_product.dart';
import 'package:flutter_logical_quiz/model/profile_model.dart';
import 'package:flutter_logical_quiz/provider/data/LoginData.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../ads/AdsFile.dart';
import '../../app_purchase/dash_purchases.dart';
import '../../app_purchase/in_app_purchase_page.dart';
import '../../ui/quiz_page.dart';
import '../../utility/constants.dart';
import '../../model/topic_model.dart';
import '../../resizer/fetch_pixels.dart';
import '../../resizer/widget_utils.dart';
import '../../utility/color_scheme.dart';
import '../../provider/login_controller.dart';
import '../../provider/topic_controller.dart';
import '../../provider/check_data_controller.dart';

class TopicPage extends StatelessWidget {
//   final AdsFile adsFile;
  final LoginController loginController;

  TopicPage({
    super.key,
//     required this.adsFile,
    required this.loginController,
  });

  final TopicController topicController = Get.put(TopicController());
  final CheckDataController checkDataController =
      Get.put(CheckDataController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        getCommonHeader(
          context,
          widget: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getHeaderTitle("Quiz Topics", context),
                    getVerticalSpace(10),
                    getCustomFont(
                      'Select a topic to practice',
                      FetchPixels.getPixelHeight(80),
                      Colors.white,
                      1,
                      fontWeight: FontWeight.w400,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: getHeaderTopMargin()),
          child: Obx(() {
            if (topicController.isLoading.value) {
              return getProgressDialog(context);
            } else {
              return AnimationLimiter(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(
                      horizontal: FetchPixels.getDefaultHorSpace(context)),
                  itemCount: topicController.list.length,
                  itemBuilder: (context, index) {
                    TopicModel model = TopicModel.fromFirestore(
                      topicController.list[index],
                    );
                    return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                          verticalOffset: 50,
                          child: FadeInAnimation(
                            child: InkWell(
                              onTap: () {
                                // loginController.getUser().then((value) {
                                //   if (value.isNotEmpty &&
                                //       loginController.isLogin.value) {
                                checkDataController.fetchData(model.refId!,
                                    (value) async {
                                  if (value) {
                                    // showInterstitialAd(adsFile, () {
                                    // ProfileModel? pm =
                                    //     await LoginData.getProfileData();
                                    // print(pm?.purchase_status);
                                    // if (pm?.purchase_status !=
                                    //     status_purchased) {
                                    //     Navigator.push(
                                    //       context,
                                    //       MaterialPageRoute(
                                    //         builder: (context) => PurchasePage(
                                    //           topicModel: model,
                                    //           // loginController:
                                    //           //     loginController,
                                    //         ),
                                    //       ),
                                    //     );
                                    // } else {
                                    pushPage(
                                      QuizPage(
                                        topicModel: model,
                                        isFirstPurchased: false,
                                      ),
                                    );
                                    //       function: (value) {
                                    //         if (value != null && value) {}
                                    //       },
                                    //     );
                                    // }
                                    // });
                                    //       } else {
                                    //         showCustomToast(
                                    //             context: context,
                                    //             message: 'data not available');
                                    //       }
                                    //     });
                                  } else {
                                    //     sendLoginPage(
                                    //         context: context, function: () {});
                                  }
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    bottom: FetchPixels.getPixelHeight(40)),
                                height: FetchPixels.getPixelHeight(140),
                                decoration: getDefaultDecoration(
                                    isShadow: true,
                                    shadowColor: getShadowColor(context),
                                    radius: FetchPixels.getPixelHeight(25),
                                    bgColor: getCardColor(context)),
                                padding: EdgeInsets.symmetric(
                                    horizontal: FetchPixels.getDefaultHorSpace(
                                        context)),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      '${assetPath}dot.png',
                                      color: getFontColor(context),
                                      height: FetchPixels.getPixelHeight(24),
                                      width: FetchPixels.getPixelHeight(24),
                                    ),
                                    getHorizontalSpace(30),
                                    Expanded(
                                      flex: 1,
                                      child: getCustomFont(
                                          model.title!,
                                          FetchPixels.getPixelHeight(85),
                                          getFontColor(context),
                                          1,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Image.asset(
                                      '${assetPath}next.png',
                                      color: getFontColor(context),
                                      height: FetchPixels.getPixelHeight(25),
                                      width: FetchPixels.getPixelHeight(25),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ));
                  },
                ),
              );
            }
          }),
        )
      ],
    );
  }
}
