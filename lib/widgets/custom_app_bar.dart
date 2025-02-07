import 'package:crater/consts/colors.dart';
import 'package:crater/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool? backButton;

  const CustomAppBar({super.key, required this.title, this.backButton = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: preferredSize.height + 120.h, // Extending height for curve effect
          decoration:  BoxDecoration(
            color: AppColors.secondary, // AppBar background color
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.r), // Adjust the radius as needed
              bottomRight: Radius.circular(20.r),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
          ),
        ),
        AppBar(
          leading: backButton == true
              ? GestureDetector(
              onTap: (){
                Get.back();
              },
              child: Icon(Icons.arrow_back_ios, size: 24.w, color: AppColors.primary,))
              : null,
          title: UrduTextWidget(text: title, fontSize: 18.sp, fontWeight: FontWeight.w600, color: AppColors.primary,),
          backgroundColor: Colors.transparent, // Making AppBar transparent
          elevation: 0, // Removing AppBar shadow
          centerTitle: true,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
