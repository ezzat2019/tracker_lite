import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracker_lite/app/core/utils/color_manager.dart';
import 'package:tracker_lite/app/presention/bloc/dashboard/dashboard_states.dart';

class HomeCardWidget extends StatelessWidget {
  final DashboardStates state;

  const HomeCardWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: .19.sh,
      left: 0,
      right: 0,
      child: Container(
        width: 1.sw,
        margin: EdgeInsets.symmetric(horizontal: 18.w),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
        height: 180.h,
        decoration: BoxDecoration(
            color: ColorManager.CARD,
            borderRadius: BorderRadius.circular(20.r)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Total Balance",
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
                1.horizontalSpace,
                Icon(
                  Icons.keyboard_arrow_up,
                  color: Colors.white,
                  size: 18.r,
                ),
                const Spacer(),
                Icon(
                  Icons.more_horiz,
                  color: Colors.white,
                  size: 30.r,
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.attach_money_outlined,
                  color: Colors.white,
                  size: 28.r,
                ),
                Text(
                  state is DashboardTotalUpdatedState
                      ? (state as DashboardTotalUpdatedState)
                          .total
                          .toStringAsFixed(2)
                      : "0.0",
                  style: TextStyle(
                      fontSize: 23.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(4.0.r),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(.3),
                              shape: BoxShape.circle),
                          child: Icon(
                            Icons.arrow_downward_outlined,
                            color: Colors.white,
                            size: 12.r,
                          ),
                        ),
                        6.horizontalSpace,
                        Text(
                          "Income",
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.attach_money_outlined,
                          color: Colors.white,
                          size: 20.r,
                        ),
                        Text(
                          "10,840.00", // Hardcoded value from original screen
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(4.0.r),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(.3),
                              shape: BoxShape.circle),
                          child: Icon(
                            Icons.arrow_upward_outlined,
                            color: Colors.white,
                            size: 12.r,
                          ),
                        ),
                        6.horizontalSpace,
                        Text(
                          "Expenses",
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.attach_money_outlined,
                          color: Colors.white,
                          size: 20.r,
                        ),
                        Text(
                          "1,884.00", // Hardcoded value from original screen
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
