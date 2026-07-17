import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../../src/resourses/font_manager/app_text_style.dart';
import '../../domain/entities/doctor.dart';

class DoctorMetrics extends StatelessWidget {
  final Doctor doctor;
  const   DoctorMetrics({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    // Derived test metric (entity has no satisfaction field)
    final int satisfaction =
        (((doctor.rating ?? 4.9) * 20).round()).clamp(0, 100);

    return Row(
      children: [
        Expanded(
          child: _StatCard(
            icon: Icons.favorite_outline,
            iconColor: AppColors.green,
            value: '$satisfaction%',
            label: context.tr('satisfaction_rate'),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _StatCard(
            icon: Icons.star_border_rounded,
            iconColor: AppColors.ratingYellow,
            value: (doctor.rating ?? 0).toStringAsFixed(1),
            label: context.tr('reviews_count', args: ['${doctor.reviewsCount}']),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _StatCard(
            icon: Icons.people_outline_rounded,
            iconColor: AppColors.primary,
            value: '+${doctor.patientsCount}',
            label: context.tr('patients'),
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;
  const _StatCard({
    required this.icon, required this.iconColor,
    required this.value, required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
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
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.15), shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(height: 8),
          Text(value,
              style: AppTextStyle.tajawalBold16.copyWith(color: AppColors.authTitle)),
          const SizedBox(height: 2),
          Text(label,
              textAlign: TextAlign.center, maxLines: 2,
              style: AppTextStyle.tajawalRegular12.copyWith(
                  fontSize: 11, color: AppColors.authSubtitle)),
        ],
      ),
    );
  }
}