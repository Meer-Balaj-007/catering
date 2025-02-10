import 'package:crater/consts/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class UrduInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const UrduInputField({
    super.key,
    required this.controller,
    this.hintText = "اردو میں لکھیں...",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(14.r)
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.text,
        textDirection: TextDirection.rtl, // Right-to-left for Urdu
        style: GoogleFonts.notoNastaliqUrdu( fontSize: 18.sp, color: Colors.black),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle:  GoogleFonts.notoNastaliqUrdu( fontSize: 16.sp, color: Colors.black),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.r),
            borderSide: BorderSide(
                width: 1.w,
                color: Colors.black
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.r),
            borderSide: BorderSide(
                width: 1.w,
                color: Colors.black
            ),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: BorderSide(
                width: 1.w,
                color: Colors.black
              ),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 10.h),
        ),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[\u0600-\u06FF\s]')), // Allows only Urdu characters
        ],
      ),
    );
  }
}
