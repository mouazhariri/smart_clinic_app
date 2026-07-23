import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../src/resourses/font_manager/app_text_style.dart';
import '../../domain/entities/profile_menu_item.dart';
import '../../domain/entities/profile_menu_section.dart';
import 'profile_menu_tile.dart';

class ProfileMenuSectionWidget extends StatelessWidget {
  const ProfileMenuSectionWidget({
    super.key,
    required this.section,
    required this.onItemTap,
  });

  final ProfileMenuSection section;
  final ValueChanged<ProfileMenuItem> onItemTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 4, bottom: 10),
          child: Text(
            context.tr(section.titleKey),
            style: AppTextStyle.interMedium12.copyWith(color: AppColors.textSecondary),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: const [
              BoxShadow(color: AppColors.homeShadow, blurRadius: 10, offset: Offset(0, 3)),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              for (var i = 0; i < section.items.length; i++) ...[
                ProfileMenuTile(
                  icon: section.items[i].icon,
                  title: context.tr(section.items[i].titleKey),
                  isDanger: section.items[i].isDanger,
                  showChevron: section.items[i].showChevron,
                  onTap: () => onItemTap(section.items[i]),
                ),
                if (i != section.items.length - 1)
                  const Padding(
                    padding: EdgeInsetsDirectional.only(start: 18, end: 18),
                    child: Divider(height: 1, thickness: 1, color: AppColors.divider),
                  ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}