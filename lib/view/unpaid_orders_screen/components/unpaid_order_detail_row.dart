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

class PaidOrderDetailRow extends StatefulWidget {
  const PaidOrderDetailRow({super.key, required this.itemName, required this.quantity, required this.price, required this.totalPrice, this.remaining});

  final String itemName;
  final String quantity;
  final String price;
  final String totalPrice;
  final String? remaining;

  @override
  State<PaidOrderDetailRow> createState() => _PaidOrderDetailRowState();
}

class _PaidOrderDetailRowState extends State<PaidOrderDetailRow> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text( double.parse(widget.totalPrice).toStringAsFixed(0), style: GoogleFonts.inter(
                    fontSize: 14.sp, fontWeight: FontWeight.w500
                ),),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text( widget.price, style: GoogleFonts.inter(
                    fontSize: 14.sp, fontWeight: FontWeight.w500
                ),),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                UrduTextWidget(text: widget.itemName, fontSize: 14.sp, fontWeight: FontWeight.w500),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    UrduTextWidget(text: double.parse(widget.quantity).toStringAsFixed(0), fontSize: 14.sp, fontWeight: FontWeight.w500),
                    if(widget.remaining != null && widget.remaining! != "")
                      Container(
                        padding: EdgeInsets.all(6.w),
                        margin: EdgeInsets.only(top: 5.h),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1.w,
                            color: Colors.black
                          )
                        ),
                        child: Text(widget.remaining!, style: GoogleFonts.inter(
                          fontSize: 15.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w500
                        ),),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}