import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracker_lite/app/core/utils/color_manager.dart';
import 'package:tracker_lite/app/core/utils/constant_manager.dart';

class CategoryDropdownWidget extends StatelessWidget {
  final String selectedCategory;
  final Function(String?) onCategoryChanged;

  const CategoryDropdownWidget({
    super.key,
    required this.selectedCategory,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Categories",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
        ),
        8.verticalSpace,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: ColorManager.GRAY),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedCategory,
              isExpanded: true,
              onChanged: onCategoryChanged,
              icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
              items: ConstantManager.categories.map((cat) {
                return DropdownMenuItem(
                  value: cat,
                  child: Text(
                    cat,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                        color: Colors.grey.withOpacity(.7)),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}
