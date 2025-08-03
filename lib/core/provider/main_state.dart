import 'package:flutter/material.dart';

import 'package:hive/hive.dart';

import '../services/bank_service.dart';
import '../models/bank_model.dart';

class MainAppState extends ChangeNotifier {
  int selectedIndex = 0;
  int sortIndex = 0;

  final GlobalKey<ScaffoldState> key = GlobalKey();
  List<BankModel> allBanks = [];
  var box = Hive.box('banks');

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  MainAppState() {
    getBanks();
  }

  void changePage(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  void getBanks() async {
    allBanks = await BankService.getBanks();
    await box.clear();
    if (box.isEmpty) addBox(allBanks);
    notifyListeners();
  }

  void addBox(List<BankModel> elements) {
    for (var element in elements) {
      box.add(
        BankModel(bank: element.bank, buy: element.buy, sell: element.sell),
      );
    }
  }

  void changeSortIndex(int index) {
    sortIndex = index;
    sortDatas();
    notifyListeners();
  }

  void sortDatas() {
    List<BankModel> data = box.values.toList().cast();

    switch (sortIndex) {
      case 0:
        data.sort((a, b) => a.bank!.name!.compareTo(b.bank!.name!));
        break;
      case 1:
        data.sort((a, b) => b.buy!.compareTo(a.buy!));
        break;
      case 2:
        data.sort((a, b) => a.sell!.compareTo(b.sell!));
        break;
      default:
        data.sort((a, b) => a.bank!.name!.compareTo(b.bank!.name!));
    }
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  List<BankModel> get filteredBanks {
    final List<BankModel> allData = box.values.toList().cast<BankModel>();
    return allData.where((bankModel) {
      final name = bankModel.bank?.name?.toLowerCase() ?? '';
      return name.contains(_searchQuery.toLowerCase());
    }).toList();
  }
}
