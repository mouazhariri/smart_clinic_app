import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../src/application/router/app_routes.dart';
import '../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../src/resourses/font_manager/app_text_style.dart';
import '../../../appointments/presentation/controller/appointments_controller.dart';
import '../../../appointments/presentation/widgets/appointment_card_widget.dart';
import '../../../doctors/presentation/controller/doctors_controller.dart';
import '../controller/home_controller.dart';
import '../../../doctors/presentation/widgets/doctor_card_widget.dart';
import '../../../doctors/presentation/widgets/smart_clinic_app_bar.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeControllerProvider);
    final dashboard = homeState.dashboard;
    final doctorsState = ref.watch(doctorsControllerProvider);
    final appointmentState = ref.watch(appointmentsControllerProvider);
    final nextAppointment = appointmentState.upcomingAppointments.isEmpty
        ? null
        : appointmentState.upcomingAppointments.first;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          SmartClinicAppBar(
            title: '${context.tr('hello')}, ${context.tr(dashboard?.userNameKey ?? 'sample_user_name')}',
            subtitle: context.tr('home_subtitle'),
            trailing: IconButton.filled(
              style: IconButton.styleFrom(backgroundColor: AppColors.white),
              onPressed: () {},
              icon: const Icon(Icons.notifications_none_rounded, color: AppColors.textPrimary),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.primary, AppColors.secondPrimary],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.tr(dashboard?.bannerTitleKey ?? 'healthcare_made_easy'),
                          style: AppTextStyle.interBold22.copyWith(color: AppColors.white),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          context.tr(dashboard?.bannerDescriptionKey ?? 'healthcare_made_easy_desc'),
                          style: AppTextStyle.interRegular14.copyWith(
                            color: AppColors.white.withOpacity(.86),
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 18),
                        FilledButton(
                          onPressed: () => context.go(AppRoutes.doctorsScreen),
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.white,
                            foregroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(context.tr('find_doctor')),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  _SectionHeader(
                    title: context.tr('next_appointment'),
                    actionLabel: context.tr('see_all'),
                    onTap: () => context.go(AppRoutes.appointmentsScreen),
                  ),
                  const SizedBox(height: 12),
                  if (nextAppointment == null)
                    _EmptyCard(message: context.tr('no_upcoming_appointments'))
                  else
                    AppointmentCardWidget(appointment: nextAppointment),
                  const SizedBox(height: 24),
                  _SectionHeader(
                    title: context.tr('top_doctors'),
                    actionLabel: context.tr('see_all'),
                    onTap: () => context.go(AppRoutes.doctorsScreen),
                  ),
                  const SizedBox(height: 12),
                  ...doctorsState.doctors.take(2).map(
                        (doctor) => Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: DoctorCardWidget(doctor: doctor),
                        ),
                      ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.actionLabel,
    required this.onTap,
  });

  final String title;
  final String actionLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(title, style: AppTextStyle.interBold18)),
        TextButton(onPressed: onTap, child: Text(actionLabel)),
      ],
    );
  }
}

class _EmptyCard extends StatelessWidget {
  const _EmptyCard({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: AppTextStyle.interRegular14.copyWith(color: AppColors.textSecondary),
      ),
    );
  }
}
