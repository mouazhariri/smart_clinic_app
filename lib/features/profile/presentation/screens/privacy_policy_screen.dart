import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../src/resourses/font_manager/app_text_style.dart';
import '../../../doctors/presentation/widgets/smart_clinic_app_bar.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  static const int _sectionsCount = 6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          SmartClinicAppBar(
            title: context.tr('privacy_policy'),
            subtitle: context.tr('privacy_policy_subtitle'),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(24)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.tr('privacy_policy_last_updated'),
                        style: AppTextStyle.interRegular12.copyWith(color: AppColors.textSecondary),
                      ),
                      const SizedBox(height: 16),
                      for (var i = 1; i <= _sectionsCount; i++) ...[
                        Text(context.tr('privacy_policy_section_${i}_title'), style: AppTextStyle.interSemiBold16),
                        const SizedBox(height: 8),
                        Text(
                          context.tr('privacy_policy_section_${i}_body'),
                          style: AppTextStyle.interRegular14.copyWith(color: AppColors.textSecondary, height: 1.6),
                        ),
                        if (i != _sectionsCount) const SizedBox(height: 20),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}