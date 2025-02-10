import 'package:crater/consts/colors.dart';
import 'package:crater/controllers/home_controller.dart';
import 'package:crater/view/unpaid_orders_screen/components/unpaid_order_detail_row.dart';
import 'package:crater/widgets/custom_app_bar.dart';
import 'package:crater/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class UnpaidOrderDetails extends StatefulWidget {
  const UnpaidOrderDetails({super.key, required this.order, required this.paid});

  final Map order;
  final bool paid;

  @override
  State<UnpaidOrderDetails> createState() => _UnpaidOrderDetailsState();
}

class _UnpaidOrderDetailsState extends State<UnpaidOrderDetails> {
  final HomeController homeVM = Get.put(HomeController());



  String getTotalPrice() {
    double total = 0.0;

    // Assuming the "items" key holds a list of items with "itemTotal" key for price
    List items = widget.order["items"] ?? [];

    for (var item in items) {
      total += item["itemTotal"] ?? 0.0;
    }

    return total.toStringAsFixed(0);
  }

  String getFormattedPaidDate() {
    if (widget.order["paid_at"] == null) return ""; // If paidAt is null, return empty string

    DateTime paidDate = widget.order["paid_at"].toDate(); // Convert Timestamp to DateTime
    String formattedDate = DateFormat('dd MMM yyyy, hh:mm:a').format(paidDate); // Format to yyyy MM dd
    return "$formattedDate"; // Return the date in Urdu
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        toolbarHeight: 125.h,
        leadingWidth: 0.w,
        centerTitle: true,
        leading: SizedBox(),
        title: Row(
          children: [
            Container(
              height: 70.h,
              width: 70.w,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/images/spoons.png"), fit: BoxFit.fill)
              ),
            ),
            Expanded(
              child: Column(
                children: [

                  UrduTextWidget(text: "مشتاق ٹینٹ سروس", fontSize: 20.sp, fontWeight: FontWeight.w900,),
                  SizedBox(height: 15.h,),
                  Text("03003307863", style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondary
                  ),),
                  Text("03027312235", style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondary
                  ),),
                  SizedBox(height: 7.h,),
                  UrduTextWidget(text: "سیداں والی کھوئی، نواب پور روڈ، ملتان", fontSize: 14.sp, fontWeight: FontWeight.w600,),

                ],
              ),
            ),
            SizedBox(
              height: 70.h,
              width: 70.w,
            ),
          ],
        ),
        backgroundColor: AppColors.primary,
      ),
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      UrduTextWidget(text: widget.order["customerNumber"], fontSize: 16.sp, fontWeight: FontWeight.w500),

                      SizedBox(width: 3.w,),
                      UrduTextWidget(text: " :نمبر", fontSize: 18.sp, fontWeight: FontWeight.w600),
                    ],
                  ),
                  Row(
                    children: [
                      UrduTextWidget(text: "${widget.order["order_day"]}-${widget.order["order_month"]}-${widget.order["order_year"]}"   , fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.black,),
                      UrduTextWidget(text: " :تاریخ", fontSize: 18.sp, fontWeight: FontWeight.w600),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  UrduTextWidget(text: widget.order["customerName"], fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.black,),
                  UrduTextWidget(text: "  :گاہک کا نام", fontSize: 18.sp, fontWeight: FontWeight.w600),
                ],
              ),
            ),
           SizedBox(height: 20.h,),
            Container(
              height: 1.h,
              margin: EdgeInsets.symmetric(vertical: 10.h),
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    AppColors.primary,
                    AppColors.secondary,
                    AppColors.primary
                  ])
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        UrduTextWidget(text: "روپے", fontSize: 18.sp, fontWeight: FontWeight.w600),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        UrduTextWidget(text: "ریٹ", fontSize: 18.sp, fontWeight: FontWeight.w600),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        UrduTextWidget(text: "نام/آئٹم", fontSize: 18.sp, fontWeight: FontWeight.w600),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        UrduTextWidget(text: "تعداد", fontSize: 18.sp, fontWeight: FontWeight.w600),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h,),
            ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.order["items"].length,
              itemBuilder: (context, index){
              return UnpaidOrderDetailRow(
                  itemName: widget.order["items"][index]["itemName"],
                  quantity: widget.order["items"][index]["quantity"].toString(),
                  price: widget.order["items"][index]["price"].toString(),
                  totalPrice: widget.order["items"][index]["itemTotal"].toString(),
              );
            }),
            Container(
              height: 1.h,
              margin: EdgeInsets.symmetric(vertical: 10.h),
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    AppColors.primary,
                    AppColors.secondary,
                    AppColors.primary
                  ])
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 14.0.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: RichText(text: TextSpan(
                    children: [
                      TextSpan(
                        text: "${getTotalPrice()} ",
                        style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.secondary
                        ),
                      ),
                      TextSpan(
                          text: " :روپے",
                          style: GoogleFonts.notoNastaliqUrdu(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.secondary
                          )
                      )
                    ]
                ),
                ),),
            ),
            SizedBox(height: 20.h,),
            if(widget.paid == false)
            Obx(
                ()=> GestureDetector(
                onTap: () async{
                 await homeVM.orderPaid(widget.order);
                 // await homeVM.generateInvoicePdf(widget.order, getTotalPrice());
                 //await homeVM.generateInvoiceImage(widget.order, getTotalPrice(), context);
                },
                child: Container(
                    margin: EdgeInsets.only(bottom: 10.h, right: 14.w, left: 14.w),
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    alignment: Alignment.center,
                    child: homeVM.loading.value ? CircularProgressIndicator(color: AppColors.primary,) : UrduTextWidget(
                        text: "ادائیگی موصول",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                    )
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
