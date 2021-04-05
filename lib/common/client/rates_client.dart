import 'dart:convert';

import 'package:crypto_info/model/rate.dart';
import 'package:http/http.dart' as http;


Future<RateModel> getEurRateAsync() async{
    return http.get(Uri.parse("https://api.coincap.io/v2/rates/euro")).then((value) {
      var valMap = json.decode(value.body)["data"];
      return RateModel.fromJson(valMap);
    });
}