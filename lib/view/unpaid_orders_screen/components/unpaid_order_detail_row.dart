import 'package:crater/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class UnpaidOrderDetailRow extends StatelessWidget {
  const UnpaidOrderDetailRow({super.key, required this.itemName, required this.quantity, required this.price, required this.totalPrice});

  final String itemName;
  final String quantity;
  final String price;
  final String totalPrice;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text( double.parse(totalPrice).toStringAsFixed(0), style: GoogleFonts.inter(
                    fontSize: 14.sp, fontWeight: FontWeight.w500
                ),),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text( price, style: GoogleFonts.inter(
                    fontSize: 14.sp, fontWeight: FontWeight.w500
                ),),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                UrduTextWidget(text: itemName, fontSize: 14.sp, fontWeight: FontWeight.w500),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                UrduTextWidget(text: double.parse(quantity).toStringAsFixed(0), fontSize: 14.sp, fontWeight: FontWeight.w500),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
