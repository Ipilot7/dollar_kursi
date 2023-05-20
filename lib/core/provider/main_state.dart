import 'package:flutter/material.dart';

import '../services/bank_service.dart';
import '../models/bank_model.dart';

class MainAppState extends ChangeNotifier {
  int selectedIndex = 0;
  bool isLoading = false;

  final GlobalKey<ScaffoldState> key = GlobalKey();

  List<BankModel> allBanks = [];

  MainAppState() {
    getBanks();
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
}
