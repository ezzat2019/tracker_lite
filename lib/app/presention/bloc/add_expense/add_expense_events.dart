import 'package:equatable/equatable.dart';

abstract class AddExpenseEvents extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchCurrencyEvent extends AddExpenseEvents {
  FetchCurrencyEvent();
  @override
  List<Object?> get props => [];
}
