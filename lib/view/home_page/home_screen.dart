import 'package:crater/consts/colors.dart';
import 'package:crater/controllers/home_controller.dart';
import 'package:crater/view/home_page/date_picker_widget.dart';
import 'package:crater/view/home_page/home_screen_row.dart';
import 'package:crater/widgets/custom_app_bar.dart';
import 'package:crater/widgets/custom_inputfield.dart';
import 'package:crater/widgets/number_inputfield.dart';
import 'package:crater/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeVM = Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeVM.fetchPrices();
    homeVM.loadDataFromSharedPreferences();
    debugPrint("data: ${homeVM.items}");
  }

  void _pickDate(BuildContext context, TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      String formattedDate = "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
      homeVM.dateController.value.text = formattedDate;
      homeVM.day.value = "${pickedDate.day}";
      homeVM.month.value = "${pickedDate.month}";
      homeVM.year.value = "${pickedDate.year}";
    }
  }

  @override
  void dispose (){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.primary,
        appBar: AppBar(
          toolbarHeight: 115.h,
          leadingWidth: 0.w,
          centerTitle: true,
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
                    SizedBox(height: 10.h,),
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
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.0.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Align(
                                alignment: Alignment.centerRight,
                                child: UrduTextWidget(
                                  text: "گاہک کا نمبر",
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.secondary,
                                )),
                            SizedBox(height: 15.h),
                            Container(
                              height: 40.h,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(14.r)
                              ),
                              child: TextField(
                                controller: homeVM.numberController.value,
                                style: GoogleFonts.notoNastaliqUrdu( fontSize: 18.sp, color: Colors.black),
                                keyboardType: TextInputType.number, // Opens number keyboard
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly, // Allows only numbers
                                ],
                                decoration: InputDecoration(
                                  hintText: "",
                                  hintStyle: GoogleFonts.notoNastaliqUrdu(color: Colors.black, fontSize: 14.sp),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14.r),
                                    borderSide: BorderSide(
                                        width: 1.w,
                                        color: Colors.black
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14.r),
                                    borderSide: BorderSide(
                                        width: 1.w,
                                        color: Colors.black
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14.r),
                                    borderSide: BorderSide(
                                        width: 1.w,
                                        color: Colors.black
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 15.w,),
                      Expanded(
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: UrduTextWidget(
                                text: "تاریخ",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 15.h),
                            GestureDetector(
                              onTap: () => _pickDate(context, homeVM.dateController.value),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: AbsorbPointer(
                                  absorbing: true, // Prevents manual typing
                                  child: SizedBox(
                                    width: 170.w,
                                    height: 40.h,
                                    child: UrduInputField(
                                      controller: homeVM.dateController.value,
                                      hintText: "",
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),


                  SizedBox(height: 15.h),
                  Align(
                      alignment: Alignment.centerRight,
                      child: UrduTextWidget(
                        text: "گاہک کا نام",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      )),
                  SizedBox(height: 15.h),
                  Container(
                    height: 40.h,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(14.r)
                    ),
                    child: TextField(
                      controller: homeVM.nameController.value,
                      keyboardType: TextInputType.text,
                      textDirection: TextDirection.rtl, // Right-to-left for Urdu
                      style: GoogleFonts.notoNastaliqUrdu( fontSize: 18.sp, color: Colors.black),
                      decoration: InputDecoration(
                        hintText: "",
                        hintStyle: GoogleFonts.notoNastaliqUrdu(color: Colors.black, fontSize: 14.sp),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.r),
                          borderSide: BorderSide(
                              width: 1.w,
                              color: Colors.black
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.r),
                          borderSide: BorderSide(
                              width: 1.w,
                              color: Colors.black
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.r),
                          borderSide: BorderSide(
                              width: 1.w,
                              color: Colors.black
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
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
                  SizedBox(
                    height: 20.h,
                  ),
                  Obx(
                    ()=> ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(), // Disable scrolling within GridView
                        itemCount: homeVM.fetched.isNotEmpty ? homeVM.fetched.length : homeVM.items.length, // Length of the map
                        itemBuilder: (context, index) {
                          var controller = homeVM.getControllerForItem( homeVM.fetched.isNotEmpty ? homeVM.fetched[index]["name"].toString() : homeVM.items[index]["name"].toString());

                          return Padding(
                            padding: EdgeInsets.only(top: index == 0 ? 0 : 8.0),
                            child: HomeScreenRow(homeVM.fetched.isNotEmpty ? homeVM.fetched[index] :homeVM.items[index], controller: controller),
                          );

                        },
                      ),
                  ),
                  SizedBox(height: 10.h,),
                  Obx(
                      ()=> GestureDetector(
                        onTap: (){
                          homeVM.saveOrder();
                        },
                        child: Container(
                        margin: EdgeInsets.only(bottom: 10.h),
                        padding: EdgeInsets.symmetric( vertical: 16.h),
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        alignment: Alignment.center,
                        child: homeVM.loading.value
                            ? Center(child:
                        CircularProgressIndicator(color: AppColors.primary,),)
                            : UrduTextWidget(
                          text: "آرڈر محفوظ کریں",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary,
                        ),
                         ),
                      ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
