import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/provider/main_state.dart';
import '../../core/models/bank_model.dart';
import '../../utils/app_text_styles.dart';
import '../widgets/bank_container.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var currentState = context.read<MainAppState>();

    List<BankModel> data = currentState.box.values.toList().cast();

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
                currentState.key.currentState!.openDrawer();
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
          data.length,
          (index) => Column(
            children: [
              BankContainer(
                image: 'http://13.53.144.174${data[index].bank!.image}',
                name: data[index].bank!.name!,
                buyPrice: data[index].buy!,
                sellPrice: data[index].sell!,
              ),
              index != data.length - 1
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
