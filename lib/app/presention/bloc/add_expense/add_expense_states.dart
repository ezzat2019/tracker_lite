import 'package:equatable/equatable.dart';

import '../../../data/models/exchange_currency/exchange_rate_response.dart';

abstract class AddExpenseStates extends Equatable {}

class AddExpenseInitialState extends AddExpenseStates {
  @override
  List<Object?> get props => [];
}

class FetchExchangeCurrencyState extends AddExpenseStates {
  final ExchangeRateResponse? exchangeRateResponse;
  FetchExchangeCurrencyState(this.exchangeRateResponse);
  @override
  List<Object?> get props => [exchangeRateResponse];
}

class SelectCategoryState extends AddExpenseStates {
  final String selectedCategory;
  SelectCategoryState(this.selectedCategory);
  @override
  List<Object?> get props => [selectedCategory];
}

class SelectCurrencyState extends AddExpenseStates {
  final CurrencyRate? selectedCurrency;
  SelectCurrencyState(this.selectedCurrency);
  @override
  List<Object?> get props => [selectedCurrency];
}
