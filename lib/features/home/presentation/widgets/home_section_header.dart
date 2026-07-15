import 'package:flutter/material.dart';

import '../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../src/resourses/font_manager/app_text_style.dart';

/// A section title with an optional "view all" action, right-aligned for RTL.
class HomeSectionHeader extends StatelessWidget {
  const HomeSectionHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onAction,
    this.useExtraBold = false,
  });

  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;
  final bool useExtraBold;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: (useExtraBold
                    ? AppTextStyle.tajawalExtraBold17
                    : AppTextStyle.tajawalBold20)
                .copyWith(color: AppColors.dashText),
          ),
        ),
        if (actionLabel != null)
          GestureDetector(
            onTap: onAction,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              child: Text(
                actionLabel!,
                style: AppTextStyle.tajawalMedium13
                    .copyWith(color: AppColors.dashSubtitle, height: 1.5),
              ),
            ),
          ),
      ],
    );
  }
}
