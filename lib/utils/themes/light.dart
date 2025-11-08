import 'package:flutter/material.dart';
import '../app_colors.dart';

class AppTheme {
  AppTheme._(); // приватный конструктор — чтобы никто не создавал экземпляр

  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.primarySurface,
      navigationBarTheme: NavigationBarThemeData(
        labelTextStyle: const MaterialStatePropertyAll(
          TextStyle(
            fontWeight: FontWeight.w500,
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
        backgroundColor:
            MaterialStatePropertyAll(AppColors.secondarySurface),
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
          backgroundColor:
              MaterialStatePropertyAll(AppColors.primaryContainer),
          shadowColor:
              const MaterialStatePropertyAll(Colors.transparent),
          elevation: const MaterialStatePropertyAll(0),
        ),
      ),
    );
  }

  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryContainer,
      scaffoldBackgroundColor: AppColors.surfaceDark,
      navigationBarTheme: NavigationBarThemeData(
        labelTextStyle: MaterialStatePropertyAll(
          TextStyle(
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
            fontSize: 12,
            color: AppColors.onPrimaryContainerDark,
          ),
        ),
        backgroundColor: AppColors.surfaceDark,
        indicatorColor: AppColors.primaryDark,
        elevation: 0,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryDark,
        foregroundColor: AppColors.onPrimaryDark,
      ),
      searchBarTheme: SearchBarThemeData(
        backgroundColor:
            MaterialStatePropertyAll(AppColors.secondarySurfaceDark),
        elevation: const MaterialStatePropertyAll(0),
        hintStyle: MaterialStatePropertyAll(
          TextStyle(
            fontWeight: FontWeight.w400,
            color: AppColors.onSurface60Dark,
            fontFamily: 'Roboto',
            fontSize: 16,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(AppColors.primaryDark),
          foregroundColor:
              MaterialStatePropertyAll(AppColors.onPrimaryDark),
          shadowColor:
              const MaterialStatePropertyAll(Colors.transparent),
          elevation: const MaterialStatePropertyAll(0),
        ),
      ),
      cardColor: AppColors.surfaceContainerDark,
      dividerColor: AppColors.onSurface12Dark,
    );
  }
}
