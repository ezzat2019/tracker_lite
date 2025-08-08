import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:tracker_lite/app/core/utils/network_manager.dart';

class DioManager {
  late Dio dio;

  DioManager() {
    init();
  }

  Dio init() {
    dio = Dio();

    dio.options = BaseOptions(
      baseUrl: NetworkManager.BASE_URL_REAL,
      headers: {
        "Accept": "application/json",
      },
      followRedirects: false,
    );
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        logPrint: (object) {
          log(object.toString());
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: _onRequestInterceptor,
        onResponse: _onResponseInterceptor,
        onError: _onErrorInterceptor,
      ),
    );

    return dio;
  }

  Future<void> _onRequestInterceptor(
      RequestOptions options, RequestInterceptorHandler handler) async {
    handler.next(options);
  }

  void _onResponseInterceptor(
      Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  void _onErrorInterceptor(
      DioException error, ErrorInterceptorHandler handler) {
    handler.next(error);
  }
}
