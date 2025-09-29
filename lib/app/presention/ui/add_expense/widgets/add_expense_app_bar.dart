import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddExpenseAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AddExpenseAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        "Add Expense",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.black),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
