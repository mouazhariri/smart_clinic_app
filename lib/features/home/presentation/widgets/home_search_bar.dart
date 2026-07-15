import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../src/resourses/font_manager/app_text_style.dart';

/// A tappable search/booking prompt card shown under the app bar.
class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.dashBorder),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.dashPrimaryBg,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(
                Icons.search_rounded,
                size: 20,
                color: AppColors.dashPrimary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    context.tr('how_do_you_feel'),
                    style: AppTextStyle.tajawalRegular14
                        .copyWith(color: AppColors.dashPlaceholder),
                  ),
                  Text(
                    context.tr('book_easily'),
                    style: AppTextStyle.tajawalRegular14
                        .copyWith(color: AppColors.dashPlaceholder),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: AppColors.dashPlaceholder,
            ),
          ],
        ),
      ),
    );
  }
}
