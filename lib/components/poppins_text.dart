import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class PoppinsText extends StatelessWidget {
  PoppinsText({
    super.key,
    required this.text,
    required this.fontSize,
    this.color,
    this.fontWeight,
    this.textAlign,
    this.overflow,
  });

  final String text;
  final double fontSize;
  Color? color;
  FontWeight? fontWeight;
  TextAlign? textAlign;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: textAlign,
      overflow: overflow,
      text,
      style: GoogleFonts.poppins(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
