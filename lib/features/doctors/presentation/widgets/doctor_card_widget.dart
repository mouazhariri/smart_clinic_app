import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_clinic_app/src/core/shared_widgets/custom_button_widget.dart';

import '../../../../src/application/router/app_routes.dart';
import '../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../src/resourses/font_manager/app_text_style.dart';
import '../../domain/entities/doctor.dart';

// ── Availability type ──────────────────────────────────────────────────────
enum _AvailType {
  bookToday, // has slot today  → blue "Book Now"
  bookLater, // has slot but not today → outlined "View Profile"
  fullyBooked, // no slots at all → pink bottom + "Notify Me"
}

class DoctorCardWidget extends StatelessWidget {
  final Doctor doctor;
  const DoctorCardWidget({super.key, required this.doctor});

  // ── Compute availability ─────────────────────────────────────────────────
  _AvailType _availType() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    if (doctor.availableDates.isEmpty) return _AvailType.fullyBooked;

    final futureDates = doctor.availableDates.where((d) {
      final day = DateTime(d.year, d.month, d.day);
      return !day.isBefore(today);
    }).toList();

    if (futureDates.isEmpty) return _AvailType.fullyBooked;

    final hasToday = futureDates.any(
      (d) =>
          d.year == today.year && d.month == today.month && d.day == today.day,
    );

    return hasToday ? _AvailType.bookToday : _AvailType.bookLater;
  }

  DateTime? _nextDate() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final future = doctor.availableDates.where((d) {
      final day = DateTime(d.year, d.month, d.day);
      return !day.isBefore(today);
    }).toList()..sort();
    return future.isEmpty ? null : future.first;
  }

  @override
  Widget build(BuildContext context) {
    final type = _availType();
    final next = _nextDate();

    return GestureDetector(
      onTap: () => context.push(AppRoutes.doctorDetailsScreen, extra: doctor),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          children: [
            // ── Top section ─────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.all(14),
              child: _TopSection(doctor: doctor),
            ),

            // ── Divider ─────────────────────────────────────────────
            const Divider(height: 1, color: Color(0xFFF0F0F0)),

            // ── Bottom section ──────────────────────────────────────
            _BottomSection(type: type, doctor: doctor, nextDate: next),
          ],
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
// TOP SECTION  — rating | name + specialty + chips | image
// ════════════════════════════════════════════════════════════════════════════
class _TopSection extends StatelessWidget {
  final Doctor doctor;
  const _TopSection({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: doctor.imageUrl != null
              ? Image.network(
                  doctor.imageUrl!,
                  width: 72,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => _PlaceholderImage(),
                )
              : _PlaceholderImage(),
        ),

        // ── Rating badge (top-left) ──────────────────────────────
        const SizedBox(width: 10),

        // ── Name + specialty + chips (centre, right-aligned text) ─
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name
              Text(
                doctor.name,
                style: AppTextStyle.tajawalBold18.copyWith(
                  color: AppColors.authTitle,
                  fontSize: 17,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 3),

              // Specialty
              Text(
                doctor.specialty,
                style: AppTextStyle.tajawalRegular12.copyWith(
                  color: AppColors.authSubtitle,
                ),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 8),

              // Chips row (location + price) — right-aligned
              Wrap(
                // alignment: WrapAlignment.end,
                spacing: 6,
                runSpacing: 4,
                children: [
                  if ((doctor.location ?? '').isNotEmpty)
                    _Chip(label: doctor.location!),
                  if (doctor.price != null)
                    _Chip(
                      label:
                          '${doctor.price} ${context.tr('syrian_pound_short')}',
                    ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(width: 12),
        if (doctor.rating != null) _RatingBadge(rating: doctor.rating!),

        // ── Doctor image (top-right) ─────────────────────────────
      ],
    );
  }
}

class _PlaceholderImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 80,
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(Icons.person, color: AppColors.gray, size: 36),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
// BOTTOM SECTION  — 3 visual states
// ════════════════════════════════════════════════════════════════════════════
class _BottomSection extends StatelessWidget {
  final _AvailType type;
  final Doctor doctor;
  final DateTime? nextDate;

  const _BottomSection({
    required this.type,
    required this.doctor,
    required this.nextDate,
  });

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case _AvailType.bookToday:
        return _BookTodayBottom(doctor: doctor, nextDate: nextDate!);
      case _AvailType.bookLater:
        return _BookLaterBottom(doctor: doctor, nextDate: nextDate!);
      case _AvailType.fullyBooked:
        return _FullyBookedBottom(doctor: doctor);
    }
  }
}

// ── 1. Book TODAY  ─────────────────────────────────────────────────────────
//    Left: blue "حجز الآن" button
//    Right: calendar icon (blue bg) + label + blue date/time value
class _BookTodayBottom extends StatelessWidget {
  final Doctor doctor;
  final DateTime nextDate;

  const _BookTodayBottom({required this.doctor, required this.nextDate});

  @override
  Widget build(BuildContext context) {
    final timeStr = doctor.availableTimes.isNotEmpty
        ? doctor.availableTimes.first
        : '';
    final label =
        '${context.tr('today')}${timeStr.isNotEmpty ? '، $timeStr' : ''}';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.calendar_today_outlined,
              size: 18,
              color: AppColors.primary,
            ),
          ),

          const SizedBox(width: 10),

          // ── Date info ────────────────────────────────────────────
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                context.tr('nearest_appointment'),
                style: AppTextStyle.tajawalRegular12.copyWith(
                  color: AppColors.authSubtitle,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: AppTextStyle.tajawalBold14.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ],
          ),

          // ── Calendar icon (blue bg) ───────────────────────────────
          const Spacer(),

          // ── Book Now button ──────────────────────────────────────
          CustomButtonWidget(
            text: context.tr('book_now'),
            onTap: () => context.push(
              AppRoutes.bookAppointmentScreen,
              extra: {'doctor': doctor},
            ),
            isFiled: true,
            height: 45,
            width: 80,
            backgroundColor: AppColors.primary,
            style: AppTextStyle.tajawalBold14.copyWith(color: Colors.white),
          ),
          // SizedBox(
          //   height: 42,
          //   child: ElevatedButton(
          //     onPressed: () => context.push(
          //       AppRoutes.bookAppointmentScreen,
          //       extra: {'doctor': doctor},
          //     ),
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: AppColors.primary,
          //       elevation: 0,
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(10),
          //       ),
          //       padding: const EdgeInsets.symmetric(horizontal: 20),
          //     ),
          //     child: Text(
          //       context.tr('book_now'),
          //       style: AppTextStyle.tajawalBold14.copyWith(color: Colors.white),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

// ── 2. Book LATER  ────────────────────────────────────────────────────────
//    Left: outlined "عرض الملف" button
//    Right: grey calendar icon + label + grey date/time value
class _BookLaterBottom extends StatelessWidget {
  final Doctor doctor;
  final DateTime nextDate;

  const _BookLaterBottom({required this.doctor, required this.nextDate});

  @override
  Widget build(BuildContext context) {
    final locale = context.locale.languageCode;
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    final nextDay = DateTime(nextDate.year, nextDate.month, nextDate.day);

    final String dayLabel;
    if (nextDay == DateTime(tomorrow.year, tomorrow.month, tomorrow.day)) {
      dayLabel = context.tr('tomorrow');
    } else {
      dayLabel = DateFormat('EEE, d MMM', locale).format(nextDate);
    }

    final timeStr = doctor.availableTimes.isNotEmpty
        ? doctor.availableTimes.first
        : '';
    final label = '$dayLabel${timeStr.isNotEmpty ? '، $timeStr' : ''}';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          // ── View profile button ──────────────────────────────────
          SizedBox(
            height: 42,
            child: OutlinedButton(
              onPressed: () =>
                  context.push(AppRoutes.doctorDetailsScreen, extra: doctor),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.primary.withOpacity(0.5)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
              ),
              child: Text(
                context.tr('view_profile'),
                style: AppTextStyle.tajawalBold14.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
          ),

          const Spacer(),

          // ── Date info ────────────────────────────────────────────
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                context.tr('nearest_appointment'),
                style: AppTextStyle.tajawalRegular12.copyWith(
                  color: AppColors.authSubtitle,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: AppTextStyle.tajawalBold14.copyWith(
                  color: AppColors.authTitle,
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),

          // ── Calendar icon (grey bg) ───────────────────────────────
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFFF0F0F0),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.calendar_today_outlined,
              size: 18,
              color: Color(0xFFAAAAAA),
            ),
          ),
        ],
      ),
    );
  }
}

// ── 3. FULLY BOOKED  ──────────────────────────────────────────────────────
//    Entire bottom = light pink/red bg
//    Left: outlined grey "تنبيه عند التوفر"
//    Right: red calendar-X icon + "حالة المواعيد" label + red "ممتلئ هذا الأسبوع"
class _FullyBookedBottom extends StatelessWidget {
  final Doctor doctor;
  const _FullyBookedBottom({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Container(
      // Light pink background — matches screenshot
      color: const Color(0xFFFFF0F0),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          // ── Notify button ─────────────────────────────────────────
          SizedBox(
            height: 42,
            child: OutlinedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(context.tr('notification_set')),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFCCCCCC)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              child: Text(
                context.tr('notify_on_available'),
                style: AppTextStyle.tajawalBold12.copyWith(
                  color: AppColors.authSubtitle,
                ),
              ),
            ),
          ),

          const Spacer(),

          // ── Status text ───────────────────────────────────────────
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                context.tr('appointment_status'),
                style: AppTextStyle.tajawalRegular12.copyWith(
                  color: AppColors.red,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                context.tr('fully_booked_this_week'),
                style: AppTextStyle.tajawalBold14.copyWith(
                  color: AppColors.red,
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),

          // ── Calendar-X icon (red bg) ──────────────────────────────
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFFFFE0E0),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.calendar_month_outlined,
              size: 18,
              color: Color(0xFFE53935),
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
// RATING BADGE  — "4.9 ★" top-left
// ════════════════════════════════════════════════════════════════════════════
class _RatingBadge extends StatelessWidget {
  final double rating;
  const _RatingBadge({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          rating.toStringAsFixed(1),
          style: AppTextStyle.tajawalBold14.copyWith(
            color: AppColors.authTitle,
          ),
        ),
        const SizedBox(width: 3),
        const Icon(Icons.star_rounded, color: Color(0xFFFFC107), size: 18),
      ],
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
// GREY CHIP  — location / price
// ════════════════════════════════════════════════════════════════════════════
class _Chip extends StatelessWidget {
  final String label;
  const _Chip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F6FA),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: AppTextStyle.tajawalRegular12.copyWith(
          color: AppColors.authSubtitle,
        ),
      ),
    );
  }
}
