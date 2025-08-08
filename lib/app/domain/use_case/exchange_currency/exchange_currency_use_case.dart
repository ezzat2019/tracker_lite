import 'package:tracker_lite/app/core/utils/get_it_manager.dart';

import '../../../data/models/exchange_currency/exchange_rate_response.dart';
import '../../repo/exchange_currency/exchange_currency_service.dart';

class ExchangeCurrencyUseCase {
  final ExchangeCurrencyService exchangeCurrencyRepo =
      GetItManager.getIt.get<ExchangeCurrencyService>();

  Future<ExchangeRateResponse?> getExchangeRate() async {
    var res = await exchangeCurrencyRepo.getExchangeRate();
    if (res.statusCode == 200) {
      return ExchangeRateResponse.fromJson(res.data);
    } else
      return null;
  }
}
