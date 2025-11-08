part of 'theme_cubit.dart';

class ThemeState {
  final ThemeMode themeMode;
  final ThemeData themeData;
  final ThemeData darkThemeData;

  const ThemeState({
    required this.themeMode,
    required this.themeData,
    required this.darkThemeData,
  });

  ThemeState copyWith({ThemeMode? themeMode}) => ThemeState(
        themeMode: themeMode ?? this.themeMode,
        themeData: themeData,
        darkThemeData: darkThemeData,
      );
}
