import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../src/resourses/font_manager/app_text_style.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({
    super.key,
    this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: AppColors.homeBorder,
          ),
         
        ),
        child: Row(
          spacing: 14,
          children: [

            const Icon(
              Icons.search_rounded,
              color: AppColors.textPrimary,
              size: 28,
            ),
                Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.tr("how_do_you_feel"),
                    style: AppTextStyle.tajawalMedium13.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    context.tr("book_easily"),
                    style: AppTextStyle.tajawalRegular12.copyWith(
                      color: AppColors.dashPlaceholder,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppColors.homeBlueLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.filter_alt_outlined,
                size: 20,
                color: AppColors.primary,
              ),
            ),

            // const SizedBox(width: 14),

        
            // const SizedBox(width: 14),

          ],
        ),
      ),
    );
  }
}