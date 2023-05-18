import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static List<String> titles = <String>[
    'Bildirishnomalar',
    'Mavzu',
    'Xavfsizlik',
    'Ilova haqida',
  ];

  static List<String> icons = <String>[
    AppAssets.icons.notifications,
    AppAssets.icons.appereance,
    AppAssets.icons.privacy,
    AppAssets.icons.about,
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(AppAssets.icons.search),
              ),
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(AppAssets.icons.more),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Sozlamalar',
            style: AppTextStyles.pageTitle,
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 16,
          ),
          child: Text(
            'Asosiy',
            style: AppTextStyles.button.copyWith(color: AppColors.primary),
          ),
        ),
        ...List.generate(
          4,
          (index) => ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 2,
            ),
            onTap: () {},
            leading: SvgPicture.asset(icons[index]),
            title: Text(
              titles[index],
              style: AppTextStyles.title,
            ),
          ),
        )
      ],
    );
  }
}
