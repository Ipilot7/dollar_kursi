import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/provider/main_state.dart';
import '../../utils/app_text_styles.dart';
import '../widgets/bank_container.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<MainAppState>();
    final filteredData = state.filteredBanks;

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: SearchBar(
            hintText: 'Qidirmoq',
            leading: IconButton(
              onPressed: () {
                state.key.currentState!.openDrawer();
              },
              icon: SvgPicture.asset(AppAssets.icons.drawer),
            ),
            trailing: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: SvgPicture.asset(AppAssets.icons.search),
              ),
            ],
            onChanged: state.setSearchQuery,
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            'Bugun - 19.05.2023 (10:00)',
            style: AppTextStyles.pageTitle.copyWith(fontSize: 18),
          ),
        ),
        const SizedBox(height: 10),
        if (filteredData.isEmpty)
          const Center(child: Text('Hech qanday natija topilmadi')),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: filteredData.length,
          itemBuilder: (_, index) {
            final item = filteredData[index];
            return BankContainer(
              image: item.bank!.image ?? '',
              name: item.bank!.name!,
              buyPrice: item.buy!,
              sellPrice: item.sell!,
            );
          },
          separatorBuilder:
              (_, __) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Divider(color: AppColors.secondarySurface, height: 8),
              ),
        ),
      ],
    );
  }
}
