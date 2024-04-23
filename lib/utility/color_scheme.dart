import 'package:flutter/material.dart';
import 'package:flutter_logical_quiz/utility/app_extensions.dart';
import 'package:flutter_logical_quiz/utility/app_theme.dart';

extension CustomColorScheme on ColorScheme {
  Color get baseColor =>
      brightness == Brightness.light ? cellColor : darkCellColor;
  Color get reportCellColor => brightness == Brightness.light
      ? '#F8F8F8'.toColor()
      : '#2E2E2E'.toColor();
  Color get backgroundColor =>
      brightness == Brightness.light ? appBackgroundColor : darkBackgroundColor;
  Color get fontColor =>
      brightness == Brightness.light ? textColor : Colors.white;
  Color get subFontColor =>
      brightness == Brightness.light ? subTextColor : subDarkTextColor;
  Color get baseLightColor =>
      brightness == Brightness.light ? Colors.white60 : Colors.black54;
  Color get crossColor =>
      brightness == Brightness.light ? Colors.black : Colors.white;
  Color get crossLightColor =>
      brightness == Brightness.light ? const Color(0xffcdcdcd) : Colors.white60;
  Color get dividerColor =>
      brightness == Brightness.light ? const Color(0xFFeeeeee) : const Color(0xFFeeeeee);
  Color get cardBgColor =>
      brightness == Brightness.light ? cardColor : darkCardColor;
  Color get iconCardBgColor =>
      brightness == Brightness.light ? const Color(0xffF5F5F5) : Colors.black;
  Color get toolbarExpandedColor =>
      brightness == Brightness.light ? const Color(0xFFffffff) : const Color(0xFF000000);
  Color get toolbarCollapsedColor =>
      brightness == Brightness.light ? const Color(0xFFffffff) : const Color(0xFF212121);
  Color get dialogBgColor =>
      brightness == Brightness.light ? cardColor : dialogColor;
  Color get infoDialogBgColor =>
      brightness == Brightness.light ? const Color(0xFFf7f7f7) : const Color(0xff212121);
  Color get dialogGifBgColor =>
      brightness == Brightness.light ? Colors.white : const Color(0xff424242);
  Color get triangleLineColor =>
      brightness == Brightness.light ? const Color(0xffeeeeee) : const Color(0xff424242);
  Color get shadowColor => brightness == Brightness.light
      ? Colors.black12.withOpacity(0.1)
      : Colors.transparent;
  Color get quizPageShadowColor => brightness == Brightness.light
      ? Colors.grey.shade300
      : Colors.transparent;
  Color get subCellColor =>
      brightness == Brightness.light ? 'F6F6F6'.toColor() : subDarkBgColor;
  Color get subSelectedCellColor =>
      brightness == Brightness.light ? subBgColor : subDarkBgColor;
}

Color getShadowColor(BuildContext context) {
  return Theme.of(context).colorScheme.shadowColor;
}

Color getQuizShadowColor(BuildContext context) {
  return Theme.of(context).colorScheme.quizPageShadowColor;
}
Color getReportColor(BuildContext context) {
  return Theme.of(context).colorScheme.reportCellColor;
}

Color getSubColor(BuildContext context) {
  return Theme.of(context).colorScheme.subCellColor;
}

Color getSubSelected(BuildContext context) {
  return Theme.of(context).colorScheme.subSelectedCellColor;
}

Color getFontColor(BuildContext context) {
  return Theme.of(context).colorScheme.fontColor;
}

getPrimaryColor(BuildContext context) {
  return Theme.of(context).primaryColor;
}

getSubFontColor(BuildContext context) {
  return Theme.of(context).colorScheme.subFontColor;
}

getBackgroundColor(BuildContext context) {
  return Theme.of(context).colorScheme.backgroundColor;
}

getCardColor(BuildContext context) {
  return Theme.of(context).colorScheme.cardBgColor;
}

getDialogBgColor(BuildContext context) {
  return Theme.of(context).colorScheme.dialogBgColor;
}

getBaseColor(BuildContext context) {
  return Theme.of(context).colorScheme.baseColor;
}
