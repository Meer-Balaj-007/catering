import 'package:crater/consts/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class NumberInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const NumberInputField({
    super.key,
    required this.controller,
    this.hintText = "تعداد",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.30),
          borderRadius: BorderRadius.circular(14.r)
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.black, fontSize: 14.sp),
        keyboardType: TextInputType.number, // Opens number keyboard
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly, // Allows only numbers
        ],
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.notoNastaliqUrdu(color: Colors.black, fontSize: 14.sp),
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
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        ),
      ),
    );
  }
}
