import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tracker_lite/app/data/models/add_expense/add_expense_item.dart';
import '../../../bloc/dashboard/widget/expense_item.dart'; // Relative import for ExpenseItem

class ExpenseListWidget extends StatelessWidget {
  final PagingController<int, AddExcpenseItem> pagingController;

  const ExpenseListWidget({super.key, required this.pagingController});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PagingListener<int, AddExcpenseItem>(
        controller: pagingController,
        builder: (context, state, fetchNextPage) =>
            PagedListView<int, AddExcpenseItem>(
          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 0),
          state: state,
          fetchNextPage: fetchNextPage,
          builderDelegate: PagedChildBuilderDelegate(
            newPageProgressIndicatorBuilder: (context) => Container(),
            itemBuilder: (context, item, index) {
              return ExpenseItem(item: item);
            },
          ),
        ),
      ),
    );
  }
}
