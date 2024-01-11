import 'package:flutter/material.dart';
import 'package:text_editor/utils.dart';

class ImageText extends StatelessWidget {
  final Textinfo textinfo;
  const ImageText({
    super.key,
    required this.textinfo,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      textinfo.text,
      textAlign: textinfo.textAlign,
      style: TextStyle(
        color: textinfo.color,
        fontSize: textinfo.fontSize,
        fontWeight: textinfo.fontWeight,
        fontStyle: textinfo.fontStyle,
        fontFamily: textinfo.fontfamily,
      ),
    );
  }
}
