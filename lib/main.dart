import 'package:dollar_kursi/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import 'presentation/pages/main_page.dart';
import 'presentation/themes/light.dart';
import 'core/provider/main_state.dart';

void main() {
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
