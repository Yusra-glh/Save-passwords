import 'package:flutter/material.dart';
import 'package:save_password/config/size_config.dart';

class AppStyle{
  static const Color primary = Color.fromRGBO(21, 15, 138,0.9);
  static const Color secondary = Color.fromRGBO(73, 95, 130, 0.9);
  static const Color background = Color(0xffFBFBFB);
  static const Color redAlert = Color(0xffFF0000);
  static const Color greenSuccess = Color(0xff008600);
  static const Color yellowWarning = Color(0xffFF8E00);
  static const Color disabledGrey = Color(0xffC8C8C8);
  static const Color buttonSuccess =Color(0xff4CAF50);
  static  TextStyle  title = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: SizeConfig.textMultiplier*2.1
  );
  static TextStyle tS(String fontFamily,double fontSize,FontWeight fontWeight,Color color,{TextDecoration? textDecoration, double? decorationThickness,Color? decorationColor, TextOverflow? textOverflow,double? textHeight}) {
    return  TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        decoration: textDecoration,
        decorationThickness: decorationThickness,
        decorationColor: decorationColor,
        overflow: textOverflow,
        height:textHeight

    );
  }
}


