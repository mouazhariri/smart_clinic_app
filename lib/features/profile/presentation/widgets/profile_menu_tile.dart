import 'package:flutter/material.dart';

import '../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../src/resourses/font_manager/app_text_style.dart';

class ProfileMenuTile extends StatelessWidget {
  const ProfileMenuTile({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    this.isDanger = false,
    this.showChevron = true,
  });

  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final bool isDanger;
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    final contentColor = isDanger ? AppColors.errorRed : AppColors.textPrimary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          child: Row(
            // icon -> title -> chevron, auto-mirrored in RTL (Arabic)
            children: [
              Icon(
                icon,
                size: 22,
                color: isDanger ? AppColors.errorRed : AppColors.dashSubtitle,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyle.interSemiBold14.copyWith(color: contentColor),
                ),
              ),
              if (showChevron)
                Icon(
                  Icons.chevron_right_rounded,
                  // matchTextDirection: true, // flips to "<" in Arabic
                  color: AppColors.textSecondary,
                  size: 22,
                ),
            ],
          ),
        ),
      ),
    );
  }
}