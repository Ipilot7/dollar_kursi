import 'package:flutter/material.dart';

class MainAppState extends ChangeNotifier {
  int selectedIndex = 0;

  void changePage(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
