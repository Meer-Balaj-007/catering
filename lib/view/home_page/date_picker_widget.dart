import 'package:crater/consts/colors.dart';
import 'package:crater/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../widgets/text_widget.dart';

class DatePickerWidget extends StatefulWidget {
  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  final HomeController homeVM = Get.put(HomeController());

  List<String> monthsInUrdu = [
    "جنوری", "فروری", "مارچ", "اپریل", "مئی", "جون",
    "جولائی", "اگست", "ستمبر", "اکتوبر", "نومبر", "دسمبر"
  ];

  int selectedDay = DateTime.now().day;
  String selectedMonth = "جنوری";
  int selectedYear = DateTime.now().year;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeVM.day.value = selectedDay.toString();
    homeVM.month.value = selectedMonth;
    homeVM.year.value = selectedYear.toString();
  }

  void showWheelDialog(List<dynamic> items, Function(dynamic) onSelected) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          child: Container(
            padding: EdgeInsets.all(16.w),
            height: 200.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ListWheelScrollView.useDelegate(
                    itemExtent: 40.h,
                    physics: FixedExtentScrollPhysics(),
                    onSelectedItemChanged: (index) {
                      onSelected(items[index]);
                    },
                    childDelegate: ListWheelChildBuilderDelegate(
                      builder: (context, index) {
                        return Center(
                          child: Text(
                            items[index].toString(),
                            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
                          ),
                        );
                      },
                      childCount: items.length,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("منتخب کریں", style: TextStyle(fontSize: 16.sp)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Day Picker
            GestureDetector(
              onTap: () {
                showWheelDialog(List.generate(31, (index) => index + 1), (value) {
                  setState(() {
                    selectedDay = value;
                  });
                  homeVM.day.value = value.toString();

                });
              },
              child: _buildDateContainer(selectedDay.toString()),
            ),

            // Month Picker
            GestureDetector(
              onTap: () {
                showWheelDialog(monthsInUrdu, (value) {
                  setState(() {
                    selectedMonth = value;
                  });
                  homeVM.month.value = value;

                });
              },
              child: _buildDateContainer(selectedMonth),
            ),

            // Year Picker
            GestureDetector(
              onTap: () {
                showWheelDialog(  List.generate(2030 - DateTime.now().year + 1, (index) => DateTime.now().year + index), (value) {
                  setState(() {
                    selectedYear = value;
                  });
                  homeVM.year.value = value.toString();
                });
              },
              child: _buildDateContainer(selectedYear.toString()),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDateContainer(String text) {
    return Container(
      height: 40.h,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500)),
          SizedBox(width: 15.w),
          Icon(Icons.arrow_drop_down),
        ],
      ),
    );
  }
}
