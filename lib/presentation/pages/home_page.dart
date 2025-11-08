import 'package:dollar_kursi/core/blocs/exchange_rate_bloc/exchange_rate_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/bank_container.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_text_styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Text(
                'Dollar Kursi',
                style: AppTextStyles.pageTitle.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Sozlamalar'),
              onTap: () {
                Navigator.pop(context);
                // TODO: переход в настройки
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<ExchangeRateBloc, ExchangeRateState>(
          builder: (context, state) {
            final banks = state.banks;
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }

            return ListView(
              shrinkWrap: true,
              children: [
                // 🔍 Поисковая панель
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: SearchBar(
                    hintText: 'Qidirmoq',
                    backgroundColor: MaterialStatePropertyAll(
                      Theme.of(context).colorScheme.surfaceVariant,
                    ),
                    // leading: IconButton(
                    //   onPressed: () =>
                    //       scaffoldKey.currentState?.openDrawer(),
                    //   icon: SvgPicture.asset(AppAssets.icons.drawer),
                    // ),
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

                // 🕒 Дата последнего обновления
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    state.lastUpdate,
                    style: AppTextStyles.pageTitle.copyWith(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // 💰 Список банков
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: banks.length,
                  itemBuilder: (_, index) {
                    final item = banks[index];
                    return BankContainer(
                      image: item.bank?.image ?? '',
                      name: item.bank?.name ?? '',
                      buyPrice: item.buy ?? 0,
                      sellPrice: item.sell ?? 0,
                    );
                  },
                  separatorBuilder:
                      (_, __) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Divider(
                          color: Theme.of(
                            context,
                          ).dividerColor.withOpacity(0.5),
                          height: 8,
                        ),
                      ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
