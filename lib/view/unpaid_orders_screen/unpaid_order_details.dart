import 'package:crater/consts/colors.dart';
import 'package:crater/controllers/home_controller.dart';
import 'package:crater/view/unpaid_orders_screen/components/unpaid_order_detail_row.dart';
import 'package:crater/widgets/custom_app_bar.dart';
import 'package:crater/widgets/text_widget.dart';
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

    return total.toString();
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
      appBar: CustomAppBar(title: widget.order["customerName"], backButton: true,),
      body: SafeArea(child: Column(
        children: [
          SizedBox(height: 20.h,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Row(
              children: [
                Expanded(child: Column(
                  children: [
                    UrduTextWidget(text: "کل رقم", fontSize: 18.sp, fontWeight: FontWeight.w600),
                  ],
                )),
                Expanded(child: Column(
                  children: [
                    UrduTextWidget(text: "رقم", fontSize: 18.sp, fontWeight: FontWeight.w600),
                  ],
                )),
                Expanded(child: Column(
                  children: [
                    UrduTextWidget(text: "اشیاء کا نام", fontSize: 18.sp, fontWeight: FontWeight.w600),
                  ],
                )),
                Expanded(child: Column(
                  children: [
                    UrduTextWidget(text: "تعداد", fontSize: 18.sp, fontWeight: FontWeight.w600),
                  ],
                )),

              ],
            ),
          ),
          SizedBox(height: 10.h,),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: widget.order["items"].length,
              itemBuilder: (context, index){
              return UnpaidOrderDetailRow(
                  itemName: widget.order["items"][index]["itemName"],
                  quantity: widget.order["items"][index]["quantity"].toString(),
                  price: widget.order["items"][index]["price"].toString(),
                  totalPrice: widget.order["items"][index]["itemTotal"].toString(),
              );
            }),
          ),
          SizedBox(height: 20.h,),
          GestureDetector(
            onTap: (){
            },
            child: Container(
              height: widget.paid ? 90.h : 50.h,
              margin: EdgeInsets.only(bottom: 10.h, right: 14.w, left: 14.w),
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(12.r),
              ),
              alignment: Alignment.center,
              child: widget.paid
                  ? Column(
                    children: [
                      RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: "Rs/ ${getTotalPrice()} ",
                          style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                        TextSpan(
                            text: ":کل رقم",
                            style: GoogleFonts.notoNastaliqUrdu(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            )),
                        // Add paid date below the total price
                      ])),
                      SizedBox(height: 20.h,),
                      Text(getFormattedPaidDate(), style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary
                      ),)
                    ],
                  )
                  : RichText(text: TextSpan(
                children: [
                  TextSpan(
                    text: "Rs/ ${getTotalPrice()} ",
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary
                    ),
                  ),
                  TextSpan(
                    text: ":کل رقم",
                    style: GoogleFonts.notoNastaliqUrdu(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary
                    )
                  )
                ]
              ))
            ),
          ),
          if(widget.paid == false)
          Obx(
              ()=> GestureDetector(
              onTap: (){
                homeVM.orderPaid(widget.order);
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
      )),
    );
  }
}
