import 'package:dollar_kursi/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/app_assets.dart';
import '../../utils/app_text_styles.dart';

class DrawerEButton extends StatelessWidget {
  const DrawerEButton({
    super.key,
    required this.title,
    required this.isActive,
  });

  final String title;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: SvgPicture.asset(AppAssets.icons.circle),
      style: ButtonStyle(
        alignment: Alignment.centerLeft,
        padding: const MaterialStatePropertyAll(EdgeInsets.all(16)),
        backgroundColor: MaterialStatePropertyAll(isActive ? null : AppColors.secondarySurface),
      ),
      label: Text(
        title,
        style: isActive ? AppTextStyles.drawerActiveTitle : AppTextStyles.drawerTitle,
      ),
    );
  }
}
