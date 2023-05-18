import 'package:dollar_kursi/utils/app_assets.dart';
import 'package:dollar_kursi/utils/app_colors.dart';
import 'package:dollar_kursi/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.secondarySurface,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 18, 0, 18),
              child: Text(
                'Dollar kursi',
                style: AppTextStyles.title,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 18, 0, 18),
              child: Text(
                'Asosiy',
                style: AppTextStyles.button,
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: SvgPicture.asset(AppAssets.icons.circle),
              style: const ButtonStyle(
                alignment: Alignment.centerLeft,
                padding: MaterialStatePropertyAll(EdgeInsets.all(16)),
              ),
              label: Text(
                'Bosh sahifa',
                style: AppTextStyles.button,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
