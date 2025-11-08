import 'package:dollar_kursi/core/blocs/exchange_rate_bloc/exchange_rate_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocBuilder<ExchangeRateBloc, ExchangeRateState>(
      builder: (context, state) {
        return CheckboxListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          fillColor: WidgetStatePropertyAll(AppColors.primary),
          value: index == state.sortIndex ? true : false,
          title: Row(
            children: [
              SvgPicture.asset(iconPath),
              const SizedBox(width: 16),
              Text(title, style: AppTextStyles.title),
            ],
          ),
          onChanged: (value) {
            context.read<ExchangeRateBloc>().add(ChangeSortIndex(index));
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
