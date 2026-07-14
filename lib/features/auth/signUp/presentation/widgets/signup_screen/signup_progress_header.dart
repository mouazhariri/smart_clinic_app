import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../../../src/resourses/font_manager/app_text_style.dart';

class SignupProgressHeader extends StatelessWidget {
  const SignupProgressHeader({
    super.key,
    required this.stepLabel,
    required this.progress,
  });

  final String stepLabel;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 18),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                color: AppColors.authFlagPlaceholder,
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    context.tr('personal_info_title'),
                    style: AppTextStyle.rubikBold22.copyWith(
                      color: AppColors.authTitle,
                      fontSize: 19,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    context.tr('personal_info_subtitle'),
                    style: AppTextStyle.rubikRegular12.copyWith(
                      color: AppColors.authSubtitle,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 4,
              backgroundColor: AppColors.authDivider,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            stepLabel,
            style: AppTextStyle.interRegular10.copyWith(color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}
