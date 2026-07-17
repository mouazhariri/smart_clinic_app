import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../src/resourses/font_manager/app_text_style.dart';

/// A clean, reusable section header widget for booking screens.
/// Follows single-responsibility principle.
class BookingSectionHeader extends StatelessWidget {
  const BookingSectionHeader({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyle.interBold18.copyWith(
        color: AppColors.textPrimary,
      ),
    );
  }
}
