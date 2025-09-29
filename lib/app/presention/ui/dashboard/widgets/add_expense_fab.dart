import 'package:flutter/material.dart';
import 'package:tracker_lite/app/presention/ui/add_expense/add_expense_screen.dart';

class AddExpenseFab extends StatelessWidget {
  const AddExpenseFab({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const AddExpenseScreen(),
        ));
      },
      shape: const CircleBorder(),
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}
