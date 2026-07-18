import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_clinic_app/src/application/router/app_routes.dart';
import 'package:smart_clinic_app/src/core/utils/extenssions/widget_extensions.dart';
import 'package:smart_clinic_app/src/resourses/color_manager/app_colors.dart';
import 'package:smart_clinic_app/src/resourses/font_manager/app_text_style.dart';

import '../../../doctors/domain/entities/doctor.dart';
import '../controller/booking_controller.dart';
import '../controller/booking_state.dart';

class BookingScreen extends ConsumerStatefulWidget {
  final Doctor doctor;
  const BookingScreen({super.key, required this.doctor});

  @override
  ConsumerState<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends ConsumerState<BookingScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      final n = ref.read(bookingControllerProvider.notifier);
      n.loadDoctorInfo(
        doctorName: widget.doctor.name,
        doctorSpecialty: widget.doctor.specialty,
        clinicName: widget.doctor.clinicAddress,
        price: widget.doctor.consultationFee,
      );
      n.loadSchedule(
        widget.doctor.availableDates,
        widget.doctor.availableTimes,
      );
    });
  }

  void _goToConfirm(BookingState state) {
    context.push(
      AppRoutes.bookAppointmentConfirmScreen,
      extra: {
        'doctor': widget.doctor,
        'selectedDate': state.selectedDate,
        'selectedTime': state.selectedTime,
        'price': widget.doctor.consultationFee,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bookingControllerProvider);
    final canContinue =
        state.selectedDate != null && state.selectedTime != null;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.authTitle,
            size: 18,
          ),
          onPressed: () => context.pop(),
        ),

        title: Text(
          context.tr('book_appointment'),
          style: AppTextStyle.tajawalBold18.copyWith(
            color: AppColors.authTitle,
          ),
        ),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
            
                // ─── Doctor card ──────────────────────────────────
                _DoctorCard(doctor: widget.doctor).symmetricPadding(horizontal: 16),
                const SizedBox(height: 28),
            
                // ─── Date ────────────────────────────────────────
                _SectionHeader(context.tr('select_date')).symmetricPadding(horizontal: 16),
                const SizedBox(height: 14),
                _DateRow(
                  state: state,
                  doctor: widget.doctor,
                  onSelect: (d) => ref
                      .read(bookingControllerProvider.notifier)
                      .selectDate(d),
                ).onlyPadding(end: 16),
                const SizedBox(height: 28),
            
                // ─── Time ────────────────────────────────────────
                _SectionHeader(context.tr('select_time')).symmetricPadding(horizontal: 16),
                const SizedBox(height: 14),
                _TimePicker(
                  state: state,
                  onSelect: (t) => ref
                      .read(bookingControllerProvider.notifier)
                      .selectTime(t),
                ).symmetricPadding(horizontal: 16),
                const SizedBox(height: 28),
            
                // ─── Notes ───────────────────────────────────────
                _SectionHeader(context.tr('notes_for_doctor')),
                const SizedBox(height: 12),
                _NotesInput(
                  onChanged: (v) => ref
                      .read(bookingControllerProvider.notifier)
                      .updateNotes(v),
                ),
            
                // Space for bottom bar
                const SizedBox(height: 140),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _BottomBar(
        doctor: widget.doctor,
        state: state,
        canContinue: canContinue,
        onContinue: canContinue ? () => _goToConfirm(state) : null,
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════
//  DOCTOR CARD
// ════════════════════════════════════════════════════════════════════
class _DoctorCard extends StatelessWidget {
  final Doctor doctor;
  const _DoctorCard({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        spacing: 12,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: doctor.imageUrl != null
                ? NetworkImage(doctor.imageUrl!)
                : null,
            backgroundColor: AppColors.dashNeutralBg,
            child: doctor.imageUrl == null
                ? const Icon(Icons.person, color: AppColors.authHint, size: 28)
                : null,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctor.name,
                  style: AppTextStyle.tajawalBold18.copyWith(
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
          // Circular avatar on the left (end in RTL = visual left)
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════
//  SECTION HEADER
// ════════════════════════════════════════════════════════════════════
class _SectionHeader extends StatelessWidget {
  final String text;
  const _SectionHeader(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyle.tajawalBold20.copyWith(color: AppColors.authTitle),
    );
  }
}

// ════════════════════════════════════════════════════════════════════
//  DATE ROW  — horizontal scroll, chips flush to edges
// ════════════════════════════════════════════════════════════════════
class _DateRow extends StatelessWidget {
  final BookingState state;
  final Doctor doctor;
  final ValueChanged<DateTime> onSelect;

  const _DateRow({
    required this.state,
    required this.doctor,
    required this.onSelect,
  });

  bool _isSameDay(DateTime? a, DateTime b) =>
      a != null && a.year == b.year && a.month == b.month && a.day == b.day;

  bool _isAvailable(DateTime date) {
    final wh = doctor.workingHours;
    if (wh == null || wh.isEmpty) return true;
    final name = _weekdayName(date.weekday);
    return wh.any((h) => h.day.contains(name) && h.time.trim().isNotEmpty);
  }

  String _weekdayName(int w) =>
      const {
        1: 'Monday',
        2: 'Tuesday',
        3: 'Wednesday',
        4: 'Thursday',
        5: 'Friday',
        6: 'Saturday',
        7: 'Sunday',
      }[w] ??
      '';

  @override
  Widget build(BuildContext context) {
    if (state.availableDates.isEmpty) {
      return _Hint(context.tr('no_dates_available'));
    }

    return SizedBox(
      height: 60,
      child: ListView.builder(
        // RTL: most-recent date (index 0) is on the right
        reverse: true,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemCount: state.availableDates.length,
        itemBuilder: (_, i) {
          final date = state.availableDates[i];
          final selected = _isSameDay(state.selectedDate, date);
          final available = _isAvailable(date);

          return Padding(
            padding: const EdgeInsetsDirectional.only(start: 8),
            child: _DateChip(
              date: date,
              selected: selected,
              available: available,
              onTap: available ? () => onSelect(date) : null,
            ),
          );
        },
      ),
    );
  }
}

class _DateChip extends StatelessWidget {
  final DateTime date;
  final bool selected;
  final bool available;
  final VoidCallback? onTap;

  const _DateChip({
    required this.date,
    required this.selected,
    required this.available,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // ── Exact colours from screenshot ──────────────────────────────
    final Color bg = selected ? AppColors.primary : Colors.white;

    final Color dayNumColor = selected
        ? Colors.white
        : available
        ? AppColors.authTitle
        : AppColors.gray;

    final Color dayNameColor = selected
        ? Colors.white.withOpacity(0.85)
        : available
        ? AppColors.authSubtitle
        : AppColors.gray;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: 60,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
          // No visible border on unselected — matches screenshot
          border: selected ? null : Border.all(color: Colors.transparent),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              // Short day name: الأحد → الأح  (locale-aware)
              DateFormat.E(context.locale.languageCode).format(date),
              style: AppTextStyle.tajawalRegular12.copyWith(
                color: dayNameColor,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${date.day}',
              style: AppTextStyle.tajawalBold18.copyWith(
                color: dayNumColor,
                fontSize: 24,
                height: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════
//  TIME PICKER  — morning + evening sections, 3-col grid
// ════════════════════════════════════════════════════════════════════
class _TimePicker extends StatelessWidget {
  final BookingState state;
  final ValueChanged<String> onSelect;

  const _TimePicker({required this.state, required this.onSelect});

  static bool _isMorning(String t) {
    final u = t.toUpperCase();
    return u.contains('AM') || u.contains('ص');
  }

  @override
  Widget build(BuildContext context) {
    if (state.selectedDate == null) {
      return _Hint(context.tr('select_date'));
    }
    if (state.availableSlots.isEmpty) {
      return _Hint(context.tr('no_times_available'));
    }

    final morning = state.availableSlots
        .where((s) => _isMorning(s.time))
        .toList();
    final evening = state.availableSlots
        .where((s) => !_isMorning(s.time))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (morning.isNotEmpty) ...[
          _PeriodLabel(context.tr('morning_period')),
          const SizedBox(height: 10),
          _SlotGrid(
            slots: morning,
            selected: state.selectedTime,
            onSelect: onSelect,
          ),
        ],
        if (evening.isNotEmpty) ...[
          const SizedBox(height: 18),
          _PeriodLabel(context.tr('evening_period')),
          const SizedBox(height: 10),
          _SlotGrid(
            slots: evening,
            selected: state.selectedTime,
            onSelect: onSelect,
          ),
        ],
      ],
    );
  }
}

class _PeriodLabel extends StatelessWidget {
  final String text;
  const _PeriodLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyle.tajawalSemiBold14.copyWith(
        color: AppColors.authSubtitle,
        // fontSize: 13,
      ),
    );
  }
}

class _SlotGrid extends StatelessWidget {
  final List slots;
  final String? selected;
  final ValueChanged<String> onSelect;

  const _SlotGrid({
    required this.slots,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        // Height matches the pills in the screenshot
        childAspectRatio: 2.6,
      ),
      itemCount: slots.length,
      itemBuilder: (_, i) {
        final slot = slots[i];
        final time = slot.time as String;
        final isAvailable = slot.isAvailable as bool;
        final isSelected = selected == time;

        return _TimeSlot(
          time: time,
          available: isAvailable,
          selected: isSelected,
          onTap: isAvailable ? () => onSelect(time) : null,
        );
      },
    );
  }
}

class _TimeSlot extends StatelessWidget {
  final String time;
  final bool available;
  final bool selected;
  final VoidCallback? onTap;

  const _TimeSlot({
    required this.time,
    required this.available,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // ── Screenshot-accurate colour rules ───────────────────────────
    //   Selected   → blue fill, white text
    //   Available  → white fill, dark text, light grey border
    //   Unavailable→ light grey fill (#F5F5F5), grey text, no border
    final Color bg;
    final Color fg;
    final Color border;

    if (selected) {
      bg = AppColors.primary;
      fg = Colors.white;
      border = AppColors.primary;
    } else if (available) {
      bg = Colors.white;
      fg = AppColors.authTitle;
      border = const Color(0xFFDDDDDD);
    } else {
      // Unavailable — screenshot shows lighter grey bg, grey text
      bg = AppColors.gray03;
      fg = const Color(0xFFBBBBBB);
      border = Colors.transparent;
    }

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(10),
          // border: Border.all(color: border, width: 1),
        ),
        alignment: Alignment.center,
        child: Text(
          time,
          style: AppTextStyle.tajawalBold14.copyWith(
            color: fg,
            // fontSize: 13,
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════
//  NOTES INPUT
// ════════════════════════════════════════════════════════════════════
class _NotesInput extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const _NotesInput({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border,width: 0.5),
        ),
        child: TextField(
          maxLines: 8,
          minLines: 7,
          // textDirection: TextDirection.rtl,
          onChanged: onChanged,
          style: AppTextStyle.tajawalRegular14.copyWith(
            color: AppColors.authTitle,
          ),
          decoration: InputDecoration(
            hintText: context.tr('notes_hint'),
            hintStyle: AppTextStyle.tajawalRegular14.copyWith(
              color: AppColors.gray,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(14),
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════
//  EMPTY / HINT
// ════════════════════════════════════════════════════════════════════
class _Hint extends StatelessWidget {
  final String text;
  const _Hint(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F6FA),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: AppTextStyle.tajawalRegular14.copyWith(
          color: AppColors.authSubtitle,
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════
//  BOTTOM BAR — pixel-matched to screenshot
// ════════════════════════════════════════════════════════════════════
class _BottomBar extends StatelessWidget {
  final Doctor doctor;
  final BookingState state;
  final bool canContinue;
  final VoidCallback? onContinue;

  const _BottomBar({
    required this.doctor,
    required this.state,
    required this.canContinue,
    required this.onContinue,
  });

  String _summary(BuildContext context) {
    final d = state.selectedDate;
    final t = state.selectedTime;
    if (d == null) return '';
    final locale = context.locale.languageCode;
    final datePart = DateFormat('EEEE، d MMMM', locale).format(d);
    return t != null ? '$datePart • $t' : datePart;
  }

  @override
  Widget build(BuildContext context) {
    final summary = _summary(context);

    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(
        16,
        12,
        16,
        MediaQuery.of(context).padding.bottom + 12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Summary + price row ────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Date + time  (right in RTL)
              if (summary.isNotEmpty)
                Flexible(
                  child: Text(
                    summary,
                    style: AppTextStyle.tajawalRegular12.copyWith(
                      color: AppColors.authSubtitle,
                    ),
                  ),
                ),

              // Price in blue  (left in RTL)
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${doctor.consultationFee.toStringAsFixed(0)} ',
                      style: AppTextStyle.tajawalBold18.copyWith(
                        color: AppColors.primary,
                        fontSize: 20,
                      ),
                    ),
                    TextSpan(
                      text: context.tr('syrian_pound_short'),
                      style: AppTextStyle.tajawalSemiBold14.copyWith(
                        color: AppColors.primary,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // ── Book button ────────────────────────────────────────
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: onContinue,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                disabledBackgroundColor: AppColors.primary.withOpacity(0.4),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(
                context.tr('book_appointment'),
                style: AppTextStyle.tajawalBold18.copyWith(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // ── Policy text ────────────────────────────────────────
          Center(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '${context.tr('by_clicking_agree')} ',
                    style: AppTextStyle.tajawalRegular12.copyWith(
                      color: AppColors.authSubtitle,
                      fontSize: 11,
                    ),
                  ),
                  TextSpan(
                    text: context.tr('cancellation_policy'),
                    style: AppTextStyle.tajawalRegular12.copyWith(
                      color: AppColors.primary,
                      fontSize: 11,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
