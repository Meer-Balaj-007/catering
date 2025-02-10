import 'package:crater/consts/colors.dart';
import 'package:crater/view/unpaid_orders_screen/components/delete_dialog_box.dart';
import 'package:crater/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UnpaidOrderWigdet extends StatelessWidget {
  const UnpaidOrderWigdet({super.key, required this.data});

  final Map data;

  // Function to calculate the total price of all items
  String getTotalPrice() {
    double total = 0.0;

    // Assuming the "items" key holds a list of items with "itemTotal" key for price
    List items = data["items"] ?? [];

    for (var item in items) {
      total += item["itemTotal"] ?? 0.0;
    }

    return total.toStringAsFixed(0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: (){
        Get.dialog(
            barrierDismissible: true,
            Dialog(
              child: DeleteDialogBox(order: data,),
            )
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 3,
              offset: Offset(2, 2),
            ),
          ]
        ),
        child: Row(
          children: [
            Column(
              children: [
                UrduTextWidget(
                  text: "روپے",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                  textAlign: TextAlign.end,
                ),
                SizedBox(height: 10.h,),
                UrduTextWidget(
                  text: getTotalPrice(),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                  textAlign: TextAlign.end,
                )
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  UrduTextWidget(text: "${data["order_day"]}-${data["order_month"]}-${data["order_year"]}"   , fontSize: 16.sp, fontWeight: FontWeight.w400, color: Colors.white,),
                  SizedBox(height: 8.h,),
                  UrduTextWidget(
                    text: data["customerName"],
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                  SizedBox(height: 10.h,),
                  UrduTextWidget(
                    text: data["customerNumber"],
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
