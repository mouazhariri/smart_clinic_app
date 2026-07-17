import 'package:flutter/material.dart';

import '../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../src/resourses/font_manager/app_text_style.dart';

/// Top bar of the home dashboard: greeting, location hint and quick actions.
class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
    required this.greeting,
    required this.name,
    this.locationHint,
    this.onMenuTap,
    this.onNotificationsTap,
  });

  final String greeting;
  final String name;
  final String? locationHint;
  final VoidCallback? onMenuTap;
  final VoidCallback? onNotificationsTap;

  @override
  Size get preferredSize => const Size.fromHeight(76);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB( 16,75,16,12),
        decoration: const BoxDecoration(
          color: AppColors.white,
          border: Border(
            bottom: BorderSide(color: AppColors.dashHairline, width: 1),
          ),
        ),
        child: Row(
          children: [
            _CircleIconButton(
              icon: Icons.menu_rounded,
              onTap: onMenuTap,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '$greeting ',
                          style: AppTextStyle.tajawalRegular16
                              .copyWith(color: AppColors.dashText),
                        ),
                        TextSpan(
                          text: name,
                          style: AppTextStyle.tajawalBold16
                              .copyWith(color: AppColors.dashText),
                        ),
                      ],
                    ),
                  ),
                  // if (locationHint != null) ...[
                  //   const SizedBox(height: 4),
                  //   Row(
                  //     mainAxisSize: MainAxisSize.min,
                  //     children: [
                  //       Flexible(
                  //         child: Text(
                  //           locationHint!,
                  //           maxLines: 1,
                  //           overflow: TextOverflow.ellipsis,
                  //           style: AppTextStyle.tajawalMedium14
                  //               .copyWith(color: AppColors.dashSubtitle),
                  //         ),
                  //       ),
                  //       const SizedBox(width: 4),
                  //       const Icon(
                  //         Icons.keyboard_arrow_down_rounded,
                  //         size: 18,
                  //         color: AppColors.dashSubtitle,
                  //       ),
                  //     ],
                  //   ),
                  // ],
                ],
              ),
            ),
            const SizedBox(width: 12),
            _CircleIconButton(
              icon: Icons.notifications_none_rounded,
              onTap: onNotificationsTap,
              badge: true,
            ),
          ],
        ),
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({required this.icon, this.onTap, this.badge = false});

  final IconData icon;
  final VoidCallback? onTap;
  final bool badge;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.dashHairline),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(icon, size: 24, color: AppColors.dashText),
            if (badge)
              const Positioned(
                top: 11,
                right: 13,
                child: Icon(Icons.brightness_1, size: 8, color: AppColors.dashPrimary),
              ),
          ],
        ),
      ),
    );
  }
}
