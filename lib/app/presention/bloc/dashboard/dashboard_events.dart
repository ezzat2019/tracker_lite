import 'package:equatable/equatable.dart';

abstract class DashboardEvents extends Equatable {
  @override
  List<Object?> get props => [];
}

 class ChangeHomeFilterEvent extends DashboardEvents{
  final String filter;
   ChangeHomeFilterEvent(this.filter);
  @override
  
  List<Object?> get props => [filter];


}

