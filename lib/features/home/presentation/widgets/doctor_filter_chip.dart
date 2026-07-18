import 'package:flutter/material.dart';

import '../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../src/resourses/font_manager/app_text_style.dart';

/// A single pill-shaped filter chip used above the doctors list.
class DoctorFilterChip extends StatelessWidget {
  const DoctorFilterChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppColors.dashPrimaryBg : AppColors.white,
          borderRadius: BorderRadius.circular(100),
          border: selected
              ? null
              : Border.all(color: AppColors.dashBorder),
        ),
        child: Text(
          label,
          style: (selected
                  ? AppTextStyle.tajawalBold14
                  : AppTextStyle.tajawalMedium14)
              .copyWith(
                  color: selected ? AppColors.dashPrimary : AppColors.dashPlaceholder),
        ),
      ),
    );
  }
}
