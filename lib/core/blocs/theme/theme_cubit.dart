import 'package:dollar_kursi/utils/themes/light.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final SharedPreferences prefs;
  static const _key = 'theme_mode'; // хранит "light", "dark" или "system"

  ThemeCubit({required this.prefs})
    : super(
        ThemeState(
          themeMode: ThemeMode.system,
          themeData: AppTheme.light(),
          darkThemeData: AppTheme.dark(),
        ),
      ) {
    _loadTheme();
  }

  void _loadTheme() {
    final saved = prefs.getString(_key);
    switch (saved) {
      case 'light':
        emit(state.copyWith(themeMode: ThemeMode.light));
        break;
      case 'dark':
        emit(state.copyWith(themeMode: ThemeMode.dark));
        break;
      default:
        emit(state.copyWith(themeMode: ThemeMode.light));
    }
  }

  void toggleTheme() {
    final isDark = state.themeMode == ThemeMode.dark;
    final newMode = isDark ? ThemeMode.light : ThemeMode.dark;
    prefs.setString(_key, newMode.name);
    emit(state.copyWith(themeMode: newMode));
  }

  void setThemeMode(ThemeMode mode) {
    prefs.setString(_key, mode.name);
    emit(state.copyWith(themeMode: mode));
  }
}
