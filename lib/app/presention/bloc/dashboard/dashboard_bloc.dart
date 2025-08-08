import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tracker_lite/app/data/models/add_expense/add_expense_item.dart';
import 'package:tracker_lite/app/presention/bloc/dashboard/dashboard_states.dart';

import '../../../core/utils/get_it_manager.dart';
import '../../../domain/use_case/cache/cache_use_case.dart';
import 'dashboard_events.dart';

class DashboardBloc extends Bloc<DashboardEvents, DashboardStates> {
  final CacheUseCase cacheUseCase = GetItManager.getIt.get<CacheUseCase>();
  late final PagingController<int, AddExcpenseItem> pagingController;
  String currentFilter = "This Month";
  double total = 0.0;

  DashboardBloc() : super(DashboardInitialState()) {
    on<ChangeHomeFilterEvent>((event, emit) {
      currentFilter = event.filter;
      pagingController.refresh();
      emit(DashboardFilterState(currentFilter));
    });

    on<UpdateTotalEvent>((event, emit) async {
      total = await cacheUseCase.getTotalBalance();
      emit(DashboardTotalUpdatedState(total));
    });
  }

  init() {
    pagingController = PagingController<int, AddExcpenseItem>(
      getNextPageKey: (state) {
        if (state.keys == null || state.pages == null || state.pages!.isEmpty)
          return 1;
        final lastPageItems = state.pages!.last;
        if (lastPageItems.length < 10) return null;
        return state.keys!.last + 1;
      },
      fetchPage: (pageKey) async {
        total = await cacheUseCase.getTotalBalance();
        add(UpdateTotalEvent());
        var res = await cacheUseCase.getPaginatedItems(
          page: pageKey,
        );

        List<AddExcpenseItem> filteredItems = res.items.where((item) {
          final now = DateTime.now();
          if (currentFilter == 'This Month') {
            return item.date.year == now.year && item.date.month == now.month;
          } else if (currentFilter == 'Last 7 Days') {
            return item.date.isAfter(now.subtract(const Duration(days: 7)));
          }
          return true;
        }).toList();

        return filteredItems;
      },
    );
  }

  Future<num> calulateTotalList() async {
    return await cacheUseCase.getTotalBalance();
  }
}
