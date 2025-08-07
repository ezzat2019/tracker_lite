import 'package:dio/dio.dart';

abstract  class ExchangeCurrencyService{

  Future<Response> getExchangeRate();

}