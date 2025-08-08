import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tracker_lite/app/core/utils/color_manager.dart';
import 'package:tracker_lite/app/core/utils/path_manger.dart';
import 'package:tracker_lite/app/data/models/add_expense/add_expense_item.dart';
import 'package:tracker_lite/app/presention/bloc/dashboard/dashboard_bloc.dart';
import 'package:tracker_lite/app/presention/bloc/dashboard/widget/expense_item.dart';
import 'package:tracker_lite/app/presention/ui/dash_board/widget/my_filter.dart';

import '../../bloc/dashboard/dashboard_states.dart';
import '../add_expense/add_expense_screen.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  late DashboardBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<DashboardBloc>();
    bloc.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DashboardBloc, DashboardStates>(
        builder: (BuildContext context, DashboardStates state) {
          return Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
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
                              Spacer(),
                              FilterDropdown()
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  70.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Resent Expenses",
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w700),
                        ),
                        Spacer(),
                        Text(
                          "see all",
                          style: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                  12.verticalSpace,
                  Expanded(
                    child: PagingListener<int, AddExcpenseItem>(
                      controller: bloc.pagingController,
                      builder: (context, state, fetchNextPage) =>
                          PagedListView<int, AddExcpenseItem>(
                        padding:
                            EdgeInsets.symmetric(horizontal: 32.w, vertical: 0),
                        state: state,
                        fetchNextPage: fetchNextPage,
                        builderDelegate: PagedChildBuilderDelegate(
                          newPageProgressIndicatorBuilder: (context) =>
                              Container(),
                          itemBuilder: (context, item, index) {
                            return ExpenseItem(item: item);
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Positioned(
                top: .19.sh,
                left: 0,
                right: 0,
                child: Container(
                  width: 1.sw,
                  margin: EdgeInsets.symmetric(horizontal: 18.w),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
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
                          Spacer(),
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
                                ? state.total.toStringAsFixed(2)
                                : "0.0",
                            style: TextStyle(
                                fontSize: 23.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Spacer(),
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
                                    "10,840.00",
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Spacer(),
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
                                    "1,884.00",
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
              ),
            ],
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddExpenseScreen(),
          ));
        },
        shape: const CircleBorder(),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
