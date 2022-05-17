import 'package:flutter/material.dart';
import 'package:save_password/config/validators.dart';

import '../config/textStyle.dart';

Widget roundedTextField(context, wm, hm, tm, controller, hint,
    {String? oldPassword}) {
  return Container(
    height: hm * 5.5,
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(wm * 2)),
    child: TextFormField(
      autovalidateMode: (hint == "Password" || hint == "Confirm password")
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      obscureText:
          hint == "Password" || hint == "Confirm password" ? true : false,
      controller: controller,
      keyboardType: TextInputType.text,
      style: tS('NunitoRegular', tm * 2, FontWeight.normal, Colors.black),
      validator: (val) =>
          Validators.RegisterValidator(val, hint, oldPassword: oldPassword),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(wm * 2.5, 0, wm * 2.5, 0),
          hintText: hint,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(wm * 4),
              borderSide: BorderSide(color: Colors.grey, width: wm * 0.2)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(wm * 2),
              borderSide: BorderSide(color: Colors.grey, width: wm * 0.2)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(wm * 2),
              borderSide: BorderSide(color: Colors.red, width: wm * 0.2)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(wm * 2),
              borderSide:
                  BorderSide(color: const Color(0xff707070), width: wm * 0.2)),
          errorStyle:
              tS('NunitoRegular', tm * 2, FontWeight.normal, Colors.red)),
    ),
  );
}
