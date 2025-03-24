import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final double? letterSpacing;
  final Color? color;
  final FontWeight? fontWeight;
  final Alignment? alignment;
  final int? maxLines;
  final TextOverflow? textOverflow;
  const CustomText(
      {super.key,
      this.text = "",
      this.color,
      this.alignment = Alignment.topLeft,
      this.fontWeight,
      this.letterSpacing,
      this.maxLines,
      this.fontSize,  this.textOverflow});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: Text(
        text,
        maxLines: maxLines,
        style: GoogleFonts.openSans(
            letterSpacing: letterSpacing,
            color: color,
            fontSize: fontSize,
            fontWeight: fontWeight),
        overflow: textOverflow,
      ),
    );
  }
}
