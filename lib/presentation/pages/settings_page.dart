import 'package:dollar_kursi/core/blocs/theme/theme_cubit.dart';
import 'package:dollar_kursi/di/di.dart';
import 'package:dollar_kursi/presentation/widgets/coming_soon.dart';
import 'package:dollar_kursi/utils/push_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/app_text_styles.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notificationsEnabled = true;

  static const _prefKey = 'notifications_enabled';

  @override
  void initState() {
    super.initState();
    _loadNotificationState();
  }

  Future<void> _loadNotificationState() async {
    final prefs = sl<SharedPreferences>();
    setState(() {
      notificationsEnabled = prefs.getBool(_prefKey) ?? true;
    });
  }

  static const List<String> titles = [
    'Bildirishnomalar',
    'Mavzu',
    'Xavfsizlik',
    'Ilova haqida',
  ];

  static List<String> icons = [
    AppAssets.icons.notifications,
    AppAssets.icons.appereance,
    AppAssets.icons.privacy,
    AppAssets.icons.about,
  ];

  @override
  Widget build(BuildContext context) {
    final themeCubit = sl<ThemeCubit>();

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(AppAssets.icons.search),
              ),
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(AppAssets.icons.more),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text('Sozlamalar', style: AppTextStyles.pageTitle),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
          child: Text(
            'Asosiy',
            style: AppTextStyles.button.copyWith(color: AppColors.primary),
          ),
        ),

        // 🔔 Уведомления
        ListTile(
          leading: SvgPicture.asset(icons[0]),
          title: Text(titles[0], style: AppTextStyles.title),
          trailing: Switch(
            value: notificationsEnabled,
            activeColor: AppColors.primary,
            onChanged: (value) async {
              setState(() => notificationsEnabled = value);
              final push = PushNotificationService();
              if (value) {
                await push.enableNotifications(); // включить
              } else {
                await push.disableNotifications(); // выключить
              }
            },
          ),
        ),

        // 🌙 Тема
        BlocBuilder<ThemeCubit, ThemeState>(
          bloc: themeCubit,
          builder: (context, state) {
            final isDark = state.themeMode == ThemeMode.dark;
            return ListTile(
              leading: SvgPicture.asset(icons[1]),
              title: Text(titles[1], style: AppTextStyles.title),
              trailing: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color:
                      isDark
                          ? AppColors.primaryContainer
                          : AppColors.secondarySurface,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: IconButton(
                  icon: Icon(
                    isDark ? Icons.nightlight_round : Icons.wb_sunny_rounded,
                    color:
                        isDark
                            ? AppColors.onPrimaryContainer
                            : AppColors.primary,
                  ),
                  onPressed: themeCubit.toggleTheme,
                ),
              ),
            );
          },
        ),

        // 🔒 Безопасность
        ListTile(
          leading: SvgPicture.asset(icons[2]),
          title: Text(titles[2], style: AppTextStyles.title),
          onTap:
              () => showDialog(
                context: context,
                builder: (_) => const ComingSoonDialog(),
              ),
        ),

        // ℹ️ О приложении
        ListTile(
          leading: SvgPicture.asset(icons[3]),
          title: Text(titles[3], style: AppTextStyles.title),
          onTap:
              () => showDialog(
                context: context,
                builder: (_) => const ComingSoonDialog(),
              ),
        ),
      ],
    );
  }
}
