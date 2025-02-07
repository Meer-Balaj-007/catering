import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crater/consts/colors.dart';
import 'package:crater/view/unpaid_orders_screen/components/unpaid_order_widet.dart';
import 'package:crater/view/unpaid_orders_screen/unpaid_order_details.dart';
import 'package:crater/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PaidOrdersScreen extends StatefulWidget {
  const PaidOrdersScreen({super.key});

  @override
  State<PaidOrdersScreen> createState() => _PaidOrdersScreenState();
}

class _PaidOrdersScreenState extends State<PaidOrdersScreen> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("records").snapshots(),
      builder: (context, snapshot) {

        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(color: AppColors.secondary));
        } else if (snapshot.hasError) {
          return UrduTextWidget(text: "ڈیٹا لوڈ کرنے میں مسئلہ درپیش ہے", fontSize: 16.sp, fontWeight: FontWeight.w500);
        } else if (snapshot.data!.docs.isEmpty && !snapshot.hasData){
          return UrduTextWidget(text: "کوئی آرڈرز موجود نہیں", fontSize: 16.sp, fontWeight: FontWeight.w500);
        } else if (snapshot.connectionState == ConnectionState.none){
          return UrduTextWidget(text: "کوئی آرڈرز موجود نہیں", fontSize: 16.sp, fontWeight: FontWeight.w500);
        } else {

          var ordersData = snapshot.data!.docs;

          print(ordersData);

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.0.w),
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  ListView.builder(
                    itemCount: ordersData.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {

                      return Column(
                        children: [
                          if (index != 0)
                            Container(
                              height: 1.h,
                              margin: EdgeInsets.symmetric(vertical: 15.h, horizontal: 40.w),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  AppColors.primary,
                                  AppColors.secondary,
                                  AppColors.primary
                                ]),
                              ),
                            ),
                          GestureDetector(
                            onTap: () {
                              Get.to(UnpaidOrderDetails(order: ordersData[index]["paid_order"], paid: true,));
                            },
                            child: UnpaidOrderWigdet(data: ordersData[index]["paid_order"]),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }

      }
    );
  }
}
