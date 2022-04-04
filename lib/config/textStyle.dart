import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


TextStyle tS(String fontFamily,double fontSize,FontWeight fontWeight,Color color,{TextDecoration? textDecoration, double? decorationThickness,Color? decorationColor, TextOverflow? textOverflow,double? textHeight}) {
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
