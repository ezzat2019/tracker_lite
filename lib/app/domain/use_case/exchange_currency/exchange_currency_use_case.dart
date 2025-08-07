import 'package:tracker_lite/app/core/utils/get_it_manager.dart';
import 'package:tracker_lite/app/data/repo/exchange_currency/exchange_currency_repo.dart';

import '../../../data/models/exchange_currency/exchange_rate_response.dart';

class ExchangeCurrencyUseCase{
 final ExchangeCurrencyRepo exchangeCurrencyRepo =GetItManager
     .getIt.get<ExchangeCurrencyRepo>();

 Future<ExchangeRateResponse?> getExchangeRate()async{

   var res=await exchangeCurrencyRepo.getExchangeRate();
   if(res.statusCode==200)
     {
       return ExchangeRateResponse.fromJson(res.data);
     }
   else
     return null;
 }
}