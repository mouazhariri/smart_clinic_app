import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../src/application/router/app_routes.dart';
import '../../../../src/core/shared_widgets/app_cached_network_image.dart';
import '../../../../src/core/shared_widgets/app_loader.dart';
import '../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../src/resourses/font_manager/app_text_style.dart';
import '../controller/doctors_controller.dart';
import '../widgets/doctor_stat_tile.dart';
import '../widgets/smart_clinic_app_bar.dart';

class DoctorDetailsScreen extends ConsumerWidget {
  const DoctorDetailsScreen({super.key, required this.doctorId});

  final String doctorId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doctorAsync = ref.watch(doctorDetailsProvider(doctorId));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: doctorAsync.when(
        loading: () => const Center(child: AppLoader()),
        error: (_, __) => Center(child: Text(context.tr('no_doctors_found'))),
        data: (doctor) => Column(
          children: [
            SmartClinicAppBar(
              title: context.tr('doctor_details'),
              showBackButton: true,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(22),
                            child: AppCachedNetworkImage(
                              imageUrl: doctor.imageUrl,
                              width: 112,
                              height: 132,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  context.tr(doctor.name),
                                  style: AppTextStyle.interBold20.copyWith(
                                    color: AppColors.white,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  context.tr(doctor.specialty),
                                  style: AppTextStyle.interRegular14.copyWith(
                                    color: AppColors.white.withOpacity(.84),
                                  ),
                                ),
                                const SizedBox(height: 18),
                                Row(
                                  children: [
                                    const Icon(Icons.location_on_outlined,
                                        color: AppColors.white, size: 18),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        context.tr(doctor.clinicAddress),
                                        style: AppTextStyle.interRegular12.copyWith(
                                          color: AppColors.white.withOpacity(.84),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        DoctorStatTile(
                          value: '${doctor.experienceYears}+',
                          label: context.tr('years_experience'),
                          icon: Icons.work_outline_rounded,
                        ),
                        const SizedBox(width: 10),
                        DoctorStatTile(
                          value: '${doctor.patientsCount}+',
                          label: context.tr('patients'),
                          icon: Icons.groups_outlined,
                        ),
                        const SizedBox(width: 10),
                        DoctorStatTile(
                          value: doctor.rating.toStringAsFixed(1),
                          label: context.tr('rating'),
                          icon: Icons.star_outline_rounded,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(context.tr('about_doctor'), style: AppTextStyle.interBold18),
                    const SizedBox(height: 10),
                    Text(
                      context.tr(doctor.about),
                      style: AppTextStyle.interRegular14.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: FilledButton(
                        onPressed: () => context.push(AppRoutes.bookAppointmentPath(doctor.id)),
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        child: Text(context.tr('book_appointment')),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
