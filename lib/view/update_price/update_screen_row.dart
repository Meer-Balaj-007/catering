import 'package:crater/consts/colors.dart';
import 'package:crater/widgets/number_inputfield.dart';
import 'package:crater/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateScreenRow extends StatefulWidget {
  const UpdateScreenRow({super.key, required this.items, required this.controller});

  final Map items;
  final TextEditingController controller;

  @override
  State<UpdateScreenRow> createState() => _UpdateScreenRowState();
}

class _UpdateScreenRowState extends State<UpdateScreenRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 70.w,
          child: NumberInputField(controller: widget.controller, hintText: "",),
        ),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              UrduTextWidget(text: widget.items["name"] ?? "", fontSize: 15.sp, fontWeight: FontWeight.w600),
            ],
          ),
        ),
      ],
    );
  }
}
