import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracker_lite/app/core/utils/color_manager.dart';
import 'package:tracker_lite/app/core/utils/path_manger.dart';
import '../../add_expense/widgets/my_filter.dart'; // Adjusted import for FilterDropdown

class HeaderHomeWidget extends StatelessWidget {
  const HeaderHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: .35.sh,
      decoration: BoxDecoration(
          color: ColorManager.PRIMARY,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(
                12.r,
              ),
              bottomRight: Radius.circular(12.r))),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            60.verticalSpace,
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100.r),
                  child: Image.asset(
                    PathManager.IMAGE_PATH + "Circle+Profile.jpg",
                    width: 50.r,
                    height: 50.r,
                  ),
                ),
                8.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Good Morning",
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                    2.verticalSpace,
                    Text(
                      "Mona Mohamed",
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const Spacer(),
                FilterDropdown() // Assuming FilterDropdown is a defined widget
              ],
            )
          ],
        ),
      ),
    );
  }
}
