import 'package:dollar_kursi/core/bloc/exchange_rate_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../widgets/bank_container.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return BlocBuilder<ExchangeRateBloc, ExchangeRateState>(
      builder: (context, state) {
        final banks = state.banks;
        return BlocBuilder<ExchangeRateBloc, ExchangeRateState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
            return ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: SearchBar(
                    hintText: 'Qidirmoq',
                    leading: IconButton(
                      onPressed: () => scaffoldKey.currentState?.openDrawer(),
                      icon: SvgPicture.asset(AppAssets.icons.drawer),
                    ),
                    trailing: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: SvgPicture.asset(AppAssets.icons.search),
                      ),
                    ],
                    onChanged:
                        (value) => context.read<ExchangeRateBloc>().add(
                          SearchQueryChanged(value),
                        ),
                  ),
                ),

                Align(
                  alignment: Alignment.center,
                  child: Text(
                    state.lastUpdate,
                    style: AppTextStyles.pageTitle.copyWith(fontSize: 18),
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: banks.length,
                  itemBuilder: (_, index) {
                    final item = banks[index];
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
                        child: Divider(
                          color: AppColors.secondarySurface,
                          height: 8,
                        ),
                      ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
