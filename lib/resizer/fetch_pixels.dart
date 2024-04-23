import 'package:flutter/material.dart';


import 'device_util.dart';

 double defaultWidth = 45;


class FetchPixels {
  static double mockupWidth = 1080;
  static double mockupHeight = 1920;


  static double width = 0;
  static double height = 0;

    FetchPixels(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
  }

  static double getHeightPercentSize(double percent) {
    return (percent * height) / 100;
  }

  static double getWidthPercentSize(double percent) {
    return (percent * width) / 100;
  }

  static double getPixelWidth(double val) {

      if(FetchPixels.isMinus()){
        val = val - (val/2);
      }
    return val / mockupWidth * width;
  }
  static double getDialogWidth() {

    if(FetchPixels.isMinus()){
return getPixelWidth(800);
    }else{
      return   getPixelWidth(850);
    }
  }


  static bool isMinus(){
    bool isMinus=false;

    if(FetchPixels.width > 1000){
      isMinus=true;
    }
    return isMinus;
  }


  static double getPixelHeight(double val) {
    return val / mockupHeight * height;
  }


  static double getDefaultRadius() {
    return FetchPixels.getHeightPercentSize(5);
  }

  static double getDefaultWorkoutRadius() {
    return FetchPixels.getHeightPercentSize(4);
  }

  static double getDefaultAppBarHeight(BuildContext context)
  {
    return FetchPixels.getPixelHeight(150);
  }
  static double getDefaultHorSpace(BuildContext context)
  {
    return FetchPixels.getPixelWidth(45);
  }

  static double getTextScale() {
    double textScaleFactor = (width > height) ? width / mockupWidth : height / mockupHeight;
    if (DeviceUtil.isTablet) {
      textScaleFactor = height / mockupHeight;
    }

    return textScaleFactor;
  }

  static double getScale() {
    double scale =
        (width > height) ? mockupWidth / width : mockupHeight / height;

    if (DeviceUtil.isTablet) {
      scale = height / mockupHeight;
    }

    return scale;
  }
}
