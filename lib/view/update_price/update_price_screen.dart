import 'package:crater/consts/colors.dart';
import 'package:crater/controllers/update_controller.dart';
import 'package:crater/view/update_price/update_screen_row.dart';
import 'package:crater/widgets/custom_app_bar.dart';
import 'package:crater/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../home_page/home_screen_row.dart';

class UpdatePriceScreen extends StatefulWidget {
  const UpdatePriceScreen({super.key});

  @override
  State<UpdatePriceScreen> createState() => _UpdatePriceScreenState();
}

class _UpdatePriceScreenState extends State<UpdatePriceScreen> {
  final UpdateController updateVM = Get.put(UpdateController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateVM.fetchPrices();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.primary,
        appBar: CustomAppBar(title: "اشیاء کی قیمتیں"),
        body: SafeArea(child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.0.w),
            child: Column(
              children: [
                SizedBox(height: 20.h,),
                Row(
                  children: [
                    SizedBox(width: 20.w,),
                    Column(
                      children: [
                        UrduTextWidget(text: "رقم", fontSize: 18.sp, fontWeight: FontWeight.w600),
                      ],
                    ),
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        UrduTextWidget(text: "اشیاء کا نام", fontSize: 18.sp, fontWeight: FontWeight.w600),
                      ],
                    )),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(), // Disable scrolling within GridView
                  itemCount: updateVM.items.length, // Length of the map
                  itemBuilder: (context, index) {
                    var controller = updateVM.getControllerForItem(updateVM.items[index]["name"].toString());

                    return Padding(
                      padding: EdgeInsets.only(top: index == 0 ? 0 : 8.0),
                      child: UpdateScreenRow(items: updateVM.items[index], controller: controller),
                    );

                  },
                ),

                SizedBox(height: 20.h,),
                Obx(
                      () => GestureDetector(
                    onTap: () {
                      updateVM.savePrices();
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10.h, right: 14.w, left: 14.w),
                      height: 60.h,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      alignment: Alignment.center,
                      child: updateVM.loading.value
                          ? CircularProgressIndicator(color: AppColors.primary,)
                          : UrduTextWidget(
                        text: "کیمتیں تبدیل کریں",  // Updated text
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
