import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../src/resourses/font_manager/app_text_style.dart';
import '../../../doctors/presentation/widgets/smart_clinic_app_bar.dart';

class TermsPrivacyScreen extends StatelessWidget {
  const TermsPrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Column(
          children: [
            SmartClinicAppBar(
              showBackButton: true,
              title: context.tr('terms_and_privacy'),
              subtitle: context.tr('terms_and_privacy_subtitle'),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: TabBar(
                indicator: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                labelPadding: EdgeInsets.symmetric(horizontal: 2),
                // padding: EdgeInsets.symmetric(horizontal: 0),
                indicatorPadding: EdgeInsetsGeometry.symmetric(horizontal: -12),
                labelColor: AppColors.white,
                unselectedLabelColor: AppColors.textSecondary,
                labelStyle: AppTextStyle.interSemiBold14,
                dividerColor: Colors.transparent,
                tabs: [
                  Tab(text: context.tr('terms_conditions')),
                  Tab(text: context.tr('privacy_policy')),
                ],
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  _PolicyList(prefix: 'terms_section', count: 4),
                  _PolicyList(prefix: 'privacy_policy_section', count: 6),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PolicyList extends StatelessWidget {
  const _PolicyList({required this.prefix, required this.count});

  final String prefix;
  final int count;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 1; i <= count; i++) ...[
                Text(
                  context.tr('${prefix}_${i}_title'),
                  style: AppTextStyle.interSemiBold16,
                ),
                const SizedBox(height: 8),
                Text(
                  context.tr('${prefix}_${i}_body'),
                  style: AppTextStyle.interRegular14.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.6,
                  ),
                ),
                if (i != count) const SizedBox(height: 20),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
