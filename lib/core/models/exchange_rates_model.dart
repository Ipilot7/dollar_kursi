import 'package:hive/hive.dart';

part 'exchange_rates_model.g.dart';

@HiveType(typeId: 0)
class ExchangeRatesModel {
  @HiveField(0)
  String? lastDate;
  @HiveField(1)
  List<BankModel>? data;

  ExchangeRatesModel({this.lastDate, this.data});

  ExchangeRatesModel.fromJson(Map<String, dynamic> json) {
    lastDate = json['last_date'];
    if (json['data'] != null) {
      data = <BankModel>[];
      json['data'].forEach((v) {
        data!.add(new BankModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['last_date'] = this.lastDate;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

@HiveType(typeId: 1)
class BankModel {
  @HiveField(0)
  Bank? bank;
  @HiveField(1)
  int? buy;
  @HiveField(2)
  int? sell;

  BankModel({this.bank, this.buy, this.sell});

  BankModel.fromJson(Map<String, dynamic> json) {
    bank = json['bank'] != null ? new Bank.fromJson(json['bank']) : null;
    buy = json['buy'];
    sell = json['sell'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bank != null) {
      data['bank'] = this.bank!.toJson();
    }
    data['buy'] = this.buy;
    data['sell'] = this.sell;
    return data;
  }
}

@HiveType(typeId: 2)
class Bank {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? slug;
  @HiveField(2)
  String? image;

  Bank({this.name, this.slug, this.image});

  Bank.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['image'] = this.image;
    return data;
  }
}
