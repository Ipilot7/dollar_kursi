class BankModel {
  Bank? bank;
  int? buy;
  int? sell;

  BankModel({this.bank, this.buy, this.sell});

  BankModel.fromJson(Map<String, dynamic> json) {
    bank = json['bank'] != null ? Bank.fromJson(json['bank']) : null;
    buy = json['buy'];
    sell = json['sell'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (bank != null) {
      data['bank'] = bank!.toJson();
    }
    data['buy'] = buy;
    data['sell'] = sell;
    return data;
  }
}

class Bank {
  String? name;
  String? slug;
  String? image;

  Bank({this.name, this.slug, this.image});

  Bank.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['slug'] = slug;
    data['image'] = image;
    return data;
  }
}
