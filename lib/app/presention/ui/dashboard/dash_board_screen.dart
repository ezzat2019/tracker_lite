import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracker_lite/app/presention/bloc/dashboard/dashboard_bloc.dart';

import '../../bloc/dashboard/dashboard_states.dart';
import 'widgets/add_expense_fab.dart';
import 'widgets/home_card_widget.dart';
import 'widgets/home_body_widget.dart'; // Added import

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
              HomeBodyWidget(bloc: bloc), // Replaced buildHomeBody()
              HomeCardWidget(state: state),
            ],
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const AddExpenseFab(),
    );
  }

  // Removed buildHomeBody() method
}
