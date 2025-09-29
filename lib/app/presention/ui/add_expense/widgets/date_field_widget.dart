import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracker_lite/app/core/utils/color_manager.dart';

class DateFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final DateTime? initialDate;
  final Function(DateTime) onDatePicked;

  const DateFieldWidget({
    super.key,
    required this.controller,
    required this.label,
    this.initialDate,
    required this.onDatePicked,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
        ),
        8.verticalSpace,
        TextField(
          controller: controller,
          keyboardType: TextInputType.datetime,
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: initialDate ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
            if (pickedDate != null) {
              onDatePicked(pickedDate);
            }
          },
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
              color: Colors.grey.withOpacity(.7)),
          readOnly: true,
          decoration: InputDecoration(
            hintStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
                color: Colors.grey.withOpacity(.7)),
            fillColor: ColorManager.GRAY,
            filled: true,
            suffixIcon: const Icon(Icons.calendar_today),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 0),
          ),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}
