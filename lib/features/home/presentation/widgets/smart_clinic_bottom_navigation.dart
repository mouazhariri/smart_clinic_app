import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../src/application/router/app_routes.dart';
import '../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../src/resourses/font_manager/app_text_style.dart';

/// Professional bottom navigation bar for the main scaffold.
///
/// A custom (non-Material `NavigationBar`) implementation for full control over
/// the active indicator, typography and spacing. Items are declarative so the
/// bar stays open for extension (OCP) without touching the build method.
class SmartClinicBottomNavigation extends StatelessWidget {
  const SmartClinicBottomNavigation({super.key, required this.currentIndex});

  final int currentIndex;

  static const List<_Destination> _destinations = [
    _Destination(
      route: AppRoutes.homeScreen,
      labelKey: 'nav_home',
      icon: Icons.home_outlined,
      activeIcon: Icons.home_rounded,
    ),
    _Destination(
      route: AppRoutes.doctorsScreen,
      labelKey: 'doctors',
      icon: Icons.medical_services_outlined,
      activeIcon: Icons.medical_services_rounded,
    ),
    _Destination(
      route: AppRoutes.appointmentsScreen,
      labelKey: 'appointments',
      icon: Icons.calendar_month_outlined,
      activeIcon: Icons.calendar_month_rounded,
    ),
    _Destination(
      route: AppRoutes.profileScreen,
      labelKey: 'profile',
      icon: Icons.person_outline_rounded,
      activeIcon: Icons.person_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        border: Border(top: BorderSide(color: AppColors.dashBorder, width: 1)),
        boxShadow: [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 16,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            children: [
              for (var i = 0; i < _destinations.length; i++)
                Expanded(
                  child: _NavItem(
                    destination: _destinations[i],
                    selected: i == currentIndex,
                    onTap: () => context.go(_destinations[i].route),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Destination {
  const _Destination({
    required this.route,
    required this.labelKey,
    required this.icon,
    required this.activeIcon,
  });

  final String route;
  final String labelKey;
  final IconData icon;
  final IconData activeIcon;
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.destination,
    required this.selected,
    required this.onTap,
  });

  final _Destination destination;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color =
        selected ? AppColors.dashPrimary : AppColors.dashPlaceholder;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
              decoration: BoxDecoration(
                color: selected ? AppColors.dashPrimaryBg : Colors.transparent,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Icon(
                selected ? destination.activeIcon : destination.icon,
                size: 22,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              context.tr(destination.labelKey),
              style: AppTextStyle.tajawalMedium12.copyWith(
                color: color,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
