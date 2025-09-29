import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracker_lite/app/presention/bloc/dashboard/dashboard_bloc.dart';
import 'header_home_widget.dart';
import 'recent_title_widget.dart';
import 'expense_list_widget.dart';

class HomeBodyWidget extends StatelessWidget {
  final DashboardBloc bloc;
  const HomeBodyWidget({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HeaderHomeWidget(),
        70.verticalSpace,
        const RecentTitleWidget(),
        12.verticalSpace,
        ExpenseListWidget(pagingController: bloc.pagingController)
      ],
    );
  }
}
