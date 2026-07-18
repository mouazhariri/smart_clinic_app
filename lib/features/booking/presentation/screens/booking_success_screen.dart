import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:smart_clinic_app/src/resourses/color_manager/app_colors.dart';
import 'package:smart_clinic_app/src/resourses/font_manager/app_text_style.dart';

import '../../../../src/application/router/app_routes.dart';
import '../../../doctors/domain/entities/doctor.dart';

class BookingSuccessScreen extends StatelessWidget {
  final Doctor doctor;
  final DateTime selectedDate;
  final String selectedTime;
  final String appointmentNumber;

  const BookingSuccessScreen({
    super.key,
    required this.doctor,
    required this.selectedDate,
    required this.selectedTime,
    this.appointmentNumber = '#9874',
  });

  @override
  Widget build(BuildContext context) {
    // Split date and time for separate rows (matching screenshot)
    final locale = context.locale.languageCode;
    final formattedDate =
        DateFormat('EEEE, d MMMM', locale).format(selectedDate);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 40),

              // ── Success icon ──────────────────────────────────────
              _SuccessIcon(),
              const SizedBox(height: 24),

              // ── Title ─────────────────────────────────────────────
              Text(
                context.tr('booking_confirmed'),
                style: AppTextStyle.tajawalBold20.copyWith(
                  color: AppColors.authTitle,
                  fontSize: 22,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),

              // ── Subtitle ──────────────────────────────────────────
              Text(
                context.tr('sms_sent'),
                style: AppTextStyle.tajawalRegular14.copyWith(
                  color: AppColors.authSubtitle,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // ── Appointment card ──────────────────────────────────
              _AppointmentCard(
                doctor: doctor,
                formattedDate: formattedDate,
                selectedTime: selectedTime,
                appointmentNumber: appointmentNumber,
              ),

              const Spacer(),

              // ── Action buttons ────────────────────────────────────
              _ActionButtons(
                onViewAppointment: () {},
                onAddToCalendar: () {},
                onBackToHome: () => context.go(AppRoutes.homeScreen),
                context: context,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
// SUCCESS ICON  — teal circle with history/clock-check icon
// ════════════════════════════════════════════════════════════════════════════
class _SuccessIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 110,
      decoration: BoxDecoration(
        // Teal/green matching the screenshot
        color: const Color(0xFF2BAE8E),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2BAE8E).withOpacity(0.25),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: const Icon(
        Icons.history_toggle_off_rounded,
        color: Colors.white,
        size: 52,
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
// APPOINTMENT CARD
// ════════════════════════════════════════════════════════════════════════════
class _AppointmentCard extends StatelessWidget {
  final Doctor doctor;
  final String formattedDate;
  final String selectedTime;
  final String appointmentNumber;

  const _AppointmentCard({
    required this.doctor,
    required this.formattedDate,
    required this.selectedTime,
    required this.appointmentNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE8E8E8)),
      ),
      child: Column(
        children: [
          // ── Doctor row ───────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Name + specialty (LTR: on the LEFT)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctor.name,
                        style: AppTextStyle.tajawalBold16.copyWith(
                          color: AppColors.authTitle,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        doctor.specialty,
                        style: AppTextStyle.tajawalRegular14.copyWith(
                          color: AppColors.authSubtitle,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),

                // Doctor image (LTR: on the RIGHT)
                CircleAvatar(
                  radius: 26,
                  backgroundImage: doctor.imageUrl != null
                      ? NetworkImage(doctor.imageUrl!)
                      : null,
                  backgroundColor: AppColors.dashNeutralBg,
                  child: doctor.imageUrl == null
                      ? const Icon(
                          Icons.person,
                          color: AppColors.authHint,
                          size: 26,
                        )
                      : null,
                ),
              ],
            ),
          ),

          // ── Dashed divider ───────────────────────────────────────
          const _DashedLine(),

          // ── Detail rows ──────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Date row
                _DetailRow(
                  icon: Icons.calendar_today_outlined,
                  label: context.tr('date'),
                  value: formattedDate,
                ),
                const SizedBox(height: 14),

                // Time row
                _DetailRow(
                  icon: Icons.access_time_outlined,
                  label: context.tr('time'),
                  value: selectedTime,
                ),
                const SizedBox(height: 14),

                // Appointment number row
                _DetailRow(
                  icon: Icons.tag_outlined,
                  label: context.tr('appointment_number'),
                  value: appointmentNumber,
                  valueColor: AppColors.primary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
// DETAIL ROW  — label+icon on LEFT, value on RIGHT (LTR)
// ════════════════════════════════════════════════════════════════════════════
class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Label + icon on the LEFT
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: AppColors.authSubtitle,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: AppTextStyle.tajawalRegular14.copyWith(
                color: AppColors.authSubtitle,
              ),
            ),
          ],
        ),

        // Value on the RIGHT
        Text(
          value,
          style: AppTextStyle.tajawalSemiBold14.copyWith(
            color: valueColor ?? AppColors.authTitle,
          ),
        ),
      ],
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
// DASHED LINE  — matches the dashed separator in the screenshot
// ════════════════════════════════════════════════════════════════════════════
class _DashedLine extends StatelessWidget {
  const _DashedLine();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      const dashW = 8.0;
      const gapW = 5.0;
      final count = (constraints.maxWidth / (dashW + gapW)).floor();
      return Row(
        children: List.generate(
          count,
          (_) => Padding(
            padding: const EdgeInsets.only(right: gapW),
            child: Container(
              width: dashW,
              height: 1.2,
              color: const Color(0xFFDDDDDD),
            ),
          ),
        ),
      );
    });
  }
}

// ════════════════════════════════════════════════════════════════════════════
// ACTION BUTTONS
// ════════════════════════════════════════════════════════════════════════════
class _ActionButtons extends StatelessWidget {
  final VoidCallback onViewAppointment;
  final VoidCallback onAddToCalendar;
  final VoidCallback onBackToHome;
  final BuildContext context;

  const _ActionButtons({
    required this.onViewAppointment,
    required this.onAddToCalendar,
    required this.onBackToHome,
    required this.context,
  });

  @override
  Widget build(BuildContext ctx) {
    return Column(
      children: [
        // ── Primary blue button ──────────────────────────────────
        SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton(
            onPressed: onViewAppointment,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: Text(
              context.tr('view_appointment'),
              style: AppTextStyle.tajawalBold16.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),

        // ── Outlined grey button ─────────────────────────────────
        SizedBox(
          width: double.infinity,
          height: 54,
          child: OutlinedButton(
            onPressed: onAddToCalendar,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFFDDDDDD)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: Text(
              context.tr('add_to_calendar'),
              style: AppTextStyle.tajawalBold16.copyWith(
                color: AppColors.authTitle,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),

        // ── Dark "back to home" button — matches screenshot ──────
        SizedBox(
          width: double.infinity,
          height: 54,
          child: OutlinedButton(
            onPressed: onBackToHome,
            style: OutlinedButton.styleFrom(
              backgroundColor: const Color(0xFF1A1A2E),
              side: BorderSide.none,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: Text(
              context.tr('back_to_home'),
              style: AppTextStyle.tajawalBold16.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}