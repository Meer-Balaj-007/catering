import 'package:crater/consts/colors.dart';
import 'package:crater/widgets/number_inputfield.dart';
import 'package:crater/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreenRow extends StatefulWidget {
  const HomeScreenRow(this.items, {super.key, required this.controller});

  final Map items;
  final TextEditingController controller;

  @override
  State<HomeScreenRow> createState() => _HomeScreenRowState();
}

class _HomeScreenRowState extends State<HomeScreenRow> {
  double total = 0;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateTotal);
    _updateTotal(); // Initial calculation
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateTotal);
    super.dispose();
  }

  void _updateTotal() {
    setState(() {
      double quantity = double.tryParse(widget.controller.text) ?? 0;
      double price = (widget.items["price"] ?? 0).toDouble();
      total = price * quantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            children: [
              Text(
                total.toStringAsFixed(0),
                style: GoogleFonts.inter(
                    fontSize: 15.sp, fontWeight: FontWeight.w600, color: AppColors.secondary
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                widget.items["price"].toString(),
                style: GoogleFonts.inter(
                    fontSize: 15.sp, fontWeight: FontWeight.w600, color: AppColors.secondary
                ),
              ),
            ],
          ),
        ),

        Expanded(
          child: Column(
            children: [
              UrduTextWidget(text: widget.items["name"] ?? "", fontSize: 15.sp, fontWeight: FontWeight.w600),
            ],
          ),
        ),
        Padding(
          padding:  EdgeInsets.only(left: 20.w),
          child: SizedBox(
            width: 70.w,
            child: NumberInputField(controller: widget.controller),
          ),
        ),
      ],
    );
  }
}
