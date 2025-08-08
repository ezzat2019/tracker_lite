import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:tracker_lite/app/data/models/exchange_currency/exchange_rate_response.dart';
import 'package:tracker_lite/app/data/source/local/shared_pref_manager.dart';
import 'package:tracker_lite/app/domain/use_case/cache/cache_use_case.dart';
import 'package:tracker_lite/app/domain/use_case/exchange_currency/exchange_currency_use_case.dart';
import 'package:tracker_lite/app/presention/bloc/add_expense/add_expense_bloc.dart';

void main() {
  final getIt = GetIt.instance;
  group('AddExpenseBloc tests', () {
    late AddExpenseBloc bloc;
    setUp(() {
      getIt.reset();
      getIt.registerSingleton<ExchangeCurrencyUseCase>(
          ExchangeCurrencyUseCase());
      getIt.registerSingleton<CacheUseCase>(CacheUseCase(SharedPrefManager()));
      bloc = AddExpenseBloc();
    });

    test('calculateCurrency', () {
      bloc.selectedCurrency = CurrencyRate(code: 'AED', rate: 3.6725);
      String amount = '100';
      String result =
          bloc.calculateCurrency(amount, bloc.selectedCurrency!.rate);
      String expected = (100 / 3.6725).toString();
      expect(result, expected);
    });
  });
}
