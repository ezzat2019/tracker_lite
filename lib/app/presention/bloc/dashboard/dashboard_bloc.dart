import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracker_lite/app/presention/bloc/dashboard/dashboard_states.dart';

import 'dashboard_events.dart';

class DashboardBloc extends Bloc<DashboardEvents,DashboardStates>
{
  String currentFilter = "This Month";

  DashboardBloc() : super(DashboardInitialState()) {
    on<ChangeHomeFilterEvent>((event, emit) {
      currentFilter = event.filter;
      emit(DashboardFilterState(currentFilter));
    });
  }

}