import 'package:flutter/material.dart';

import '../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../src/resourses/font_manager/app_text_style.dart';

/// Clean time slot card for booking flow.
/// Handles selected (primary), available (white), and disabled (neutral bg + line through) states.
class TimeSlotCard extends StatelessWidget {
  const TimeSlotCard({
    super.key,
    required this.time,
    required this.isSelected,
    required this.isDisabled,
    required this.onTap,
  });

  final String time;
  final bool isSelected;
  final bool isDisabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: isDisabled ? null : onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.dashPrimary
              : (isDisabled ? AppColors.dashNeutralBg : AppColors.white),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppColors.dashPrimary : AppColors.dashBorder,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 4,
          children: [
            Text(
              time,
              textAlign: TextAlign.center,
              style: AppTextStyle.tajawalRegular14.copyWith(
                color: isSelected
                    ? AppColors.white
                    : (isDisabled ? AppColors.placeholder : AppColors.dashBodyNeutral),
                decoration: isDisabled ? TextDecoration.lineThrough : TextDecoration.none,
                decorationColor: AppColors.placeholder,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
