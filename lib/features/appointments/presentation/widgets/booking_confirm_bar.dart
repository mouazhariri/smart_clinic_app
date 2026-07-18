import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../src/resourses/font_manager/app_text_style.dart';

/// Clean confirmation bottom bar for booking.
class BookingConfirmBar extends StatelessWidget {
  const BookingConfirmBar({
    super.key,
    required this.price,
    required this.dateTimeInfo,
    required this.termsText,
    required this.onConfirm,
  });

  final String price;
  final String dateTimeInfo;
  final String termsText;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(width: 1, color: AppColors.divider),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          // Price + info row
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 16,
            children: [
              Text(
                price,
                textAlign: TextAlign.right,
                style: AppTextStyle.tajawalBold14.copyWith(
                  color: AppColors.dashPrimary,
                ),
              ),
              Text(
                dateTimeInfo,
                textAlign: TextAlign.right,
                style: AppTextStyle.tajawalBold14.copyWith(
                  color: AppColors.subtitle,
                ),
              ),
            ],
          ),
          // Confirm button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: FilledButton(
              onPressed: onConfirm,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.dashPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    context.tr('book_appointment'),
                    style: AppTextStyle.tajawalBold16.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Terms
          SizedBox(
            width: double.infinity,
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: termsText,
                    style: AppTextStyle.tajawalRegular10.copyWith(
                      color: AppColors.subtitle,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
