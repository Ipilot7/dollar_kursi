class BankModel {
  String? bankName;
  int? buy;
  int? sell;

  BankModel({this.bankName, this.buy, this.sell});

  BankModel.fromJson(Map<String, dynamic> json) {
    bankName = json['bank_name'];
    buy = json['buy'];
    sell = json['sell'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bank_name'] = bankName;
    data['buy'] = buy;
    data['sell'] = sell;
    return data;
  }
}
