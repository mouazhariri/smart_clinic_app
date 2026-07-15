import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../src/application/router/app_routes.dart';
import '../../../../src/resourses/color_manager/app_colors.dart';
import '../../../doctors/presentation/controller/doctors_controller.dart';
import '../controller/home_controller.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/home_search_bar.dart';
import '../widgets/home_specialties_section.dart';
import '../widgets/top_doctors_section.dart';

/// Home dashboard: greeting header, search prompt, specialties and top doctors.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeControllerProvider).value;
    final dashboard = homeState?.homeModel.value;
    final doctors =
        ref.watch(doctorsControllerProvider).value?.doctors.value ?? [];
    final filters = _buildFilters(doctors);

    return Scaffold(
      backgroundColor: AppColors.dashBackground,
      body: Column(
        children: [
          HomeAppBar(
            greeting: '${context.tr('good_morning')},',
            name: context.tr(dashboard?.userNameKey ?? 'sample_user_name'),
            locationHint: context.tr('select_location'),
            onNotificationsTap: () {},
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HomeSearchBar(
                    onTap: () => context.go(AppRoutes.doctorsScreen),
                  ),
                  const SizedBox(height: 24),
                  HomeSpecialtiesSection(
                    onViewAll: () => context.go(AppRoutes.doctorsScreen),
                    onSpecialtyTap: (_) =>
                        context.go(AppRoutes.doctorsScreen),
                  ),
                  const SizedBox(height: 24),
                  TopDoctorsSection(
                    doctors: doctors,
                    filters: filters,
                    onViewAll: () => context.go(AppRoutes.doctorsScreen),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds filter chips from the unique specialties of the loaded doctors.
  static List<DoctorFilter> _buildFilters(List<Doctor> doctors) {
    final seen = <String>{};
    final filters = <DoctorFilter>[];
    for (final doctor in doctors) {
      if (seen.add(doctor.specialty)) {
        filters.add(
          DoctorFilter(
            label: '',
            labelKey: doctor.specialty,
            specialty: doctor.specialty,
          ),
        );
      }
    }
    return filters.take(3).toList();
  }
}
