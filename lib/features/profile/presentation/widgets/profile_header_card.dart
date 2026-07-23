import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../src/resourses/font_manager/app_text_style.dart';
import '../../domain/entities/user_profile.dart';

class ProfileHeaderCard extends StatelessWidget {
  const ProfileHeaderCard({
    super.key,
    required this.profile,
    required this.isLoading,
  });

  final UserProfile? profile;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final name = (profile?.fullName.isNotEmpty ?? false)
        ? profile!.fullName
        : context.tr('sample_user_full_name');
    final phone = (profile?.phoneNumber?.isNotEmpty ?? false)
        ? profile!.phoneNumber!
        : context.tr('sample_user_phone');

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        // Row mirrors automatically in RTL (Arabic): avatar moves to the
        // right, text block to the left with right-aligned text — exactly
        // like the screenshot. No manual left/right handling needed.
        children: [
          Container(
            width: 56,
            height: 56,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.white, width: 2),
              color: AppColors.white.withOpacity(0.2),
              image: (profile?.avatarUrl?.isNotEmpty ?? false)
                  ? DecorationImage(image: NetworkImage(profile!.avatarUrl!), fit: BoxFit.cover)
                  : null,
            ),
            child: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.white),
                  )
                : (profile?.avatarUrl?.isNotEmpty ?? false)
                    ? null
                    : const Icon(Icons.person, color: AppColors.white, size: 28),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTextStyle.interBold18.copyWith(color: AppColors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  phone,
                  style: AppTextStyle.interRegular12.copyWith(color: AppColors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}