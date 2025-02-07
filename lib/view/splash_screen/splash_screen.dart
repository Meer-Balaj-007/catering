import 'package:crater/consts/colors.dart';
import 'package:crater/view/home_page/home_screen.dart';
import 'package:crater/widgets/bottom_nav_bar.dart';
import 'package:crater/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToHome(); // Call function in initState
  }

  void navigateToHome() {
    Future.delayed(const Duration(seconds: 3), () {
      Get.off(BottomNavBar());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/spoons.png",
            height: 200.h,
            width: 200.w,
            color: AppColors.secondary,
          ),
          SizedBox(height: 10.h),
          UrduTextWidget(
            text: "آپ کا کریٹر",
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
