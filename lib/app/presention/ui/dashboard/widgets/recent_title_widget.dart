import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecentTitleWidget extends StatelessWidget {
  const RecentTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Resent Expenses",
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
          ),
          const Spacer(),
          Text(
            "see all",
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
