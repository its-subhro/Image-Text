import 'package:flutter/material.dart';

class Textinfo {
  String text;
  double? left;
  double? right;
  double? top;
  Color? color;
  FontWeight? fontWeight;
  FontStyle? fontStyle;
  double? fontSize;
  TextAlign? textAlign;
  String? fontfamily;

  Textinfo(
      {required this.text,
      this.left,
      this.right,
      this.top,
      this.color,
      this.fontWeight,
      this.fontStyle,
      this.fontSize,
      this.textAlign,
      this.fontfamily});
}
