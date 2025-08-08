class ExchangeRateResponse {
  final String result;
  final String documentation;
  final String termsOfUse;
  final int timeLastUpdateUnix;
  final String timeLastUpdateUtc;
  final int timeNextUpdateUnix;
  final String timeNextUpdateUtc;
  final String baseCode;
  final List<CurrencyRate> conversionRates; // بدل Map

  ExchangeRateResponse({
    required this.result,
    required this.documentation,
    required this.termsOfUse,
    required this.timeLastUpdateUnix,
    required this.timeLastUpdateUtc,
    required this.timeNextUpdateUnix,
    required this.timeNextUpdateUtc,
    required this.baseCode,
    required this.conversionRates,
  });

  factory ExchangeRateResponse.fromJson(Map<String, dynamic> json) {
    final rawRates = json['conversion_rates'] as Map<String, dynamic>;
    final ratesList = rawRates.entries
        .map((entry) => CurrencyRate.fromJson(entry.key, entry.value))
        .toList();

    return ExchangeRateResponse(
      result: json['result'] ?? '',
      documentation: json['documentation'] ?? '',
      termsOfUse: json['terms_of_use'] ?? '',
      timeLastUpdateUnix: json['time_last_update_unix'] ?? 0,
      timeLastUpdateUtc: json['time_last_update_utc'] ?? '',
      timeNextUpdateUnix: json['time_next_update_unix'] ?? 0,
      timeNextUpdateUtc: json['time_next_update_utc'] ?? '',
      baseCode: json['base_code'] ?? '',
      conversionRates: ratesList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'result': result,
      'documentation': documentation,
      'terms_of_use': termsOfUse,
      'time_last_update_unix': timeLastUpdateUnix,
      'time_last_update_utc': timeLastUpdateUtc,
      'time_next_update_unix': timeNextUpdateUnix,
      'time_next_update_utc': timeNextUpdateUtc,
      'base_code': baseCode,
      'conversion_rates': Map.fromEntries(
        conversionRates.map((c) => MapEntry(c.code, c.rate)),
      ),
    };
  }
}

class CurrencyRate {
  final String code;
  final double rate;

  CurrencyRate({required this.code, required this.rate});

  factory CurrencyRate.fromJson(String key, dynamic value) {
    return CurrencyRate(
      code: key,
      rate: value is num ? value.toDouble() : 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'rate': rate,
    };
  }
}
