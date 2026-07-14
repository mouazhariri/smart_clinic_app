import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../src/application/router/app_routes.dart';
import '../../../../src/resourses/color_manager/app_colors.dart';

class SmartClinicBottomNavigation extends StatelessWidget {
  const SmartClinicBottomNavigation({super.key, required this.currentIndex});

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentIndex,
      backgroundColor: AppColors.white,
      indicatorColor: AppColors.primaryBg,
      onDestinationSelected: (index) {
        switch (index) {
          case 0:
            return context.go(AppRoutes.homeScreen);
          case 1:
            return context.go(AppRoutes.doctorsScreen);
          case 2:
            return context.go(AppRoutes.appointmentsScreen);
          case 3:
            return context.go(AppRoutes.profileScreen);
        }
      },
      destinations: [
        NavigationDestination(
          icon: const Icon(Icons.home_outlined),
          selectedIcon: const Icon(Icons.home),
          label: context.tr('nav_home'),
        ),
        NavigationDestination(
          icon: const Icon(Icons.medical_services_outlined),
          selectedIcon: const Icon(Icons.medical_services),
          label: context.tr('doctors'),
        ),
        NavigationDestination(
          icon: const Icon(Icons.calendar_month_outlined),
          selectedIcon: const Icon(Icons.calendar_month),
          label: context.tr('appointments'),
        ),
        NavigationDestination(
          icon: const Icon(Icons.person_outline),
          selectedIcon: const Icon(Icons.person),
          label: context.tr('profile'),
        ),
      ],
    );
  }
}
