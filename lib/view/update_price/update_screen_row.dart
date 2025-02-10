import 'package:crater/consts/colors.dart';
import 'package:crater/controllers/update_controller.dart';
import 'package:crater/widgets/number_inputfield.dart';
import 'package:crater/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateScreenRow extends StatefulWidget {
  const UpdateScreenRow({super.key, required this.items, required this.controller});

  final Map items;
  final TextEditingController controller;

  @override
  State<UpdateScreenRow> createState() => _UpdateScreenRowState();
}

class _UpdateScreenRowState extends State<UpdateScreenRow> {
  final UpdateController updateVM = Get.find<UpdateController>();

  void showEditDialog(BuildContext context, Map item) {
    TextEditingController nameController = TextEditingController(text: item["name"]);
    String itemId = item["_id"].toString(); // Get _id

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          content: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.w),
              color: Colors.black.withOpacity(.8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 20.h,),
                UrduTextWidget(text: "نام میں ترمیم کریں", fontSize: 18.sp, fontWeight: FontWeight.w600, color: Colors.white,),
                SizedBox(height: 20.h,),
                SizedBox(
                  height: 40.h,
                  child: TextField(
                    controller: nameController,
                    style: GoogleFonts.notoNastaliqUrdu(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.white
                        )
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(
                              width: 1,
                              color: Colors.white
                          )
                      ),
                      hintText: "",


                    ),
                  ),
                ),
                SizedBox(height: 20.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Get.back();
                      },
                      child: Container(
                        height: 40.h,
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        decoration: BoxDecoration(
                          color: Colors.red.shade600,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        alignment: Alignment.center,
                        child: UrduTextWidget(text: "منسوخ کریں", fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.white,),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        updateVM.updateItemName(itemId, nameController.text);
                        Get.back();
                        },
                      child: Container(
                        height: 40.h,
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        alignment: Alignment.center,
                        child: UrduTextWidget(text: "محفوظ کریں", fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.white,),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h,),
              ],
            ),
          ),
        );
      },
    );
  }

  void showBottomSheetOptions(BuildContext context, Map item) {
    String itemId = item["_id"].toString(); // Extract _id

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(16.0.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Edit Option
              ListTile(
                leading: Icon(Icons.edit, color: Colors.blue),
                title: UrduTextWidget(text: "ترمیم کریں", fontSize: 16.sp, fontWeight: FontWeight.w600),
                onTap: () {
                  Navigator.pop(context);
                  showEditDialog(context, item);
                },
              ),

              Divider(),

              // Remove Option
              ListTile(
                leading: Icon(Icons.delete, color: Colors.red),
                title: UrduTextWidget(text: "ہٹائیں", fontSize: 16.sp, fontWeight: FontWeight.w600),
                onTap: () {
                  Navigator.pop(context);
                  updateVM.removeItem(itemId); // Remove using _id
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 70.w,
          child: NumberInputField(controller: widget.controller, hintText: ""),
        ),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onDoubleTap: () {
                  showBottomSheetOptions(context, widget.items);
                },
                child: UrduTextWidget(
                  text: widget.items["name"] ?? "",  // Name of the item
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
