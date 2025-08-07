import 'package:get_it/get_it.dart';
import 'package:tracker_lite/app/domain/repo/exchange_currency/exchange_currency_service.dart';

import '../../data/repo/exchange_currency/exchange_currency_repo.dart';
import '../../data/source/network/dio_manager.dart';

abstract class GetItManager {
  static final GetIt getIt = GetIt.instance;

  static void setup() {
    getIt.registerLazySingleton<DioManager>(() => DioManager());
    getIt.registerLazySingleton<ExchangeCurrencyService>(
        () => ExchangeCurrencyRepo(getIt.get()));
  }
}
