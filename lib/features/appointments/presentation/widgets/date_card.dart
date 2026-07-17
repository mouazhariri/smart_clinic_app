import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../src/resourses/font_manager/app_text_style.dart';

/// Clean date card widget for booking flow.
/// Follows SRP: only renders a single selectable date.
class DateCard extends StatelessWidget {
  const DateCard({
    super.key,
    required this.label,
    required this.dayNumber,
    required this.isSelected,
    required this.isDisabled,
    this.onTap,
  });

  final String label;
  final String dayNumber;
  final bool isSelected;
  final VoidCallback? onTap;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    final disabled = isDisabled || onTap == null;
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: disabled ? null : onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        decoration: BoxDecoration(
          color: disabled
              ? AppColors.dashNeutralBg
              : (isSelected ? AppColors.dashPrimary : AppColors.white),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: disabled
                ? AppColors.dashBorder.withOpacity(0.5)
                : (isSelected ? AppColors.dashPrimary : AppColors.dashBorder),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 4,
          children: [
            Text(
              label,
              textAlign: TextAlign.center,
              style: AppTextStyle.tajawalRegular12.copyWith(
                color: disabled
                    ? AppColors.placeholder
                    : (isSelected ? AppColors.white.withOpacity(0.9) : AppColors.dashSubtitle),
              ),
            ),
            Text(
              dayNumber,
              textAlign: TextAlign.center,
              style: AppTextStyle.tajawalBold16.copyWith(
                color: disabled
                    ? AppColors.placeholder
                    : (isSelected ? AppColors.white : AppColors.dashBodyNeutral),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
