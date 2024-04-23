import 'package:flutter/material.dart';

import '../../resizer/widget_utils.dart';

class CustomIconButton {
  final String? text;
  final Icon? icon;
  final Color color;

  const CustomIconButton({
    this.text,
    this.icon,
    required this.color,
  });
}

Widget buildChildWithIcon(
    CustomIconButton customIconButton, double iconPadding, TextStyle textStyle) {
  return buildChildWithIC(
      customIconButton.text, customIconButton.icon, iconPadding, textStyle);
}

Widget buildChildWithIC(
    String? text, Icon? icon, double gap, TextStyle textStyle) {
  var children = <Widget>[];

  if(icon!=null) {
    children.add(icon );
  }
  if (text != null) {

    if(text.isNotEmpty
    ){
      children.add(buildText(text, textStyle));
    }



  }

  return Wrap(
    direction: Axis.horizontal,
    crossAxisAlignment: WrapCrossAlignment.center,
    children: children,
  );
}

Widget buildText(String text, TextStyle style) {
  return getCustomFont(text, getDefaultFontSize(), Colors.white, 2,
      fontWeight: FontWeight.w600);
}
