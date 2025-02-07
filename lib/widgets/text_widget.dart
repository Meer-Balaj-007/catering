import 'package:crater/consts/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UrduTextWidget extends StatelessWidget {
  const UrduTextWidget({
    super.key,
    required this.text,
    required this.fontSize,
    required this.fontWeight,
    this.color = AppColors.secondary,
    this.textAlign = TextAlign.center,
  });

  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? color;
  final TextAlign? textAlign;


  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.notoNastaliqUrdu(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        decoration: TextDecoration.none
      ),
    );
  }
}
