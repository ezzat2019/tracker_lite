import 'package:equatable/equatable.dart';

abstract class DashboardStates extends Equatable {}

 class DashboardInitialState extends DashboardStates{
  @override
  
  List<Object?> get props => [];
}

class DashboardFilterState extends DashboardStates{
  final String filter;
  DashboardFilterState(this.filter);
  @override
  List<Object?> get props => [filter];
  
}