import 'package:dollar_kursi/presentation/widgets/bank_container.dart';
import 'package:dollar_kursi/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
  ];

  List<String> bankImages = [
    AppAssets.images.bank1,
    AppAssets.images.bank2,
    AppAssets.images.bank3,
    AppAssets.images.bank4,
    AppAssets.images.bank5,
    AppAssets.images.bank6,
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            child: SearchBar(
              hintText: 'Qidirmoq',
              leading: IconButton(
                onPressed: () {},
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
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, index) {
              return BankContainer(
                image: bankImages[index],
                name: bankNames[index],
              );
            },
            separatorBuilder: (BuildContext context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Divider(color: AppColors.primarySurface),
            ),
            itemCount: 6,
          ),
          const SizedBox(height: 6),
        ],
      ),
    );
  }
}
