import 'dart:convert';
import 'package:dollar_kursi/core/models/exchange_rates_model.dart';
import 'package:http/http.dart';

class BankService {
  static Future<ExchangeRatesModel> getBanks() async {
    const String baseUrl = "http://currency.bildung.uz/exchange/?format=json";

    final Response res = await get(Uri.parse(baseUrl));

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return ExchangeRatesModel.fromJson(data);
    } else {
      throw Exception('Failed to load exchange rates: ${res.statusCode}');
    }
  }
}
