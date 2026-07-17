import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../../src/resourses/font_manager/app_text_style.dart';
import '../../domain/entities/doctor.dart';

class DoctorHeader extends StatelessWidget {
  final Doctor doctor;
  const DoctorHeader({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                doctor.name,
                style: AppTextStyle.tajawalBold18.copyWith(
                  fontSize: 20, color: AppColors.authTitle,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                doctor.specialty,
                style: AppTextStyle.tajawalRegular14.copyWith(
                  color: AppColors.authSubtitle,
                ),
              ),
            ],
          ),
        ),
        if (doctor.experienceYears != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.primary.withOpacity(0.3)),
            ),
            child: Text(
              context.tr('years_experience', args: ['${doctor.experienceYears}']),
              style: AppTextStyle.tajawalRegular12.copyWith(
                fontWeight: FontWeight.w600, color: AppColors.primary,
              ),
            ),
          ),
      ],
    );
  }
}