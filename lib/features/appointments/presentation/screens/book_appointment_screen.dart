import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../src/application/router/app_routes.dart';
import '../../../../src/core/shared_widgets/app_loader.dart';
import '../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../src/resourses/font_manager/app_text_style.dart';
import '../../../doctors/domain/entities/doctor.dart';
import '../../../doctors/presentation/controller/doctors_controller.dart';
import '../controller/appointments_controller.dart';
import '../controller/appointments_state.dart';
import '../widgets/date_card.dart';
import '../widgets/time_slot_card.dart';
import '../widgets/doctor_info_banner.dart';
import '../widgets/notes_field.dart';
import '../widgets/booking_confirm_bar.dart';

/// Clean booking screen following design screenshot.
/// Uses controller for state, doctor model for test data.
/// Ready for endpoint connection via repository/data source.
class BookAppointmentScreen extends ConsumerStatefulWidget {
  const BookAppointmentScreen({super.key, required this.doctorId});
  final String doctorId;

  @override
  ConsumerState<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends ConsumerState<BookAppointmentScreen> {
  final TextEditingController _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final doctorAsync = ref.watch(doctorDetailsProvider(widget.doctorId));
    final appointmentState =
        ref.watch(appointmentsControllerProvider).value ?? const AppointmentsState(
              appointments: AsyncData([]),
              bookingState: AsyncData(null),
            );
    final controller = ref.read(appointmentsControllerProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.dashBackground,
      body: SafeArea(
        child: doctorAsync.when(
          loading: () => const Center(child: AppLoader()),
          error: (_, __) => const _ErrorState(),
          data: (doctor) => _BookingDesignContent(
                doctor: doctor,
                appointmentState: appointmentState,
                controller: controller,
                notesController: _notesController,
              ),
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState();
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(context.tr('no_doctors_found'), style: AppTextStyle.tajawalBold18));
  }
}

class _BookingDesignContent extends StatelessWidget {
  const _BookingDesignContent({
    required this.doctor,
    required this.appointmentState,
    required this.controller,
    required this.notesController,
  });
  final Doctor doctor;
  final AppointmentsState appointmentState;
  final AppointmentsController controller;
  final TextEditingController notesController;

  @override
  Widget build(BuildContext context) {
    // Build date cards from doctor model (test data ready for endpoint)
    final dates = doctor.availableDates;
    // Build time slots from doctor model
    final times = doctor.availableTimes;

    return CustomScrollView(
      slivers: [
        // Header bar matching design
        SliverToBoxAdapter(
          child: Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border(bottom: BorderSide(width: 1, color: AppColors.innerBorder)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    context.tr('book_appointment'),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.dark,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Tajawal',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Doctor banner (from FakeDoctors model)
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          sliver: SliverToBoxAdapter(
            child: DoctorInfoBanner(
              name: doctor.name,
              specialty: doctor.specialty,
              imageUrl: doctor.imageUrl ?? '',
            ),
          ),
        ),
        // Section title: select date
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          sliver: SliverToBoxAdapter(
            child: Text(
              context.tr('select_date'),
              textAlign: TextAlign.right,
              style: AppTextStyle.tajawalBold16.copyWith(color: AppColors.dark),
            ),
          ),
        ),
        // Date cards from doctor.availableDates (test data from FakeDoctors)
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          sliver: SliverToBoxAdapter(
            child: SizedBox(
              height: 88,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: dates.isNotEmpty ? dates.length : 1,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  if (dates.isEmpty) return const SizedBox.shrink();
                  final date = dates[index % dates.length];
                  final selected = appointmentState.selectedDate != null &&
                      _sameDay(date, appointmentState.selectedDate);
                  final label = _formatDayName(context, date);
                  final number = '${date.day}';
                  return DateCard(
                    label: label,
                    dayNumber: number,
                    isSelected: selected,
                    isDisabled: _isDateDisabled(date),
                    onTap: () => _isDateDisabled(date) ? null : controller.selectDate(date),
                  );
                },
              ),
            ),
          ),
        ),
        // Morning session label
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          sliver: SliverToBoxAdapter(
            child: Text(
              context.tr('morning_session'),
              textAlign: TextAlign.right,
              style: AppTextStyle.tajawalRegular12.copyWith(color: AppColors.subtitle),
            ),
          ),
        ),
        // Time slots from doctor.availableTimes
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          sliver: SliverToBoxAdapter(
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: (times.isNotEmpty ? times : ['09:00 ص', '10:00 ص', '11:00 ص', '12:00 م', '01:00 م', '02:00 م', '03:00 م', '04:00 م'])
                  .map((time) {
                final selected = appointmentState.selectedTime == time;
                return TimeSlotCard(
                  time: time,
                  isSelected: selected,
                  isDisabled: false,
                  onTap: () => controller.selectTime(time),
                );
              }).toList(),
            ),
          ),
        ),
        // Evening session label (design shows both sections)
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          sliver: SliverToBoxAdapter(
            child: Text(
              context.tr('evening_session'),
              textAlign: TextAlign.right,
              style: AppTextStyle.tajawalRegular12.copyWith(color: AppColors.subtitle),
            ),
          ),
        ),
        // Additional time slots (evening) from doctor model
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          sliver: SliverToBoxAdapter(
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: (times.isNotEmpty ? times.skip(3).toList() : ['05:00 م', '04:30 م', '04:00 م', '06:00 م', '05:30 م'])
                  .map((time) {
                final selected = appointmentState.selectedTime == time;
                return TimeSlotCard(
                  time: time,
                  isSelected: selected,
                  isDisabled: false,
                  onTap: () => controller.selectTime(time),
                );
              }).toList(),
            ),
          ),
        ),
        // Notes field
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              spacing: 8,
              children: [
                Text(
                  context.tr('optional_notes_for_doctor'),
                  textAlign: TextAlign.right,
                  style: AppTextStyle.tajawalBold12.copyWith(color: AppColors.subtitle),
                ),
                NotesField(controller: notesController),
              ],
            ),
          ),
        ),
        // Bottom confirmation bar connected to controller state
        SliverToBoxAdapter(
          child: BookingConfirmBar(
            price: '${doctor.consultationFee.toInt()} ${context.tr('syrian_pound_short')}',
            dateTimeInfo: appointmentState.selectedDate != null && appointmentState.selectedTime != null
                ? '${_formatDate(context, appointmentState.selectedDate!)} • ${appointmentState.selectedTime}'
                : '--',
            termsText: context.tr('confirm_agree_cancel_terms'),
            onConfirm: () async {
              if (appointmentState.selectedDate == null || appointmentState.selectedTime == null) return;
              if (context.mounted) {
                context.pushNamed(
                  AppRoutes.bookAppointmentConfirmScreen,
                  pathParameters: {'doctorId': doctor.id},
                  extra: {
                    'doctor': doctor,
                    'selectedDate': appointmentState.selectedDate,
                    'selectedTime': appointmentState.selectedTime,
                  },
                );
              }
            },
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
      ],
    );
  }

  bool _sameDay(DateTime a, DateTime? b) {
    if (b == null) return false;
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  String _formatDayName(BuildContext context, DateTime date) {
    final weekdays = ['الأحد', 'الاثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة', 'السبت'];
    return weekdays[date.weekday % 7];
  }

  String _formatDate(BuildContext context, DateTime date) {
    return '${date.day} ${_monthName(date.month)}';
  }

  String _monthName(int month) {
    const names = ['', 'يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو', 'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر'];
    return names[month.clamp(1, 12)];
  }

  bool _isDateDisabled(DateTime date) {
    final workingHours = doctor.workingHours ?? const <WorkingHour>[];
    final weekday = date.weekday; // 1=Mon, 5=Fri, 6=Sat
    for (final wh in workingHours) {
      if (wh.time.isEmpty) {
        if (wh.day.contains('Friday') || wh.day.contains('Saturday')) {
          if (weekday == 5 || weekday == 6) return true;
        }
      }
    }
    return false;
  }
}
