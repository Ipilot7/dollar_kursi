import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static String font = 'Roboto';

  static TextStyle pageTitle = TextStyle(
    color: AppColors.onSurface20,
    fontWeight: FontWeight.w500,
    fontFamily: font,
    fontSize: 24,
  );

  static TextStyle title = TextStyle(
    color: AppColors.onSurface20,
    fontWeight: FontWeight.w400,
    fontFamily: font,
    fontSize: 16,
  );

  static TextStyle description = TextStyle(
    color: AppColors.onSurface60,
    fontWeight: FontWeight.w400,
    fontFamily: font,
    fontSize: 14,
  );

  static TextStyle button = TextStyle(
    color: AppColors.text,
    fontWeight: FontWeight.w500,
    fontFamily: font,
    fontSize: 14,
  );

  static TextStyle letter = TextStyle(
    color: AppColors.primary,
    fontWeight: FontWeight.w500,
    fontFamily: font,
    fontSize: 16,
  );
}
