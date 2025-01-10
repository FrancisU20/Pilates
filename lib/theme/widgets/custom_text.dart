import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pilates/theme/app_colors.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color? color;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final bool? softWrap;
  final int? maxLines;

  const CustomText({
    super.key,
    required this.text,
    required this.fontSize,
    this.color = AppColors.black100,
    this.textAlign = TextAlign.center,
    this.fontWeight = FontWeight.normal,
    this.overflow = TextOverflow.visible,
    this.softWrap = true,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
        textStyle: TextStyle(
          color: color,
          fontSize:fontSize,
          fontWeight: fontWeight,
        ),
      ),
      textAlign: textAlign,
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}

