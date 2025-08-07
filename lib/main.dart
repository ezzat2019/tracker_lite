import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracker_lite/app/presention/bloc/dashboard/dashboard_bloc.dart';
import 'package:tracker_lite/app/presention/ui/dash_board_screen.dart';

import 'app/core/utils/get_it_manager.dart';
import 'app/core/utils/theme_manger.dart';

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
          providers: [
            BlocProvider<DashboardBloc>(
              create: (context) => DashboardBloc(),
            )
          ],
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
}
