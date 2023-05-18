import 'package:flutter/material.dart';

class MainAppState extends ChangeNotifier {
  int selectedIndex = 0;
  final GlobalKey<ScaffoldState> key = GlobalKey();

  void changePage(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
