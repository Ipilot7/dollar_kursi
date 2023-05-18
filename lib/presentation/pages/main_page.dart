import 'package:dollar_kursi/presentation/widgets/drawer.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/provider/main_state.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';
import 'settings_page.dart';
import 'home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    var mainState = context.watch<MainAppState>();

    return Scaffold(
      key: context.watch<MainAppState>().key,
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: const [
            HomePage(),
            SettingsPage(),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: mainState.selectedIndex,
        onDestinationSelected: (value) {
          mainState.changePage(value);
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
      ),
      floatingActionButton: mainState.selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () {},
              child: SvgPicture.asset(AppAssets.icons.filter),
            )
          : null,
      drawer: const AppDrawer(),
    );
  }
}
