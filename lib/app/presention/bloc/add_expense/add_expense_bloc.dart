import 'package:file_selector/file_selector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracker_lite/app/core/utils/get_it_manager.dart';

import '../../../data/models/add_expense/add_expense_item.dart';
import '../../../data/models/exchange_currency/exchange_rate_response.dart';
import '../../../domain/use_case/cache/cache_use_case.dart';
import '../../../domain/use_case/exchange_currency/exchange_currency_use_case.dart';
import 'add_expense_events.dart';
import 'add_expense_states.dart';

class AddExpenseBloc extends Bloc<AddExpenseEvents, AddExpenseStates> {
  final ExchangeCurrencyUseCase exchangeCurrencyUseCase =
      GetItManager.getIt.get<ExchangeCurrencyUseCase>();
  final CacheUseCase cacheUseCase = GetItManager.getIt.get<CacheUseCase>();
  String selectedCategory = 'Entertainment';
  DateTime? picked;
  XFile? file;
  List<CurrencyRate> currencies = [];
  CurrencyRate? selectedCurrency;
  AddExpenseBloc() : super(AddExpenseInitialState()) {
    on<FetchCurrencyEvent>((event, emit) async {
      var res = await exchangeCurrencyUseCase.getExchangeRate();
      emit(FetchExchangeCurrencyState(res));
    });
    on<SelectCategoryEvent>((event, emit) async {
      emit(SelectCategoryState(event.selectedCategory));
    });
    on<SelectCurrencyEvent>((event, emit) async {
      emit(SelectCurrencyState(event.selectedCurrency));
    });
  }

  String calculateCurrency(String amount, num rate) {
    return (num.parse(amount) / selectedCurrency!.rate).toString();
  }

  Future addItem(AddExcpenseItem newItem) async {
    await cacheUseCase.addExpenseItem(newItem);
  }
}
