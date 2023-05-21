import 'dart:convert';

import 'package:dollar_kursi/core/models/bank_model.dart';
import 'package:http/http.dart';

class BankService {
  static Future<List<BankModel>> getBanks() async {
    String baseUrl = "http://13.53.144.174/exchange/?format=json";
    List<BankModel> allBanks = [];

    Response res = await get(Uri.parse(baseUrl));

    if (res.statusCode == 200) {
      allBanks = [for (final item in jsonDecode(res.body)['data']) BankModel.fromJson(item)];
      return allBanks;
    } else {
      return [].cast<BankModel>();
    }
  }
}
