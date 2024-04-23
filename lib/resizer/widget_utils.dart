// ignore_for_file: deprecated_member_use

import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_logical_quiz/provider/theme_controller.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../utility/app_theme.dart';
import '../utility/color_scheme.dart';
import '../utility/constants.dart';
import 'fetch_pixels.dart';

Widget getCustomSpaceFont(
    String text, double fontSize, Color fontColor, int maxLine,
    {TextOverflow overflow = TextOverflow.ellipsis,
    TextDecoration decoration = TextDecoration.none,
    FontWeight fontWeight = FontWeight.normal,
    TextAlign textAlign = TextAlign.start,
    String font = 'OpenSans',
    txtHeight}) {
  return Text(
    text,
    overflow: overflow,
    style: TextStyle(
        decoration: decoration,
        fontSize: fontSize,
        fontStyle: FontStyle.normal,
        color: fontColor,
        fontFamily: fontFamily,
        height: txtHeight,
        fontWeight: fontWeight),
    maxLines: maxLine,
    softWrap: true,
    textAlign: textAlign,
  );
}

Widget getErrorBuilder() {
  return Container(
    color: Colors.grey.shade200,
  );
}

getProfileImage(String? image, {bool? isSmaller}) {
  double size = FetchPixels.getPixelHeight(isSmaller == null ? 190 : 150);
  Widget imageWidget = Center(
    child: Image.asset(
      '${assetPath}profile.png',
      color: Colors.grey.shade400,
      fit: BoxFit.fill,
    ),
  );

  if (image != null && image.isNotEmpty) {
    imageWidget = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey.shade200,
        image: DecorationImage(image: NetworkImage(image), fit: BoxFit.contain),
      ),
    );
  }

  return Wrap(
    children: [
      Center(
        child: SizedBox(
          height: size,
          width: size,
          child: imageWidget,
        ),
      ),
    ],
  );
}

Widget getCustomFont(
  String text,
  double fontSize,
  Color fontColor,
  int maxLine, {
  TextOverflow overflow = TextOverflow.ellipsis,
  TextDecoration decoration = TextDecoration.none,
  FontWeight fontWeight = FontWeight.normal,
  TextAlign textAlign = TextAlign.start,
  String font = 'OpenSans',
  txtHeight,
}) {
  return Text(
    text,
    overflow: overflow,
    style: TextStyle(
      decoration: decoration,
      fontSize: fontSize,
      fontStyle: FontStyle.normal,
      color: fontColor,
      fontFamily: fontFamily,
      height: txtHeight,
      fontWeight: fontWeight,
    ),
    maxLines: maxLine,
    softWrap: true,
    textAlign: textAlign,
    textScaleFactor: FetchPixels.getTextScale(),
  );
}

Widget getCustomVideoTitle(
  String text,
  double fontSize,
  Color fontColor,
  // int maxLine,
  {
  // TextOverflow overflow = TextOverflow.ellipsis,
  TextDecoration decoration = TextDecoration.none,
  FontWeight fontWeight = FontWeight.normal,
  TextAlign textAlign = TextAlign.start,
  String font = 'OpenSans',
  txtHeight,
}) {
  return Container(
    child: Text(
      text,
      style: TextStyle(
        decoration: decoration,
        fontSize: fontSize,
        fontStyle: FontStyle.normal,
        color: fontColor,
        fontFamily: fontFamily,
        height: txtHeight,
        fontWeight: fontWeight,
      ),
      softWrap: true,
      textAlign: textAlign,
      textScaleFactor: FetchPixels.getTextScale(),
    ),
  );
}

Widget getTextWidget1(
    TextStyle textStyle, String text, TextAlign textAlign, double textSizes,
    {String? hint}) {
  return Text(
    text,
    style: TextStyle(
        decoration: TextDecoration.none,
        fontSize: textSizes,
        color: textStyle.color,
        fontFamily: textStyle.fontFamily,
        fontWeight: textStyle.fontWeight),
    textAlign: textAlign,
  );
}

Widget getTextWidget(String text, double fontSize, Color fontColor,
    {TextOverflow overflow = TextOverflow.ellipsis,
    TextDecoration decoration = TextDecoration.none,
    FontWeight fontWeight = FontWeight.normal,
    TextAlign textAlign = TextAlign.start,
    txtHeight}) {
  return Text(
    text,
    style: TextStyle(
        decoration: decoration,
        fontSize: fontSize,
        fontStyle: FontStyle.normal,
        color: fontColor,
        fontFamily: fontFamily,
        height: txtHeight,
        fontWeight: fontWeight),
    softWrap: true,
    textAlign: textAlign,
    textScaleFactor: FetchPixels.getTextScale(),
  );
}

Widget getHorSpace(double verSpace) {
  return SizedBox(
    width: verSpace,
  );
}

setStatusBarColor(Color color) {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: color));
}

getDefaultDecoration(
    {double? radius,
    Color? bgColor,
    Color? borderColor,
    bool? isShadow,
    Color? shadowColor,
    double? borderWidth,
    var shape}) {
  return ShapeDecoration(
    color: (bgColor == null) ? Colors.transparent : bgColor,
    shadows: isShadow == null
        ? []
        : [
            BoxShadow(
                color: shadowColor ?? Colors.grey.shade200,
                spreadRadius: 0,
                blurRadius: 10,
                offset: const Offset(0, 3))
          ],
    shape: SmoothRectangleBorder(
      side: BorderSide(
          color: (borderColor == null) ? Colors.transparent : borderColor,
          width: (borderWidth == null) ? 1 : borderWidth),
      borderRadius: SmoothBorderRadius(
        cornerRadius: (radius == null) ? 0 : radius,
        cornerSmoothing: 0.8,
      ),
    ),
  );
}

getDefaultCircleDecoration({
  Color? bgColor,
  Color? borderColor,
}) {
  return BoxDecoration(
      shape: BoxShape.circle,
      color: bgColor ?? Colors.transparent,
      border: Border.all(color: borderColor ?? Colors.transparent, width: 1));
}

getDefaultDecorationWithSide(
    {double? radius,
    Color? bgColor,
    Color? borderColor,
    bool? isShadow,
    Color? shadowColor,
    bool? isTopRight,
    bool? isTopLeft,
    bool? isBottomRight,
    bool? isBottomLeft}) {
  return ShapeDecoration(
    shadows: isShadow == null
        ? []
        : [
            BoxShadow(
                color: shadowColor ?? Colors.grey.shade200,
                spreadRadius: 0,
                blurRadius: 10,
                offset: const Offset(0, 3))
          ],
    color: bgColor ?? Colors.transparent,
    shape: SmoothRectangleBorder(
      side: BorderSide(
          color: (borderColor == null) ? Colors.transparent : borderColor,
          width: (borderColor == null) ? 0 : 1),
      borderRadius: SmoothBorderRadius.only(
        bottomRight: SmoothRadius(
          cornerRadius: (isBottomRight == null) ? 0 : radius!,
          cornerSmoothing: 1,
        ),
        bottomLeft: SmoothRadius(
          cornerRadius: (isBottomLeft == null) ? 0 : radius!,
          cornerSmoothing: 1,
        ),
        topLeft: SmoothRadius(
          cornerRadius: (isTopLeft == null) ? 0 : radius!,
          cornerSmoothing: 1,
        ),
        topRight: SmoothRadius(
          cornerRadius: (isTopRight == null) ? 0 : radius!,
          cornerSmoothing: 1,
        ),
      ),
    ),
  );
}

getDefaultDecorationWithBorder(
    {double? radius,
    Color? bgColor,
    Color? borderColor,
    double? borderWidth,
    bool? isShadow,
    var colors}) {
  return ShapeDecoration(
    shadows: isShadow == null
        ? []
        : [
            BoxShadow(
                color: bgColor!.withOpacity(0.3),
                spreadRadius: 0,
                blurRadius: 10,
                offset: const Offset(0, 3))
          ],
    color: bgColor ?? Colors.transparent,
    shape: SmoothRectangleBorder(
      side: BorderSide(
          color: (borderColor == null) ? Colors.transparent : borderColor,
          width: (borderColor == null) ? 0 : borderWidth ?? 1),
      borderRadius: SmoothBorderRadius(
        cornerRadius: (radius == null) ? 0 : radius,
        cornerSmoothing: 0.8,
      ),
    ),
  );
}

getDefaultButtonSize() {
  return FetchPixels.getPixelHeight(130);
}

getDefaultRadius() {
  return FetchPixels.getPixelWidth(25);
}

getDefaultBtnRadius() {
  return FetchPixels.getPixelWidth(30);
}

getDefaultFontSize() {
  return FetchPixels.getPixelHeight(95);
}

Widget getButtonWidget(BuildContext context, String s, Function function,
    {double? horizontalSpace,
    IconData? icon,
    var color,
    double? verticalSpace,
    Color? bgColor,
    bool? isProcess,
    Color? textColor,
    double? btnHeight,
    Color? iconColor}) {
  FetchPixels(context);
  double height = btnHeight ?? getDefaultButtonSize();
  double radius = getDefaultBtnRadius();
  double fontSize = btnHeight == null ? getDefaultFontSize() : 35;

  return Container(
    height: height,
    margin: EdgeInsets.symmetric(
        vertical: verticalSpace ?? FetchPixels.getDefaultHorSpace(context),
        horizontal: horizontalSpace ?? FetchPixels.getDefaultHorSpace(context)),
    child: Material(
      // <----------------------------- Outer Material
      shadowColor: Colors.transparent,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      elevation: 0,
      child: Container(
        decoration: getDefaultDecoration(
          radius: radius,
          bgColor: bgColor ?? primaryColor,
        ),
        child: Material(
          // <------------------------- Inner Material
          type: MaterialType.transparency,
          elevation: 1.0,
          color: Colors.transparent,
          shadowColor: Colors.black12,
          child: InkWell(
            //<------------------------- InkWell
            splashColor: Colors.black12,
            onTap: () {
              hideKeyboard();
              function();
            },
            child: (isProcess != null && isProcess)
                ? getProgressDialog(context)
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      s.isEmpty
                          ? Container()
                          : getCustomFont(
                              s, fontSize, textColor ?? Colors.white, 2,
                              fontWeight: FontWeight.w600),
                      getHorizontalSpace(icon == null ? 0 : 15),
                      icon == null
                          ? Container()
                          : Icon(
                              icon,
                              color: iconColor ?? Colors.white,
                              size: FetchPixels.getPixelHeight(65),
                            ),
                    ],
                  ),
          ),
        ),
      ),
    ),
  );
}

Widget getBorderButtonWidget(BuildContext context, String s, Function function,
    {double? horizontalSpace,
    IconData? icon,
    var color,
    double? verticalSpace,
    Color? borderColor,
    double? borderWidth,
    Color? textColor,
    double? btnHeight,
    Color? iconColor}) {
  FetchPixels(context);
  double height = btnHeight ?? getDefaultButtonSize();
  double radius = getDefaultBtnRadius();
  double fontSize = btnHeight == null ? getDefaultFontSize() : 35;

  return InkWell(
    child: Container(
      height: height,
      margin: EdgeInsets.symmetric(
          vertical: verticalSpace ?? FetchPixels.getDefaultHorSpace(context),
          horizontal:
              horizontalSpace ?? FetchPixels.getDefaultHorSpace(context)),
      decoration: getDefaultDecoration(
        radius: radius,
        borderColor: borderColor,
        borderWidth: 1.2,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          s.isEmpty
              ? Container()
              : getCustomFont(s, fontSize, borderColor!, 2,
                  fontWeight: FontWeight.w600),
          getHorizontalSpace(icon == null ? 0 : 15),
          icon == null
              ? Container()
              : Icon(
                  icon,
                  color: iconColor ?? Colors.white,
                  size: FetchPixels.getPixelHeight(65),
                ),
        ],
      ),
    ),
    onTap: () {
      function();
    },
  );
}

Widget getCommonOtherWidget(
    {required BuildContext context,
    required String s1,
    required String s2,
    required Function function}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      getCustomFont(
          s1, FetchPixels.getPixelHeight(80), getFontColor(context), 1,
          fontWeight: FontWeight.w400, textAlign: TextAlign.end),
      getHorizontalSpace(7),
      InkWell(
        onTap: () {
          function();
        },
        child: getCustomFont(
            s2, FetchPixels.getPixelHeight(80), getFontColor(context), 1,
            fontWeight: FontWeight.w700, textAlign: TextAlign.end),
      ),
    ],
  );
}

Widget getShadowCircle(
    {required Widget widget, double? size, Color? color, bool? isShadow}) {
  return Container(
    height: size,
    width: size,
    decoration: BoxDecoration(
      color: (color == null) ? Colors.white : color,
      shape: BoxShape.circle,
      boxShadow: isShadow == null
          ? [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ]
          : null,
    ),
    child: widget,
  );
}

getNoneAppBar(BuildContext context, {Color? color, bool? isFullScreen}) {
  color ??= getBackgroundColor(context);
  var overlayStyle = SystemUiOverlayStyle.light; // 1

  if (overlayStyle == SystemUiOverlayStyle.light) {
    overlayStyle = SystemUiOverlayStyle.dark;
  } else {
    overlayStyle = SystemUiOverlayStyle.light;
  }

  if (color == getBackgroundColor(context)) {
    ThemeController provider = Get.put(ThemeController());

    if (provider.themeMode == ThemeMode.dark) {
      overlayStyle = SystemUiOverlayStyle.light;
    } else {
      overlayStyle = SystemUiOverlayStyle.dark;
    }
  }

  return AppBar(
    toolbarHeight: 0,
    elevation: 0,
    primary: false,
    backgroundColor: color,
    systemOverlayStyle: overlayStyle.copyWith(
      statusBarColor: color,
    ),
  );
}

Widget getCommonAppBar(BuildContext context,
    {required String title,
    required Function function,
    Widget? widget,
    bool? isSpace}) {
  return Container(
    color: getBackgroundColor(context),
    margin: EdgeInsets.symmetric(
        horizontal:
            isSpace != null ? 0 : FetchPixels.getDefaultHorSpace(context)),
    height: FetchPixels.getPixelHeight(140),
    child: Stack(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: GetBuilder<ThemeController>(
            init: ThemeController(),
            builder: (value) {
              return GestureDetector(
                  onTap: () {
                    function();
                  },
                  child: SvgPicture.asset(
                    getThemeIcon(value, 'back.svg'),
                  ));
            },
          ),
        ),
        Center(
          child: getCustomFont(
              title, getDefaultFontSize(), getFontColor(context), 1,
              fontWeight: FontWeight.w700),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: widget ?? Container(),
        ),
      ],
    ),
  );
}

getHeaderTitle(String s, BuildContext context) {
  return getCustomFont(
    s,
    FetchPixels.getPixelHeight(120),
    Colors.white,
    1,
    fontWeight: FontWeight.w700,
  );
}

getHeaderTopMargin() {
  return FetchPixels.getPixelHeight(250);
}

Widget getCommonHeader(BuildContext context, {required Widget widget}) {
  return Container(
    decoration: getDefaultDecorationWithSide(
        radius: FetchPixels.getPixelHeight(80),
        bgColor: subColor,
        isBottomLeft: true),
    height: FetchPixels.getPixelHeight(350),
    padding: EdgeInsets.symmetric(
        horizontal: FetchPixels.getDefaultHorSpace(context)),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: FetchPixels.getPixelHeight(100)),
        child: widget,
      ),
    ),
  );
}

Widget getVerticalSpace(double value) {
  return SizedBox(
    height: FetchPixels.getPixelHeight(value),
  );
}

Widget getHorizontalSpace(double value) {
  return SizedBox(
    width: FetchPixels.getPixelWidth(value),
  );
}

double getScreenWidthPercentSize(BuildContext context, double percent) {
  return (MediaQuery.of(context).size.width * percent) / 100;
}

double getScreenPercentSize(BuildContext context, double percent) {
  return (MediaQuery.of(context).size.height * percent) / 100;
}

Widget getSvgImageWithSize(
    BuildContext context, String image, double width, double height,
    {Color? color, BoxFit fit = BoxFit.fill}) {
  return SvgPicture.asset(
    assetPath + image,
    color: color,
    width: width,
    height: height,
    fit: fit,
  );
}

double getEditFontSize() {
  return 35;
}

double getEditHeight() {
  return FetchPixels.getPixelHeight(130);
}

double getEditRadiusSize() {
  return FetchPixels.getPixelHeight(35);
}

Widget getSvgImage(BuildContext context, String image, double size,
    {Color? color}) {
  return SvgPicture.asset(
    assetPath + image,
    color: color,
    width: FetchPixels.getPixelWidth(size),
    height: FetchPixels.getPixelHeight(size),
    fit: BoxFit.fill,
  );
}

double getEditIconSize() {
  return 55;
}

Widget getDefaultTextFiled(
    BuildContext context,
    String s,
    TextEditingController textEditingController,
    Color fontColor,
    Color selectedTheme,
    {bool withPrefix = false,
    String imgName = "",
    bool minLines = false,
    EdgeInsetsGeometry margin = EdgeInsets.zero,
    TextInputType type = TextInputType.text}) {
  double height = getEditHeight();
  FocusNode myFocusNode = FocusNode();
  bool isAutoFocus = false;
  return StatefulBuilder(
    builder: (context, setState) {
      final mqData = MediaQuery.of(context);
      final mqDataNew =
          mqData.copyWith(textScaleFactor: FetchPixels.getTextScale());
      return MediaQuery(
        data: mqDataNew,
        child: Container(
          height: (minLines) ? (height * 2.2) : height,
          margin: margin,
          padding: EdgeInsets.symmetric(
              horizontal: FetchPixels.getPixelWidth(18), vertical: 0),
          alignment: (minLines) ? Alignment.topLeft : Alignment.centerLeft,
          decoration: ShapeDecoration(
            color: Colors.transparent,
            shape: SmoothRectangleBorder(
              side: BorderSide(
                  color: isAutoFocus ? selectedTheme : Colors.grey, width: 1),
              borderRadius: SmoothBorderRadius(
                cornerRadius: getEditRadiusSize(),
                cornerSmoothing: 0.8,
              ),
            ),
          ),
          child: Focus(
              onFocusChange: (hasFocus) {
                if (hasFocus) {
                  setState(() {
                    isAutoFocus = true;
                    myFocusNode.canRequestFocus = true;
                  });
                } else {
                  setState(() {
                    isAutoFocus = false;
                    myFocusNode.canRequestFocus = false;
                  });
                }
              },
              child: SizedBox(
                height: double.infinity,
                child: (minLines)
                    ? TextField(
                        maxLines: (minLines) ? null : 1,
                        controller: textEditingController,
                        autofocus: false,
                        focusNode: myFocusNode,
                        textAlign: TextAlign.start,
                        keyboardType: type,
                        expands: minLines,
                        style: TextStyle(
                            fontFamily: fontFamily,
                            color: fontColor,
                            fontWeight: FontWeight.w500,
                            fontSize: getEditFontSize()),
                        decoration: InputDecoration(
                            prefixIconConstraints: const BoxConstraints(
                              minWidth: 0,
                              minHeight: 0,
                            ),
                            prefixIcon: (withPrefix)
                                ? Padding(
                                    padding: EdgeInsets.only(
                                        right: FetchPixels.getPixelWidth(3)),
                                    child: getSvgImage(
                                        context, imgName, getEditIconSize()),
                                  )
                                : getHorSpace(0),
                            border: InputBorder.none,
                            isDense: true,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: s,
                            hintStyle: TextStyle(
                                fontFamily: fontFamily,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: getEditFontSize())),
                      )
                    : Center(
                        child: TextField(
                        maxLines: (minLines) ? null : 1,
                        keyboardType: type,
                        controller: textEditingController,
                        autofocus: false,
                        focusNode: myFocusNode,
                        textAlign: TextAlign.start,
                        expands: minLines,
                        style: TextStyle(
                            fontFamily: fontFamily,
                            color: fontColor,
                            fontWeight: FontWeight.w500,
                            fontSize: getEditFontSize()),
                        decoration: InputDecoration(
                            prefixIconConstraints: const BoxConstraints(
                              minWidth: 0,
                              minHeight: 0,
                            ),
                            prefixIcon: (withPrefix)
                                ? Padding(
                                    padding: EdgeInsets.only(
                                        right: FetchPixels.getPixelWidth(3)),
                                    child: getSvgImage(
                                        context, imgName, getEditIconSize()),
                                  )
                                : getHorSpace(0),
                            border: InputBorder.none,
                            isDense: true,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: s,
                            hintStyle: TextStyle(
                                fontFamily: fontFamily,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: getEditFontSize())),
                      )),
              )),
        ),
      );
    },
  );
}

Widget getDefaultTextFiledWidget(
    BuildContext context, String s, TextEditingController textEditingController,
    {bool? isEnabled,
    var inputType,
    var inputFormatters,
    var onChanged,
    required var focus,
    Function? onTapFunction}) {
  double height = getDefaultButtonSize();
  double radius = getDefaultRadius();
  double fontSize = FetchPixels.getPixelHeight(40);

  return Container(
    height: height,
    alignment: Alignment.centerLeft,
    decoration: getDefaultDecorationWithBorder(
        radius: radius,
        borderColor: focus ? primaryColor : getSubFontColor(context),
        borderWidth: focus ? 1 : 0.4),
    child: TextFormField(
      maxLines: 1,
      onTap: () {
        if (onTapFunction != null) {
          onTapFunction();
        }
      },
      enabled: (isEnabled != null) ? isEnabled : true,
      controller: textEditingController,
      textAlign: TextAlign.start,
      textAlignVertical: TextAlignVertical.center,
      keyboardType: (inputType != null) ? inputType : null,
      inputFormatters: (inputFormatters != null) ? inputFormatters : null,
      onChanged: (onChanged != null) ? onChanged : null,
      style: TextStyle(
          fontFamily: fontFamily,
          color: getFontColor(context),
          fontWeight: FontWeight.w400,
          fontSize: fontSize),
      decoration: InputDecoration(
          contentPadding:
              EdgeInsets.only(left: FetchPixels.getDefaultHorSpace(context)),
          border: const OutlineInputBorder(),
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: s,
          isDense: true,
          hintStyle: TextStyle(
              fontFamily: fontFamily,
              color: getSubFontColor(context),
              fontWeight: FontWeight.w400,
              fontSize: fontSize)),
    ),
  );
}

Widget getPasswordTextFiledWidget(BuildContext context, String s,
    TextEditingController textEditingController, Function function,
    {bool? isEnabled,
    var inputType,
    var inputFormatters,
    var onChanged,
    var focus,
    Function? onTapFunction,
    var isObscureText}) {
  double height = getDefaultButtonSize();
  double radius = getDefaultRadius();
  double fontSize = FetchPixels.getPixelHeight(40);

  return GetBuilder<ThemeController>(
    init: ThemeController(),
    builder: (value) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Container(
            height: height,
            alignment: Alignment.centerLeft,
            decoration: getDefaultDecorationWithBorder(
                radius: radius,
                borderColor: focus ? primaryColor : getSubFontColor(context),
                borderWidth: focus ? 1 : 0.4),
            child: TextFormField(
              obscureText: isObscureText,
              maxLines: 1,
              enabled: (isEnabled != null) ? isEnabled : true,
              controller: textEditingController,
              textAlign: TextAlign.start,
              textAlignVertical: TextAlignVertical.center,
              keyboardType: (inputType != null) ? inputType : null,
              onTap: () {
                setState(() {});

                if (onTapFunction != null) {
                  onTapFunction();
                }
              },
              inputFormatters:
                  (inputFormatters != null) ? inputFormatters : null,
              onChanged: (onChanged != null) ? onChanged : null,
              style: TextStyle(
                  fontFamily: fontFamily,
                  color: getFontColor(context),
                  fontWeight: FontWeight.w400,
                  fontSize: fontSize),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: FetchPixels.getDefaultHorSpace(context)),
                  border: const OutlineInputBorder(),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: s,
                  isDense: true,
                  suffixIconConstraints: BoxConstraints(
                    minWidth: FetchPixels.getPixelHeight(6),
                    minHeight: FetchPixels.getPixelHeight(6),
                  ),
                  suffixIcon: GestureDetector(
                      onTap: () {
                        isObscureText = !isObscureText;
                        function(isObscureText);
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            right: FetchPixels.getDefaultHorSpace(context)),
                        child: SvgPicture.asset(getThemeIcon(value, 'eye.svg')),
                      )),
                  hintStyle: TextStyle(
                      fontFamily: fontFamily,
                      fontWeight: FontWeight.w400,
                      color: getSubFontColor(context),
                      fontSize: fontSize)),
            ),
          );
        },
      );
    },
  );
}

showCustomToast({required BuildContext context, required String message}) {
  FocusManager.instance.primaryFocus?.unfocus();

  Get.snackbar(
    '',
    '',
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: getSubFontColor(context),
    borderRadius: 0,
    margin: EdgeInsets.all(FetchPixels.getPixelHeight(0)),
    padding: EdgeInsets.symmetric(
        vertical: FetchPixels.getPixelHeight(20),
        horizontal: FetchPixels.getPixelWidth(40)),
    colorText: Colors.white,
    duration: const Duration(seconds: 3),
    isDismissible: true,
    titleText: const Text(
      '',
      style: TextStyle(fontSize: 0),
    ),
    messageText: Container(
      margin: EdgeInsets.only(bottom: FetchPixels.getPixelHeight(15)),
      child: Text(
        message,
        style: TextStyle(
            fontSize: FetchPixels.getPixelHeight(40),
            fontWeight: FontWeight.w400,
            color: getBackgroundColor(context)),
      ),
    ),
  );
}

getProgressDialog(BuildContext context, {Color? color}) {
  return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Center(
          child: CupertinoActivityIndicator(
              color: color ?? getFontColor(context).withOpacity(0.5))));
}

getCommonDecoration(BuildContext context) {
  return getDefaultDecoration(
    isShadow: true,
    shadowColor: getShadowColor(context),
    bgColor: getCardColor(context),
    radius: FetchPixels.getPixelHeight(40),
  );
}

getOptionType(int position) {
  if (position == 0) {
    return "A.";
  } else if (position == 1) {
    return "B.";
  } else if (position == 2) {
    return "C.";
  } else if (position == 3) {
    return "D.";
  } else {
    return "A.";
  }
}

getCommonButton({required Color color, required Widget widget}) {
  return Container(
    padding: EdgeInsets.symmetric(
        horizontal: FetchPixels.getPixelWidth(35),
        vertical: FetchPixels.getPixelHeight(17)),
    decoration: BoxDecoration(
        color: color,
        borderRadius:
            BorderRadius.all(Radius.circular(FetchPixels.getPixelHeight(60)))),
    child: widget,
  );
}

getSkipButton(BuildContext context) {
  return getCommonButton(
      color: skipColor,
      widget: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            '${assetPath}skipped.png',
            height: FetchPixels.getPixelHeight(40),
            width: FetchPixels.getPixelHeight(40),
          ),
          getHorizontalSpace(20),
          getCustomFont('Skipped', FetchPixels.getPixelHeight(75),
              getFontColor(context), 2,
              fontWeight: FontWeight.w600),
        ],
      ));
}

getCorrectButton() {
  return getCommonButton(
      color: greenColor,
      widget: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            '${assetPath}right.png',
            height: FetchPixels.getPixelHeight(40),
            width: FetchPixels.getPixelHeight(40),
          ),
          getHorizontalSpace(20),
          getCustomFont(
              'Correct', FetchPixels.getPixelHeight(75), Colors.white, 2,
              fontWeight: FontWeight.w600),
        ],
      ));
}

getWrongButton() {
  return getCommonButton(
      color: redColor,
      widget: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            '${assetPath}ic_close.png',
            height: FetchPixels.getPixelHeight(40),
            width: FetchPixels.getPixelHeight(40),
          ),
          getHorizontalSpace(20),
          getCustomFont(
              'Wrong', FetchPixels.getPixelHeight(75), Colors.white, 2,
              fontWeight: FontWeight.w600),
        ],
      ));
}

getThemeIcon(ThemeController provider, String icon) {
  return provider.themeMode == ThemeMode.dark
      ? '${assetPath}dark_$icon'
      : '$assetPath$icon';
}
