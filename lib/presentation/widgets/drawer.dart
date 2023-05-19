import 'package:dollar_kursi/utils/app_colors.dart';
import 'package:dollar_kursi/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

import 'drawer_button.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.secondarySurface,
      elevation: 0,
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
            const DrawerEButton(
              title: 'Bosh sahifa',
              isActive: true,
            ),
            const DrawerEButton(
              title: 'Yangiliklar',
              isActive: false,
            ),
            const DrawerEButton(
              title: 'Bildirishnomalar',
              isActive: false,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Divider(color: Color(0xFFCAC4D0)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 18, 0, 18),
              child: Text(
                'Ilova haqida',
                style: AppTextStyles.button,
              ),
            ),
            const DrawerEButton(
              title: 'Qo\'llanma',
              isActive: false,
            ),
            const DrawerEButton(
              title: 'Joriy versiya',
              isActive: false,
            ),
          ],
        ),
      ),
    );
  }
}
