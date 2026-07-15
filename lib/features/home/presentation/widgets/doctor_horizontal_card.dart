import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../src/application/router/app_routes.dart';
import '../../../../src/core/shared_widgets/app_cached_network_image.dart';
import '../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../src/resourses/font_manager/app_text_style.dart';
import '../../../doctors/domain/entities/doctor.dart';

/// A compact doctor card used in the home "Top doctors" horizontal list.
///
/// Cleaned up from the Figma export: fixed positioning replaced by a responsive
/// Column layout, and the visual layers split into small private widgets.
class DoctorHorizontalCard extends StatelessWidget {
  const DoctorHorizontalCard({super.key, required this.doctor, this.width = 240});

  final Doctor doctor;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(AppRoutes.doctorDetailsPath(doctor.id)),
      child: Container(
        width: width,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.dashBorder),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 110,
              width: double.infinity,
              child: AppCachedNetworkImage(
                imageUrl: doctor.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _DoctorHeading(doctor: doctor),
                  const SizedBox(height: 8),
                  _DoctorStats(doctor: doctor),
                  const SizedBox(height: 12),
                  const Divider(height: 1, thickness: 1, color: AppColors.dashNeutralBg),
                  const SizedBox(height: 12),
                  _DoctorFooter(doctor: doctor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DoctorHeading extends StatelessWidget {
  const _DoctorHeading({required this.doctor});
  final Doctor doctor;

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
                context.tr(doctor.name),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.tajawalBold14.copyWith(color: AppColors.dashText),
              ),
              const SizedBox(height: 2),
              Text(
                context.tr(doctor.specialty),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.tajawalMedium10
                    .copyWith(color: AppColors.dashSubtitle),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        _LocationChip(text: context.tr(doctor.clinicAddress)),
      ],
    );
  }
}

class _LocationChip extends StatelessWidget {
  const _LocationChip({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.dashNeutralBg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.place_outlined, size: 10, color: AppColors.dashBodyNeutral),
          const SizedBox(width: 2),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 72),
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle.tajawalMedium10
                  .copyWith(color: AppColors.dashBodyNeutral),
            ),
          ),
        ],
      ),
    );
  }
}

class _DoctorStats extends StatelessWidget {
  const _DoctorStats({required this.doctor});
  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.dashHairline),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: _StatColumn(
                value: '${doctor.experienceYears}',
                label: context.tr('experience_short'),
                valueColor: AppColors.dashText,
              ),
            ),
            const VerticalDivider(
              width: 16,
              thickness: 1,
              color: AppColors.dashHairline,
            ),
            Expanded(
              child: _StatColumn(
                value: doctor.rating.toStringAsFixed(1),
                label: context.tr('rating_short'),
                valueColor: AppColors.dashRating,
                prefixIcon: Icons.star_rounded,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  const _StatColumn({
    required this.value,
    required this.label,
    required this.valueColor,
    this.prefixIcon,
  });

  final String value;
  final String label;
  final Color valueColor;
  final IconData? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (prefixIcon != null) ...[
              Icon(prefixIcon, size: 12, color: valueColor),
              const SizedBox(width: 2),
            ],
            Text(
              value,
              style: AppTextStyle.tajawalBold12.copyWith(color: valueColor),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: AppTextStyle.tajawalMedium10.copyWith(color: AppColors.dashSubtitle),
        ),
      ],
    );
  }
}

class _DoctorFooter extends StatelessWidget {
  const _DoctorFooter({required this.doctor});
  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${doctor.consultationFee.toInt()}',
              style: AppTextStyle.tajawalBold18.copyWith(color: AppColors.dashPrimary),
            ),
            Text(
              context.tr('syrian_pound'),
              style: AppTextStyle.tajawalMedium12
                  .copyWith(color: AppColors.dashPlaceholder),
            ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: SizedBox(
            height: 38,
            child: FilledButton(
              onPressed: () =>
                  context.push(AppRoutes.bookAppointmentPath(doctor.id)),
              style: FilledButton.styleFrom(
                padding: EdgeInsets.zero,
                backgroundColor: AppColors.dashPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                context.tr('book'),
                style: AppTextStyle.tajawalBold16.copyWith(color: AppColors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
