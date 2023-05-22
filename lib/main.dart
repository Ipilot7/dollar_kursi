import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';

import 'presentation/pages/main_page.dart';
import 'presentation/themes/light.dart';
import 'core/provider/main_state.dart';
import 'core/models/bank_model.dart';
import 'utils/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();

  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(BankModelAdapter());
  Hive.registerAdapter(BankAdapter());

  await Hive.openBox('banks');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainAppState()),
      ],
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
