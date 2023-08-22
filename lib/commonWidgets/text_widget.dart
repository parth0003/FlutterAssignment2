import 'package:flutter/material.dart';

Widget textWidget(String text, Color textColor, double textSize, FontWeight fontWeight,
    {double letterSpace = 0.15,
      TextAlign textAlign = TextAlign.start,
      double lineSpace = 1.0,
      dynamic maxLine,
      dynamic fontStyle,
      TextDecoration? textDecoration,
      dynamic overFlow}) {
  return Text(
    text,
    style: TextStyle(
        color: textColor,
        fontSize: textSize,
        fontFamily: 'Roboto',
        fontStyle: fontStyle,
        height: lineSpace,
        decoration: textDecoration,
        letterSpacing: letterSpace,
        fontWeight: fontWeight),
    textAlign: textAlign,
    maxLines: maxLine,
    overflow: overFlow,
  );
}