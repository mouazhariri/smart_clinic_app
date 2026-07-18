import 'package:flutter/material.dart';

import '../../../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../../../src/resourses/font_manager/app_text_style.dart';

/// Progress header shown at the top of every signup step.
///
/// Displays the step [title], [subtitle], a progress bar at [progress], and the
/// textual [stepLabel] (e.g. "Step 2 of 3").
class SignupProgressHeader extends StatelessWidget {
  const SignupProgressHeader({
    super.key,
    required this.stepLabel,
    required this.progress,
    required this.title,
    required this.subtitle,
  });

  final String stepLabel;
  final double progress;
  final String title;
  final String subtitle;

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                   Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.end,
                      style: AppTextStyle.rubikBold22.copyWith(
                        color: AppColors.authTitle,
                        fontSize: 19,
                        height: 1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      textAlign: TextAlign.end,
                      style: AppTextStyle.rubikRegular12.copyWith(
                        color: AppColors.authSubtitle,
                      ),
                    ),
                  ],
                ),
              ),
         
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.authFlagPlaceholder,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.person_outline,
                  color: AppColors.authIcon,
                  size: 24,
                ),
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
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppColors.primary),
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
