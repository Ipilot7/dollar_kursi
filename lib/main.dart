import 'package:dollar_kursi/core/bloc/exchange_rate_bloc.dart';
import 'package:dollar_kursi/core/models/exchange_rates_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';

import 'presentation/pages/main_page.dart';
import 'presentation/themes/light.dart';
import 'utils/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();

  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(ExchangeRatesModelAdapter());
  Hive.registerAdapter(BankModelAdapter());
  Hive.registerAdapter(BankAdapter());

  await Hive.openBox('banks');

  runApp(
    BlocProvider(
      create: (_) => ExchangeRateBloc()..add(LoadBanks()),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.primarySurface,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: AppColors.background,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MainPage(),
      theme: lightTheme(),
    );
  }
}
