import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smart_clinic_app/src/resourses/font_manager/app_text_style.dart';

import '../../../../src/resourses/color_manager/app_colors.dart';
import '../../../doctors/domain/entities/doctor.dart';



const String _font = 'Tajawal';

class DoctorHorizontalCard extends StatelessWidget {
  const DoctorHorizontalCard({
    super.key,
    required this.doctor,
    this.onTap,
    this.onBook,
  });

  final Doctor doctor;
  final VoidCallback? onTap;
  final VoidCallback? onBook;

  @override
  Widget build(BuildContext context) {
    final location = doctor.location;
    final hasLocation = location != null && location.trim().isNotEmpty;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildBanner(),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Name + specialty (right) | location chip (left)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              doctor.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: _font,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.dark,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              context.tr(doctor.specialty),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: _font,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: AppColors.subtitle,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (hasLocation) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            // horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.chipBg,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            location!,
                            style: const TextStyle(
                              fontFamily: _font,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: AppColors.chipText,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Experience | Rating box
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.innerBorder),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: _StatCell(
                            value: '${doctor.experienceYears} ${context.tr('years')}',
                            label: context.tr('experience'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          width: 1,
                          height: 24,
                          color: AppColors.innerBorder,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _StatCell(
                            value: (doctor.rating ?? 0).toStringAsFixed(1),
                            label: context.tr('rating'),
                            valueColor: AppColors.warning,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Divider
                  Container(height: 1, color: AppColors.divider),
                  const SizedBox(height: 16),

                  // Price (right) | Book button (left)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doctor.price.toString(),
                            style: TextStyle(
                              fontFamily: _font,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            context.tr('syp'),
                            style: const TextStyle(
                              fontFamily: _font,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.placeholder,
                            ),
                          ),
                        ],
                      ),
                      // const SizedBox(width: 12),
                      InkWell(
                        onTap: onBook,
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          height: 40,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 4,horizontal: 50),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            context.tr('book'),
                            style: const TextStyle(
                              fontFamily: _font,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
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
    );
  }

  Widget _buildBanner() {
    final url = doctor.imageUrl;
    if (url == null || url.isEmpty) {
      return Container(
        height: 80,
        color: AppColors.border,
        alignment: Alignment.center,
        child: const Icon(Icons.person, color: Colors.white, size: 32),
      );
    }
    return Image.network(
      url,
      width: double.infinity,
      height: 100,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => Container(
        height: 80,
        color: AppColors.border,
        alignment: Alignment.center,
        child: const Icon(Icons.person, color: Colors.white, size: 32),
      ),
    );
  }
}

class _StatCell extends StatelessWidget {
  const _StatCell({
    required this.value,
    required this.label,
    this.valueColor = AppColors.dark,
  });

  final String value;
  final String label;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          value,
          textAlign: TextAlign.center,
          style:AppTextStyle.interBold12.copyWith(
            color: valueColor,

          ) 
          // TextStyle(
          //   fontFamily: _font,
          //   fontSize: 12,
          //   fontWeight: FontWeight.w800,
          // ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: _font,
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: AppColors.subtitle,
          ),
        ),
      ],
    );
  }
}