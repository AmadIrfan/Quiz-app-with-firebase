import 'package:flutter/material.dart';

import '../../model/profile_model.dart';
import '../../resizer/fetch_pixels.dart';
import '../../resizer/widget_utils.dart';
import '../../utility/color_scheme.dart';
import '../../provider/data/LoginData.dart';

class CommonProfileWidget extends StatelessWidget {
  final bool? isEdit;
  final Function? function;

  const CommonProfileWidget({super.key, this.isEdit, this.function});

  @override
  Widget build(BuildContext context) {


    return FutureBuilder<ProfileModel?>(
      future: LoginData.getProfileData(),
      builder: (context, snapshot) {
        if (snapshot.hasData || snapshot.data != null) {
          return Column(
            children: [
              Container(
                padding:
                    EdgeInsets.all(FetchPixels.getDefaultHorSpace(context)),
                decoration: getCommonDecoration(context),
                margin: EdgeInsets.symmetric(
                  horizontal: FetchPixels.getDefaultHorSpace(context),
                ),
                child: Row(
                  children: [
                    getProfileImage(snapshot.data!.image, isSmaller: true),
                    getHorizontalSpace(50),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        getCustomFont(
                            snapshot.data!.firstName!,
                            FetchPixels.getPixelHeight(100),
                            getFontColor(context),
                            1,
                            fontWeight: FontWeight.w600),
                        getVerticalSpace(7),
                        getCustomFont(
                            snapshot.data!.phoneNumber!,
                            FetchPixels.getPixelHeight(75),
                            getSubFontColor(context),
                            1,
                            fontWeight: FontWeight.w400,
                            textAlign: TextAlign.center)
                      ],
                    )),
                    isEdit != null
                        ? InkWell(
                            onTap: () {
                              if (function != null) {
                                function!();
                              }
                            },
                            child: getSvgImageWithSize(
                                context,
                                'edit.svg',
                                FetchPixels.getPixelHeight(50),
                                FetchPixels.getPixelHeight(50),
                                color: getFontColor(context)),
                          )
                        : Container()
                  ],
                ),
              ),
              getVerticalSpace(60)
            ],
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Column(
            children: [
              Container(
                padding:
                    EdgeInsets.all(FetchPixels.getDefaultHorSpace(context)),
                decoration: getCommonDecoration(context),
                margin: EdgeInsets.symmetric(
                  horizontal: FetchPixels.getDefaultHorSpace(context),
                ),
              ),
              getVerticalSpace(60)
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
