import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../../src/resourses/font_manager/app_text_style.dart';
import '../../domain/entities/doctor.dart';

class DoctorClinicCard extends StatelessWidget {
  final Doctor doctor;
  const DoctorClinicCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.tr('clinic_info'),
            style: AppTextStyle.tajawalBold16.copyWith(color: AppColors.authTitle)),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            // boxShadow: [
            //   BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10,
            //       offset: const Offset(0, 3)),
            // ],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 40, height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.location_on_outlined,
                          color: AppColors.primary, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // clinicAddress holds the clinic NAME in current data
                          Text(doctor.clinicAddress,
                              style: AppTextStyle.tajawalBold14.copyWith(
                                  color: AppColors.authTitle)),
                          if ((doctor.location ?? '').isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text(doctor.location!,
                                style: AppTextStyle.tajawalRegular12.copyWith(
                                    color: AppColors.authSubtitle, height: 1.5)),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, color: AppColors.dashNeutralBg),
              // ✅ Map placeholder (test data – no map integration yet)
              _MapPlaceholder(
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(context.tr('map_coming_soon'))),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MapPlaceholder extends StatelessWidget {
  final VoidCallback onTap;
  const _MapPlaceholder({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
        child: Container(
          height: 150,
          width: double.infinity,
          color: AppColors.dashNeutralBg,
          child: Stack(
            children: [
              Center(
                child: Icon(Icons.map_outlined,
                    size: 70, color: AppColors.authHint.withOpacity(0.35)),
              ),
              const Center(
                child: Icon(Icons.location_on, color: AppColors.primary, size: 34),
              ),
              Positioned(
                bottom: 10, right: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.open_in_new, size: 14, color: AppColors.primary),
                      const SizedBox(width: 4),
                      Text(context.tr('map_preview'),
                          style: AppTextStyle.tajawalRegular12.copyWith(
                              fontWeight: FontWeight.w600, color: AppColors.primary)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}