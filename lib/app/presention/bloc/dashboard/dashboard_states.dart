import 'package:equatable/equatable.dart';

import '../../../data/models/add_expense/page_model.dart';

abstract class DashboardStates extends Equatable {}

class DashboardInitialState extends DashboardStates {
  @override
  List<Object?> get props => [];
}

class DashboardFilterState extends DashboardStates {
  final String filter;
  DashboardFilterState(this.filter);
  @override
  List<Object?> get props => [filter];
}

class DashboardTotalUpdatedState extends DashboardStates {
  final num total;
  DashboardTotalUpdatedState(this.total);
  @override
  List<Object?> get props => [total];
}

class DashboardListItemState extends DashboardStates {
  final PaginatedExpenseItems res;
  DashboardListItemState(this.res);
  @override
  List<Object?> get props => [res];
}
