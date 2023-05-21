import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../services/bank_service.dart';
import '../models/bank_model.dart';

class MainAppState extends ChangeNotifier {
  int selectedIndex = 0;
  bool isLoading = false;
  var box = Hive.box('banks');

  final GlobalKey<ScaffoldState> key = GlobalKey();

  List<BankModel> allBanks = [];

  MainAppState() {
    getBanks();
    addBox();
  }

  void changePage(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  void changeLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  void getBanks() async {
    changeLoading();
    allBanks = await BankService.getBanks();
    changeLoading();
  }

  void addBox() {
    for (var element in allBanks) {
      box.add(
        BankModel(
          bank: element.bank,
          buy: element.buy,
          sell: element.sell,
        ),
      );
    }
    notifyListeners();
  }
}
