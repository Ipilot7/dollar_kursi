import 'package:dollar_kursi/core/provider/main_state.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

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
    var mainState = context.watch<MainAppState>();

    return CheckboxListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      fillColor: MaterialStatePropertyAll(AppColors.primary),
      value: index == mainState.sortIndex ? true : false,
      title: Row(
        children: [
          SvgPicture.asset(iconPath),
          const SizedBox(width: 16),
          Text(title, style: AppTextStyles.title),
        ],
      ),
      onChanged: (value) {
        mainState.changeSortIndex(index);
        Navigator.pop(context);
      },
    );
  }
}
