import 'package:dollar_kursi/core/provider/main_state.dart';
import 'package:dollar_kursi/presentation/widgets/bank_container.dart';
import 'package:dollar_kursi/utils/app_colors.dart';
import 'package:dollar_kursi/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../utils/app_assets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> bankNames = [
    'Xalq banki',
    'Turonbank',
    'Hamkorbank',
    'Agrobank',
    'Trastbank',
    'Infinbank',
    'Kapitalbank',
    'Sanoat Qurilish Bank',
    'Ziraat Bank',
    'Milliy Bank',
    'Ipak yo\'li bank',
    'Asia Alliance Bank',
    'Asakabank',
    'Garant Bank',
    'Ipoteka Bank',
    'Orient Finans Bank',
    'Universalbank',
    'Qishloq Qurilish Bank',
    'Aloqabank',
  ];

  List<String> bankImages = [
    AppAssets.images.bank1,
    AppAssets.images.bank2,
    AppAssets.images.bank3,
    AppAssets.images.bank4,
    AppAssets.images.bank5,
    AppAssets.images.bank6,
    AppAssets.images.bank7,
    AppAssets.images.bank8,
    AppAssets.images.bank9,
    AppAssets.images.bank10,
    AppAssets.images.bank11,
    AppAssets.images.bank12,
    AppAssets.images.bank13,
    AppAssets.images.bank14,
    AppAssets.images.bank15,
    AppAssets.images.bank16,
    AppAssets.images.bank17,
    AppAssets.images.bank18,
    AppAssets.images.bank19,
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          child: SearchBar(
            hintText: 'Qidirmoq',
            leading: IconButton(
              onPressed: () {
                context.read<MainAppState>().key.currentState!.openDrawer();
              },
              icon: SvgPicture.asset(AppAssets.icons.drawer),
            ),
            trailing: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: SvgPicture.asset(AppAssets.icons.search),
              ),
            ],
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
        ...List.generate(
          19,
          (index) => Column(
            children: [
              BankContainer(
                image: bankImages[index],
                name: bankNames[index],
              ),
              index != 18
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Divider(
                        color: AppColors.secondarySurface,
                        height: 8,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
        const SizedBox(height: 62),
      ],
    );
  }
}
