import 'package:flutter/material.dart';

import '../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../src/resourses/font_manager/app_text_style.dart';

class AvailableTimeWidget extends StatelessWidget {
  const AvailableTimeWidget({
    super.key,
    required this.times,
    required this.selectedTime,
    required this.onSelected,
  });

  final List<String> times;
  final String? selectedTime;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: times.map((time) {
        final selected = selectedTime == time;
        return ChoiceChip(
          label: Text(time),
          selected: selected,
          onSelected: (_) => onSelected(time),
          selectedColor: AppColors.primary,
          backgroundColor: AppColors.white,
          labelStyle: AppTextStyle.interMedium14.copyWith(
            color: selected ? AppColors.white : AppColors.textPrimary,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: selected ? AppColors.primary : AppColors.navBorder,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        );
      }).toList(),
    );
  }
}
