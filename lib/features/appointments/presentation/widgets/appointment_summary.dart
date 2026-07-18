import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../src/resourses/font_manager/app_text_style.dart';
import '../../../doctors/domain/entities/doctor.dart';

class AppointmentSummary extends StatelessWidget {
  const AppointmentSummary({
    super.key,
    required this.doctor,
    required this.selectedDate,
    required this.selectedTime,
  });

  final Doctor doctor;
  final DateTime? selectedDate;
  final String? selectedTime;

  @override
  Widget build(BuildContext context) {
    final formattedDate = selectedDate == null
        ? context.tr('not_selected')
        : DateFormat.yMMMMd(context.locale.languageCode).format(selectedDate!);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.tr('appointment_summary'), style: AppTextStyle.interBold18),
          const SizedBox(height: 14),
          _SummaryRow(label: context.tr('doctor'), value: context.tr(doctor.name)),
          _SummaryRow(label: context.tr('specialty'), value: context.tr(doctor.specialty)),
          _SummaryRow(label: context.tr('date_label'), value: formattedDate),
          _SummaryRow(
            label: context.tr('time'),
            value: selectedTime ?? context.tr('not_selected'),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: AppTextStyle.interRegular14.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: AppTextStyle.interSemiBold14.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
