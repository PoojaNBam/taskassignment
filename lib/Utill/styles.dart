import 'package:flutter/material.dart';
import 'package:taskassignment/Utill/constants.dart';

class Styles {
  Styles._();

  static TextStyle txtRegular(
      {Color? color,
      double? fontSize,
      FontWeight? fontWeight,
      Color? decorationColor,
      TextDecoration? decoration}) {
    return TextStyle(
        fontFamily: Constants.fontRobotoRegular,
        fontSize: fontSize ?? 16,
        fontWeight: fontWeight ?? FontWeight.w400,
        color: color,
        decorationColor: decorationColor,
        decoration: decoration);
  }
}
