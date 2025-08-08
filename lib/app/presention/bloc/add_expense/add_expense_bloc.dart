import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracker_lite/app/core/utils/get_it_manager.dart';

import '../../../data/models/add_expense/add_expense_item.dart';
import '../../../domain/use_case/cache/cache_use_case.dart';
import '../../../domain/use_case/exchange_currency/exchange_currency_use_case.dart';
import 'add_expense_events.dart';
import 'add_expense_states.dart';

class AddExpenseBloc extends Bloc<AddExpenseEvents, AddExpenseStates> {
  final ExchangeCurrencyUseCase exchangeCurrencyUseCase =
      GetItManager.getIt.get<ExchangeCurrencyUseCase>();
  final CacheUseCase cacheUseCase = GetItManager.getIt.get<CacheUseCase>();

  AddExpenseBloc() : super(AddExpenseInitialState()) {
    on<FetchCurrencyEvent>((event, emit) async {
      var res = await exchangeCurrencyUseCase.getExchangeRate();
      emit(FetchExchangeCurrencyState(res));
    });
  }

  Future addItem(AddExcpenseItem newItem) async {
    await cacheUseCase.addExpenseItem(newItem);
  }
}
