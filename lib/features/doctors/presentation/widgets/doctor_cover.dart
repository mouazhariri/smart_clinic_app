import 'package:flutter/material.dart';
import 'package:smart_clinic_app/features/doctors/domain/entities/doctor.dart';
import 'package:smart_clinic_app/src/resourses/color_manager/app_colors.dart';

class DoctorCover extends StatelessWidget {
  final Doctor doctor;
  const DoctorCover({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 240,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            doctor.imageUrl ?? 'https://placehold.co/400x240',
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: AppColors.dashNeutralBg,
              child: const Icon(Icons.person, size: 80, color: AppColors.authHint),
            ),
          ),
          // Soft fade into the white content below
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: IgnorePointer(
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [AppColors.background, AppColors.background.withOpacity(0)],
                  ),
                ),
              ),
            ),
          ),  
        ],
      ),
    );
  }
}