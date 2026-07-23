import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_clinic_app/features/appointments/presentation/controller/appointment_controller.dart';
import 'package:smart_clinic_app/features/doctors/domain/entities/doctor.dart';

import '../../../../src/application/router/app_routes.dart';
import '../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../src/resourses/font_manager/app_text_style.dart';
import '../../../appointments/domain/model/appointment.dart';
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
            final nearestAppointment = ref.watch(nearestAppointmentProvider);

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

     const SizedBox(height: 20),

                  // ── Nearest Appointment Card ─────────────────────
                  if (nearestAppointment != null) ...[
                    _NearestAppointmentCard(
                      appointment: nearestAppointment,
                    ),
                    const SizedBox(height: 24),
                  ],
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
class _NearestAppointmentCard extends StatelessWidget {
  final Appointment appointment;
  const _NearestAppointmentCard({required this.appointment});

  @override
  Widget build(BuildContext context) {
    final locale = context.locale.languageCode;
    final formattedDate =
        DateFormat('d MMMM', locale).format(appointment.date);

    return GestureDetector(
      onTap: () => context.push(
        AppRoutes.appointmentTrackingScreen,
        extra: appointment.id,
      ),
      child: Container(
        decoration: BoxDecoration(
          // Blue gradient matching screenshot
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primary,
              AppColors.primary.withOpacity(0.82),
            ],
          ),
          borderRadius: BorderRadius.circular(18),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Title row ──────────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.tr('next_appointment'),
                  style: AppTextStyle.tajawalBold16.copyWith(
                    color: Colors.white,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _statusLabel(context, appointment.status),
                    style: AppTextStyle.tajawalRegular12.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // ── Date + Time pills ──────────────────────────────────
            Row(
              children: [
                _WhitePill(
                  icon: Icons.access_time_outlined,
                  label: appointment.time,
                ),
                const SizedBox(width: 10),
                _WhitePill(
                  icon: Icons.calendar_today_outlined,
                  label: formattedDate,
                ),
              ],
            ),
            const SizedBox(height: 14),

            // ── Doctor row ─────────────────────────────────────────
            Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundImage: appointment.doctorImageUrl != null
                      ? NetworkImage(appointment.doctorImageUrl!)
                      : null,
                  backgroundColor: Colors.white.withOpacity(0.3),
                  child: appointment.doctorImageUrl == null
                      ? const Icon(Icons.person,
                          color: Colors.white, size: 20)
                      : null,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appointment.doctorName,
                        style: AppTextStyle.tajawalBold14.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        appointment.doctorSpecialty,
                        style: AppTextStyle.tajawalRegular12.copyWith(
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),

                // Phone icon
                if (appointment.phoneNumber != null)
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.phone_outlined,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _statusLabel(BuildContext context, AppointmentStatus status) {
    switch (status) {
      case AppointmentStatus.confirmed:
        return context.tr('status_confirmed');
      case AppointmentStatus.waiting:
        return context.tr('status_waiting');
      case AppointmentStatus.inClinic:
        return context.tr('status_in_clinic');
      case AppointmentStatus.completed:
        return context.tr('status_completed');
      case AppointmentStatus.cancelled:
        return context.tr('status_cancelled');
    }
  }
}

class _WhitePill extends StatelessWidget {
  final IconData icon;
  final String label;
  const _WhitePill({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 14),
          const SizedBox(width: 6),
          Text(
            label,
            style: AppTextStyle.tajawalSemiBold14.copyWith(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}