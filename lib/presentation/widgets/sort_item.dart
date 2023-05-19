import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import '../../utils/app_text_styles.dart';
import '../../utils/app_colors.dart';

class SortItem extends StatelessWidget {
  const SortItem({
    super.key,
    required this.title,
    required this.iconPath,
    required this.index,
  });
  final String title;
  final String iconPath;
  final int index;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      fillColor: MaterialStatePropertyAll(AppColors.primary),
      value: index == 1 ? true : false,
      title: Row(
        children: [
          SvgPicture.asset(iconPath),
          const SizedBox(width: 16),
          Text(title, style: AppTextStyles.title),
        ],
      ),
      onChanged: (value) {
        Navigator.pop(context);
      },
    );
  }
}
