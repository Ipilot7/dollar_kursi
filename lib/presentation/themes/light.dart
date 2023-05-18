import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

ThemeData lightTheme() {
  return ThemeData(
    useMaterial3: true,
    primaryColor: AppColors.primary,
    navigationBarTheme: NavigationBarThemeData(
      labelTextStyle: MaterialStatePropertyAll(
        TextStyle(
          fontWeight: FontWeight.w500,
          color: AppColors.onPrimaryContainer,
          fontFamily: 'Roboto',
          fontSize: 12,
        ),
      ),
      backgroundColor: AppColors.primarySurface,
      indicatorColor: AppColors.primaryContainer,
      elevation: 0,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryContainer,
    ),
    searchBarTheme: SearchBarThemeData(
      backgroundColor: MaterialStatePropertyAll(
        AppColors.secondarySurface,
      ),
      elevation: const MaterialStatePropertyAll(0),
      hintStyle: MaterialStatePropertyAll(
        TextStyle(
          fontWeight: FontWeight.w400,
          color: AppColors.onSurface60,
          fontFamily: 'Roboto',
          fontSize: 16,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(AppColors.primaryContainer),
        shadowColor: const MaterialStatePropertyAll(Colors.transparent),
        elevation: const MaterialStatePropertyAll(0),
      ),
    ),
  );
}
