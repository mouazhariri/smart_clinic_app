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
import '../../../doctors/presentation/widgets/smart_clinic_app_bar.dart';
import '../controller/appointments_controller.dart';
import '../controller/appointments_state.dart';
import '../widgets/date_card.dart';
import '../widgets/time_slot_card.dart';
import '../widgets/doctor_info_banner.dart';
import '../widgets/notes_field.dart';
import '../widgets/booking_confirm_bar.dart';

/// Clean booking screen following Figma design, structured with clean architecture.
/// Separates screen layout (this file) from widget components.
class BookAppointmentScreen extends ConsumerStatefulWidget {
  const BookAppointmentScreen({
    super.key,
    required this.doctorId,
  });

  final String doctorId;

  @override
  ConsumerState<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends ConsumerState<BookAppointmentScreen> {
  int selectedDateIndex = 6; // Sunday 15 (matches design default selection)
  String? selectedTime;
  final TextEditingController _notesController = TextEditingController();

  final List<Map<String, String>> dates = [
    {'label': 'الجمعة', 'number': '20'},
    {'label': 'الخميس', 'number': '19'},
    {'label': 'الأربعاء', 'number': '18'},
    {'label': 'الثلاثاء', 'number': '17'},
    {'label': 'الاثنين', 'number': '16'},
    {'label': 'الأحد', 'number': '15'},
  ];

  @override
  Widget build(BuildContext context) {
    final doctorAsync = ref.watch(doctorDetailsProvider(widget.doctorId));
    final appointmentState =
        ref.watch(appointmentsControllerProvider).value ?? const AppointmentsState(
              appointments: AsyncData([]),
              bookingState: AsyncData(null),
            );
    final appointmentController = ref.read(appointmentsControllerProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.dashBackground,
      body: doctorAsync.when(
        loading: () => const Center(child: AppLoader()),
        error: (_, __) => _ErrorState(),
        data: (doctor) => _BookingDesignContent(
              doctor: doctor,
              appointmentState: appointmentState,
              appointmentController: appointmentController,
              selectedDateIndex: selectedDateIndex,
              selectedTime: selectedTime,
              onSelectDate: (index) => setState(() => selectedDateIndex = index),
              onSelectTime: (time) => setState(() => selectedTime = time),
              notesController: _notesController,
            ),
      ),
    );
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }
}

class _ErrorState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('حدث خطأ', style: AppTextStyle.tajawalBold18),
    );
  }
}

/// Main content following the clean design pattern.
/// Keeps widget logic separate from layout.
class _BookingDesignContent extends StatelessWidget {
  const _BookingDesignContent({
    required this.doctor,
    required this.appointmentState,
    required this.appointmentController,
    required this.selectedDateIndex,
    required this.selectedTime,
    required this.onSelectDate,
    required this.onSelectTime,
    required this.notesController,
  });

  final Doctor doctor;
  final AppointmentsState appointmentState;
  final AppointmentsController appointmentController;
  final int selectedDateIndex;
  final String? selectedTime;
  final ValueChanged<int> onSelectDate;
  final ValueChanged<String> onSelectTime;
  final TextEditingController notesController;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // Header
        SliverToBoxAdapter(
          child: Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 12),
            decoration: BoxDecoration(
            color: AppColors.white,

              border: Border(
                bottom: BorderSide(width: 1, color: AppColors.innerBorder),
              ),
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
        // Doctor banner
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          sliver: SliverToBoxAdapter(
            child: DoctorInfoBanner(
              name: doctor.name,
              specialty: doctor.specialty,
              imageUrl: doctor.imageUrl ?? '',
            ),
          ),
        ),
        // Date selection section
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          sliver: SliverToBoxAdapter(
            child: Text(
              'اختر التاريخ',
              textAlign: TextAlign.right,
              style: AppTextStyle.tajawalBold16.copyWith(color: AppColors.dark),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          sliver: SliverToBoxAdapter(
            child: SizedBox(
              height: 88,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 6,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final reversedIndex = 5 - index;
                  final labels = ['الجمعة', 'الخميس', 'الأربعاء', 'الثلاثاء', 'الاثنين', 'الأحد'];
                  final numbers = ['20', '19', '18', '17', '16', '15'];
                  return DateCard(
                    label: labels[reversedIndex],
                    dayNumber: numbers[reversedIndex],
                    isSelected: selectedDateIndex == reversedIndex,
                    onTap: () => onSelectDate(reversedIndex),
                  );
                },
              ),
            ),
          ),
        ),
        // Morning time
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          sliver: SliverToBoxAdapter(
            child: Text(
              'الفترة الصباحية',
              textAlign: TextAlign.right,
              style: AppTextStyle.tajawalRegular12.copyWith(color: AppColors.subtitle),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          sliver: SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 8,
              children: [
                Expanded(
                  child: TimeSlotCard(
                    time: '10:00 ص',
                    isSelected: selectedTime == '10:00 ص',
                    isDisabled: false,
                    onTap: () => onSelectTime('10:00 ص'),
                  ),
                ),
                Expanded(
                  child: TimeSlotCard(
                    time: '09:30 ص',
                    isSelected: selectedTime == '09:30 ص',
                    isDisabled: true,
                    onTap: () {},
                  ),
                ),
                Expanded(
                  child: TimeSlotCard(
                    time: '09:00 ص',
                    isSelected: selectedTime == '09:00 ص',
                    isDisabled: false,
                    onTap: () => onSelectTime('09:00 ص'),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Evening time
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          sliver: SliverToBoxAdapter(
            child: Text(
              'الفترة المسائية',
              textAlign: TextAlign.right,
              style: AppTextStyle.tajawalRegular12.copyWith(color: AppColors.subtitle),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          sliver: SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 8,
              children: [
                Expanded(
                  child: TimeSlotCard(
                    time: '11:30 ص',
                    isSelected: selectedTime == '11:30 ص',
                    isDisabled: true,
                    onTap: () {},
                  ),
                ),
                Expanded(
                  child: TimeSlotCard(
                    time: '11:00 ص',
                    isSelected: selectedTime == '11:00 ص',
                    isDisabled: false,
                    onTap: () => onSelectTime('11:00 ص'),
                  ),
                ),
                Expanded(
                  child: TimeSlotCard(
                    time: '10:30 ص',
                    isSelected: selectedTime == '10:30 ص',
                    isDisabled: false,
                    onTap: () => onSelectTime('10:30 ص'),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          sliver: SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 8,
              children: [
                Expanded(
                  child: TimeSlotCard(
                    time: '05:00 م',
                    isSelected: selectedTime == '05:00 م',
                    isDisabled: true,
                    onTap: () {},
                  ),
                ),
                Expanded(
                  child: TimeSlotCard(
                    time: '04:30 م',
                    isSelected: selectedTime == '04:30 م',
                    isDisabled: false,
                    onTap: () => onSelectTime('04:30 م'),
                  ),
                ),
                Expanded(
                  child: TimeSlotCard(
                    time: '04:00 م',
                    isSelected: selectedTime == '04:00 م',
                    isDisabled: false,
                    onTap: () => onSelectTime('04:00 م'),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          sliver: SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 8,
              children: [
                Expanded(
                  child: TimeSlotCard(
                    time: '06:00 م',
                    isSelected: selectedTime == '06:00 م',
                    isDisabled: false,
                    onTap: () => onSelectTime('06:00 م'),
                  ),
                ),
                Expanded(
                  child: TimeSlotCard(
                    time: '05:30 م',
                    isSelected: selectedTime == '05:30 م',
                    isDisabled: false,
                    onTap: () => onSelectTime('05:30 م'),
                  ),
                ),
                Expanded(child: SizedBox(height: 40)),
              ],
            ),
          ),
        ),
        // Notes
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              spacing: 8,
              children: [
                Text(
                  'ملاحظات للطبيب (اختياري)',
                  textAlign: TextAlign.right,
                  style: AppTextStyle.tajawalBold12.copyWith(color: AppColors.subtitle),
                ),
                NotesField(controller: notesController),
              ],
            ),
          ),
        ),
        // Bottom confirmation bar
        SliverToBoxAdapter(
          child: BookingConfirmBar(
            price: "75,000 ${context.tr('syrian_pound_short')}",
            dateTimeInfo: 'الخميس، 15 يونيو • 04:30 م',
            termsText: context.tr('confirm_agree_cancel_terms'),
            onConfirm: () async {
              // if (selectedTime == null) return;
              final booked = await appointmentController.bookAppointment(doctor);
              if (context.mounted && booked) {
                context.go(AppRoutes.appointmentsScreen);
              }
            },
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
      ],
    );
  }
}
