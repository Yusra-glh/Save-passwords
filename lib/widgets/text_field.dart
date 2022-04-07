import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../config/textStyle.dart';

Widget textFormField(hm,wm,tm,hintText,controller){
  return TextFormField(
    controller: controller,
    obscureText:hintText=="Password"?true:false,
    style:
    tS('NunitoRegular', tm * 2, FontWeight.normal, Colors.black),
    decoration: InputDecoration(
      hintText: "$hintText",
      hintStyle:
      tS('NunitoRegular', tm * 2, FontWeight.normal, Colors.black.withOpacity(0.24)),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
            color: Colors.black.withOpacity(0.24), width: wm * 0.4),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
            color: Colors.black.withOpacity(0.24), width: wm * 0.4),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
            color: Colors.red, width: wm * 0.4),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
            color: Colors.red, width: wm * 0.4),
      ),
      errorStyle: tS('NunitoRegular', tm * 2, FontWeight.normal, Colors.red),
    ),
  );
}
