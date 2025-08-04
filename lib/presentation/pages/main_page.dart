import 'package:dollar_kursi/core/bloc/exchange_rate_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';
import '../widgets/sort_item.dart';
import '../widgets/drawer.dart';
import 'settings_page.dart';
import 'home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageController pageController = PageController(initialPage: 0);

  final List<String> titles = [
    'Alifbo tartibida',
    'Qimmat sotib oluchi',
    'Arzon sotuvchi',
  ];

  final List<String> icons = [
    AppAssets.icons.sortAlphabet,
    AppAssets.icons.sortUp,
    AppAssets.icons.sortDown,
  ];

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ExchangeRateBloc>();

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const AppDrawer(),
      body: BlocBuilder<ExchangeRateBloc, ExchangeRateState>(
        builder: (context, state) {
          return SafeArea(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              children: const [HomePage(), SettingsPage()],
            ),
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<ExchangeRateBloc, ExchangeRateState>(
        builder: (context, state) {
          return NavigationBar(
            selectedIndex: state.selectedIndex,
            onDestinationSelected: (value) {
              bloc.add(ChangePage(value));
              pageController.jumpToPage(value);
            },
            destinations: [
              NavigationDestination(
                icon: SvgPicture.asset(AppAssets.icons.home),
                selectedIcon: SvgPicture.asset(AppAssets.icons.homeFilled),
                label: 'Bosh sahifa',
              ),
              NavigationDestination(
                icon: SvgPicture.asset(AppAssets.icons.settings),
                selectedIcon: SvgPicture.asset(AppAssets.icons.settingsFilled),
                label: 'Sozlamalar',
              ),
            ],
          );
        },
      ),

      floatingActionButton: BlocBuilder<ExchangeRateBloc, ExchangeRateState>(
        builder: (context, state) {
          return state.selectedIndex == 0
              ? FloatingActionButton(
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: AppColors.primarySurface,
                    showDragHandle: true,
                    context: context,
                    builder:
                        (_) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(3, (index) {
                            return SortItem(
                              title: titles[index],
                              iconPath: icons[index],
                              index: index,
                            );
                          }),
                        ),
                  );
                },
                child: SvgPicture.asset(AppAssets.icons.filter),
              )
              : const SizedBox.shrink();
        },
      ),
    );
  }
}
