import 'package:get_it/get_it.dart';
import 'package:tracker_lite/app/domain/repo/exchange_currency/exchange_currency_service.dart';
import 'package:tracker_lite/app/domain/use_case/exchange_currency/exchange_currency_use_case.dart';

import '../../data/repo/exchange_currency/exchange_currency_repo.dart';
import '../../data/source/local/shared_pref_manager.dart';
import '../../data/source/network/dio_manager.dart';
import '../../domain/use_case/cache/cache_use_case.dart';

abstract class GetItManager {
  static final GetIt getIt = GetIt.instance;

  static void setup() {
    getIt.registerLazySingleton<DioManager>(() => DioManager());
    getIt.registerLazySingleton<SharedPrefManager>(() => SharedPrefManager());
    getIt.registerLazySingleton<ExchangeCurrencyService>(
        () => ExchangeCurrencyRepo(getIt.get()));
    getIt.registerLazySingleton<ExchangeCurrencyUseCase>(
        () => ExchangeCurrencyUseCase());
    getIt.registerLazySingleton<CacheUseCase>(() => CacheUseCase(getIt.get()));
  }
}
