import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nested/nested.dart';
import 'package:tracker_lite/app/presention/bloc/dashboard/dashboard_bloc.dart';

import 'app/core/utils/get_it_manager.dart';
import 'app/core/utils/theme_manger.dart';
import 'app/presention/bloc/add_expense/add_expense_bloc.dart';
import 'app/presention/ui/dashboard/dash_board_screen.dart';

void main() async {
  await init();

  runApp(const MyApp());
}

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  GetItManager.setup();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MultiBlocProvider(
          providers: providers(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Expense Tracker Lite",
            theme: ThemeManager.lightTheme,
            home: child,
          ),
        );
      },
      child: DashBoardScreen(),
    );
  }

  List<SingleChildWidget> providers() {
    return [
      BlocProvider<DashboardBloc>(
        create: (context) => DashboardBloc(),
      ),
      BlocProvider<AddExpenseBloc>(
        create: (context) => AddExpenseBloc(),
      ),
    ];
  }
}
