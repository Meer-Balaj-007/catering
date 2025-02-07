import 'dart:convert';
import 'package:crater/consts/colors.dart';
import 'package:crater/controllers/home_controller.dart';
import 'package:crater/view/paid_orders/paid_orders_screen.dart';
import 'package:crater/view/unpaid_orders_screen/components/unpaid_order_widet.dart';
import 'package:crater/view/unpaid_orders_screen/unpaid_order_details.dart';
import 'package:crater/widgets/custom_app_bar.dart';
import 'package:crater/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UnpaidOrderScreen extends StatefulWidget {
  const UnpaidOrderScreen({super.key});

  @override
  State<UnpaidOrderScreen> createState() => _UnpaidOrderScreenState();
}

class _UnpaidOrderScreenState extends State<UnpaidOrderScreen> {
  List<Map<String, dynamic>> ordersData = []; // List to hold unpaid orders

  @override
  void initState() {
    super.initState();
    ordersData.clear();
    _loadDataFromSharedPreferences();
  }

  Future<void> _loadDataFromSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? storedData = prefs.getStringList('orders');
    debugPrint("Orders stored: $storedData");

    if (storedData != null) {
      List<Map<String, dynamic>> loadedData =
      storedData.map((item) => jsonDecode(item) as Map<String, dynamic>).toList();

      debugPrint("Orders: $loadedData");

      setState(() {
        ordersData = loadedData;
      });
    } else {
      debugPrint("No orders data found.");
    }
  }

  @override
  void dispose () {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2, // Two tabs: Unpaid Orders & Paid Orders
      child: Scaffold(
        backgroundColor: AppColors.primary,
        appBar: CustomAppBar(title: "آرڈرز"),
        body: Column(
          children: [
            SizedBox(height: 20.h,),
            TabBar(
              labelColor: Colors.white,
              indicatorColor: AppColors.secondary,
              indicatorSize: TabBarIndicatorSize.tab,
              unselectedLabelStyle: GoogleFonts.notoNastaliqUrdu(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.secondary,
              ),
              labelStyle: GoogleFonts.notoNastaliqUrdu(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
              indicator: BoxDecoration(
                color: AppColors.secondary,

              ),
              tabs: [
                Tab(text: "بقایہ آرڈرز", ), // Unpaid Orders
                Tab(text: "ادائیگی شدہ آرڈرز"), // Paid Orders
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Unpaid Orders Tab
                  UnpaidOrdersView(),
                  PaidOrdersScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Unpaid Orders View as a separate widget
class UnpaidOrdersView extends StatefulWidget {

  UnpaidOrdersView({super.key, });

  @override
  State<UnpaidOrdersView> createState() => _UnpaidOrdersViewState();
}

class _UnpaidOrdersViewState extends State<UnpaidOrdersView> {
  final HomeController homeVM = Get.put(HomeController());

  // Map of Urdu month names to English month names
  final Map<String, String> urduToEnglishMonth = {
    "جنوری": "January",
    "فروری": "February",
    "مارچ": "March",
    "اپریل": "April",
    "مئی": "May",
    "جون": "June",
    "جولائی": "July",
    "اگست": "August",
    "ستمبر": "September",
    "اکتوبر": "October",
    "نومبر": "November",
    "دسمبر": "December",
  };

  // Convert order data into DateTime and sort
  List<Map<String, dynamic>> ordersData = []; // List to hold unpaid orders

  @override
  void initState() {
    super.initState();
    ordersData.clear();
    _loadDataFromSharedPreferences();
  }

  Future<void> _loadDataFromSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? storedData = prefs.getStringList('orders');
    debugPrint("Orders stored: $storedData");

    if (storedData != null) {
      List<Map<String, dynamic>> loadedData =
      storedData.map((item) => jsonDecode(item) as Map<String, dynamic>).toList();

      debugPrint("Orders: $loadedData");

      setState(() {
        ordersData = loadedData;
      });
    } else {
      debugPrint("No orders data found.");
    }
  }

  @override
  void dispose () {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Sort the orders before passing them to the ListView

    return ordersData.isNotEmpty
        ? SingleChildScrollView(
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
                          gradient: LinearGradient(
                            colors: [
                              AppColors.primary,
                              AppColors.secondary,
                              AppColors.primary
                            ],
                          ),
                        ),
                      ),
                    GestureDetector(
                      onTap: () {
                        Get.to(UnpaidOrderDetails(
                          order: ordersData[index],
                          paid: false,
                        ));
                      },
                      child: UnpaidOrderWigdet(data: ordersData[index]),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    )
        : Center(
      child: UrduTextWidget(
        text: "غیر ادا شدہ آرڈرز موجود نہیں",
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
