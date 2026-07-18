import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../src/resourses/font_manager/app_text_style.dart';

/// A dedicated confirmation button widget for booking actions.
/// Separates action logic from screen layout (SRP).
class BookingConfirmButton extends StatelessWidget {
  const BookingConfirmButton({
    super.key,
    required this.isEnabled,
    required this.isLoading,
    required this.onPressed,
  });

  final bool isEnabled;
  final bool isLoading;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: FilledButton(
        onPressed: isEnabled ? onPressed : null,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          disabledBackgroundColor: AppColors.disabledButton,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.white,
                ),
              )
            : Text(
                context.tr('confirm_booking'),
                style: AppTextStyle.interSemiBold16.copyWith(
                  color: AppColors.white,
                ),
              ),
      ),
    );
  }
}
