import 'package:flutter/material.dart';

import '../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../src/resourses/font_manager/app_text_style.dart';

/// Clean doctor info banner for booking screens.
class DoctorInfoBanner extends StatelessWidget {
  const DoctorInfoBanner({
    super.key,
    required this.name,
    required this.specialty,
    required this.imageUrl,
  });

  final String name;
  final String specialty;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.innerBorder, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 16,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  textAlign: TextAlign.right,
                  style: AppTextStyle.tajawalBold16.copyWith(
                    color: AppColors.dark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  specialty,
                  textAlign: TextAlign.right,
                  style: AppTextStyle.tajawalRegular12.copyWith(
                    color: AppColors.subtitle,
                  ),
                ),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.network(
              imageUrl,
              width: 40,
              height: 40,
              fit: BoxFit.fill,
              errorBuilder: (_, __, ___) => Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.dashBackground,
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
