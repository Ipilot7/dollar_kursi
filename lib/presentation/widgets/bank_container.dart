import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_text_styles.dart';

class BankContainer extends StatelessWidget {
  const BankContainer({
    required this.image,
    required this.name,
    required this.buyPrice,
    required this.sellPrice,
    super.key,
  });

  final String name;
  final String image;
  final int buyPrice;
  final int sellPrice;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Material(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        elevation: theme.brightness == Brightness.light ? 1 : 0,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              children: [
                // 🏦 Логотип банка
                Container(
                  height: 56,
                  width: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: colorScheme.outline.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CachedNetworkImage(
                      imageUrl: image,
                      fit: BoxFit.cover,
                      placeholder:
                          (context, url) =>
                              Image.asset(AppAssets.images.noImage),
                      errorWidget:
                          (context, url, error) =>
                              Image.asset(AppAssets.images.noImage),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // 📄 Название банка
                Expanded(
                  child: Text(
                    name,
                    style: AppTextStyles.title.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),

                // 💸 Курсы
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Text(
                          '$buyPrice',
                          style: AppTextStyles.description.copyWith(
                            color: colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(width: 6),
                        SvgPicture.asset(
                          AppAssets.icons.up,
                          colorFilter: ColorFilter.mode(
                            Colors.greenAccent.shade400,
                            BlendMode.srcIn,
                          ),
                          height: 14,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          '$sellPrice',
                          style: AppTextStyles.description.copyWith(
                            color: colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(width: 6),
                        SvgPicture.asset(
                          AppAssets.icons.down,
                          colorFilter: const ColorFilter.mode(
                            Colors.redAccent,
                            BlendMode.srcIn,
                          ),
                          height: 14,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
