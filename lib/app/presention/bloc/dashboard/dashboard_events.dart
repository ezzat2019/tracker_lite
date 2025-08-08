import 'package:equatable/equatable.dart';

abstract class DashboardEvents extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChangeHomeFilterEvent extends DashboardEvents {
  final String filter;
  ChangeHomeFilterEvent(this.filter);
  @override
  List<Object?> get props => [filter];
}

class UpdateTotalEvent extends DashboardEvents {
  UpdateTotalEvent();
  @override
  List<Object?> get props => [];
}

class GetLisEvent extends DashboardEvents {
  int page;
  GetLisEvent(this.page);
  @override
  List<Object?> get props => [page];
}
