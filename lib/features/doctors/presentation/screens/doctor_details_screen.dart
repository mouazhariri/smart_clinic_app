import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';

import '../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../src/resourses/font_manager/app_text_style.dart';
import '../../domain/entities/doctor.dart';
import '../widgets/doctor_cover.dart';
import '../widgets/doctor_header.dart';
import '../widgets/doctor_metrics.dart';
import '../widgets/doctor_about.dart';
import '../widgets/doctor_clinic_card.dart';
import '../widgets/doctor_working_hours.dart';
import '../widgets/doctor_bottom_bar.dart';
import '../widgets/doctor_popup_menu.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_clinic_app/src/resourses/color_manager/app_colors.dart';
import 'package:smart_clinic_app/src/resourses/font_manager/app_text_style.dart';


class DoctorDetailsScreen extends StatelessWidget {
  final Doctor doctor;

  const DoctorDetailsScreen({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        // RTL: leading (start) = back arrow on the right
        leading: IconButton(
          icon:  Icon(Icons.arrow_back_ios, color: AppColors.authTitle),
          onPressed: () => context.pop(),
        ),
        title: Text(
          context.tr('doctor_profile'),
          style: AppTextStyle.tajawalBold18.copyWith(color: AppColors.authTitle),
        ),
        centerTitle: true,
        // RTL: actions (end) = popup menu on the left
        actions: [DoctorPopupMenu(doctor: doctor)],
      ),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: DoctorCover(doctor: doctor)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DoctorHeader(doctor: doctor),
                      const SizedBox(height: 20),
                      DoctorMetrics(doctor: doctor),
                      const SizedBox(height: 20),
                      DoctorAboutSection(doctor: doctor),
                      const SizedBox(height: 20),
                      DoctorClinicCard(doctor: doctor),
                      const SizedBox(height: 20),
                      DoctorWorkingHours(doctor: doctor),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Fixed booking bar (never scrolls away)
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: DoctorBottomBar(doctor: doctor),
          ),
        ],
      ),
    );
  }
}