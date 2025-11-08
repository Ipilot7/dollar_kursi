import 'package:dollar_kursi/core/blocs/exchange_rate_bloc/exchange_rate_bloc.dart';
import 'package:dollar_kursi/core/blocs/theme/theme_cubit.dart';
import 'package:dollar_kursi/di/di.dart';
import 'package:dollar_kursi/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/pages/main_page.dart';

void main() async {
  await initDependencies();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.primarySurface,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: AppColors.background,
      ),
    );

    // Тянем ThemeCubit и ExchangeRateBloc через MultiBlocProvider
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<ThemeCubit>()),
        BlocProvider(
          create:
              (_) =>
                  sl<ExchangeRateBloc>()
                    ..add(LoadBanks())
                    ..add(SetDeivceAndFCM()),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: state.themeData,
            darkTheme: state.darkThemeData,
            themeMode: state.themeMode,
            home: const MainPage(),
          );
        },
      ),
    );
  }
}
