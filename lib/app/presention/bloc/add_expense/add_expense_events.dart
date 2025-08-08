import 'package:equatable/equatable.dart';

import '../../../data/models/exchange_currency/exchange_rate_response.dart';

abstract class AddExpenseEvents extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchCurrencyEvent extends AddExpenseEvents {
  FetchCurrencyEvent();
  @override
  List<Object?> get props => [];
}

class SelectCategoryEvent extends AddExpenseEvents {
  final String selectedCategory;
  SelectCategoryEvent(this.selectedCategory);
  @override
  List<Object?> get props => [selectedCategory];
}

class SelectCurrencyEvent extends AddExpenseEvents {
  final CurrencyRate? selectedCurrency;
  SelectCurrencyEvent(this.selectedCurrency);
  @override
  List<Object?> get props => [selectedCurrency];
}
