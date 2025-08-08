import 'package:dio/dio.dart';
import 'package:tracker_lite/app/core/utils/network_manager.dart';
import 'package:tracker_lite/app/data/source/network/dio_manager.dart';
import 'package:tracker_lite/app/domain/repo/exchange_currency/exchange_currency_service.dart';

class ExchangeCurrencyRepo implements ExchangeCurrencyService {
  late DioManager _dio;

  ExchangeCurrencyRepo(this._dio);

  @override
  Future<Response> getExchangeRate() async {
    var res = await _dio.dio.get(NetworkManager.GET_CURRENCY);
    return res;
  }
}
