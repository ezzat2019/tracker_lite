import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListOfCategoryWidget extends StatelessWidget {
  final List<Widget>
      icons; // Expecting a list of widgets (likely CategoryWidget)

  const ListOfCategoryWidget({super.key, required this.icons});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Categories",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(height: 12.h),
        Wrap(
          spacing: 20.w,
          runSpacing: 16.h,
          children: icons,
        ),
        SizedBox(height: 50.h),
      ],
    );
  }
}
