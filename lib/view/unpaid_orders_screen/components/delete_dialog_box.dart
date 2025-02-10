import 'package:crater/consts/colors.dart';
import 'package:crater/controllers/home_controller.dart';
import 'package:crater/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DeleteDialogBox extends StatefulWidget {
  const DeleteDialogBox({super.key, required this.order});

  final Map order;

  @override
  State<DeleteDialogBox> createState() => _DeleteDialogBoxState();
}

class _DeleteDialogBoxState extends State<DeleteDialogBox> {

  final HomeController homeVM = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.h,
      width: 400.w,
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: AppColors.secondary.withOpacity(.8),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 20.h,),
          UrduTextWidget(text: "کیا آپ یہ آرڈر ختم کرنا چاہتے ہیں؟", fontSize: 17.sp, fontWeight: FontWeight.w700, color: AppColors.primary,),
          SizedBox(height: 30.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                 await homeVM.deleteMap(widget.order["order_id"]).then((val){
                   Get.back();
                 });
                },
                child: Container(
                  height: 40.h,
                  padding: EdgeInsets.symmetric(horizontal:  20.w, ),
                  decoration: BoxDecoration(
                    color: Colors.red.shade600,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: UrduTextWidget(
                    text: "ہاں",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Get.back();
                },
                child: Container(
                  height: 40.h,
                  padding: EdgeInsets.symmetric(horizontal:  20.w, ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: UrduTextWidget(
                    text: "نہیں",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
