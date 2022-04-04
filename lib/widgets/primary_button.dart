
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../config/style.dart';

GestureDetector primaryButton({required double height, required double width,required Widget widget, Function? function,BorderRadius? borderRadius, Color? color,Border? border}) {
  return GestureDetector(
    onTap: ()async{
      if(function!=null){
        function();
      }
    },
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        border:border,
        color: color ?? Colors.indigo,
        borderRadius: borderRadius,
      ),
      child: Center(child: widget),
    ),
  );
}
