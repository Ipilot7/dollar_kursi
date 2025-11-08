import 'package:dollar_kursi/core/blocs/exchange_rate_bloc/exchange_rate_bloc.dart';
import 'package:dollar_kursi/core/blocs/theme/theme_cubit.dart';
import 'package:dollar_kursi/core/models/exchange_rates_model.dart';
import 'package:dollar_kursi/firebase_options.dart';
import 'package:dollar_kursi/utils/push_notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => prefs);

  // Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Push-уведомления
  await PushNotificationService().init();

  // Hive
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(ExchangeRatesModelAdapter());
  Hive.registerAdapter(BankModelAdapter());
  Hive.registerAdapter(BankAdapter());
  await Hive.openBox('banks');

  // ThemeCubit (использует SharedPreferences)
  sl.registerLazySingleton<ThemeCubit>(() => ThemeCubit(prefs: sl()));
  sl.registerLazySingleton<ExchangeRateBloc>(() => ExchangeRateBloc());
}
