import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../src/resourses/color_manager/app_colors.dart';
import '../widgets/date_card.dart';
import '../widgets/time_slot_card.dart';
import '../widgets/doctor_info_banner.dart';
import '../widgets/notes_field.dart';
import '../widgets/booking_confirm_bar.dart';

/// Clean first step: select date and time.
/// Follows clean architecture by composing dedicated widget files.
class BookAppointmentStep1Screen extends ConsumerStatefulWidget {
  const BookAppointmentStep1Screen({
    super.key,
    required this.doctorName,
    required this.doctorSpecialty,
    required this.doctorImageUrl,
    required this.doctorPrice,
  });

  final String doctorName;
  final String doctorSpecialty;
  final String doctorImageUrl;
  final String doctorPrice;

  @override
  ConsumerState<BookAppointmentStep1Screen> createState() => _BookAppointmentStep1ScreenState();
}

class _BookAppointmentStep1ScreenState extends ConsumerState<BookAppointmentStep1Screen> {
  int selectedDateIndex = 6; // Sunday 15 selected by default (matching design)
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

  final List<_TimeSlot> morningSlots = [
    _TimeSlot('10:00 ص', false, false),
    _TimeSlot('09:30 ص', false, true),
    _TimeSlot('09:00 ص', true, false),
  ];

  final List<_TimeSlot> eveningSlots = [
    _TimeSlot('11:30 ص', false, true),
    _TimeSlot('11:00 ص', false, false),
    _TimeSlot('10:30 ص', false, false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dashBackground,
      body: CustomScrollView(
        slivers: [
          // Header
          SliverToBoxAdapter(
            child: Container(
              height: 60,
              color: AppColors.white,
              padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'حجز موعد',
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
                name: widget.doctorName,
                specialty: widget.doctorSpecialty,
                imageUrl: widget.doctorImageUrl,
              ),
            ),
          ),
          // Section: select date
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
            sliver: SliverToBoxAdapter(
              child: Text(
                'اختر التاريخ',
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: AppColors.dark,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Tajawal',
                ),
              ),
            ),
          ),
          // Date cards
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            sliver: SliverToBoxAdapter(
              child: SizedBox(
                height: 88,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: dates.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final reversedIndex = dates.length - 1 - index;
                    final item = dates[reversedIndex];
                    return DateCard(
                      label: item['label']!,
                      dayNumber: item['number']!,
                      isSelected: selectedDateIndex == reversedIndex,
                      onTap: () => setState(() => selectedDateIndex = reversedIndex),
                    );
                  },
                ),
              ),
            ),
          ),
          // Section: morning time
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
            sliver: SliverToBoxAdapter(
              child: Text(
                'الفترة الصباحية',
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: AppColors.subtitle,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Tajawal',
                ),
              ),
            ),
          ),
          // Morning slots
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 8,
                children: morningSlots.map((slot) => Expanded(
                  child: TimeSlotCard(
                    time: slot.time,
                    isSelected: selectedTime == slot.time,
                    isDisabled: slot.isDisabled,
                    onTap: () => setState(() => selectedTime = slot.time),
                  ),
                )).toList(),
              ),
            ),
          ),
          // Section: evening time
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
            sliver: SliverToBoxAdapter(
              child: Text(
                'الفترة المسائية',
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: AppColors.subtitle,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Tajawal',
                ),
              ),
            ),
          ),
          // Evening slots
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 8,
                children: eveningSlots.map((slot) => Expanded(
                  child: TimeSlotCard(
                    time: slot.time,
                    isSelected: selectedTime == slot.time,
                    isDisabled: slot.isDisabled,
                    onTap: () => setState(() => selectedTime = slot.time),
                  ),
                )).toList(),
              ),
            ),
          ),
          // Evening slots row 2 (additional times)
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
                      onTap: () => setState(() => selectedTime = '04:30 م'),
                    ),
                  ),
                  Expanded(
                    child: TimeSlotCard(
                      time: '04:00 م',
                      isSelected: selectedTime == '04:00 م',
                      isDisabled: false,
                      onTap: () => setState(() => selectedTime = '04:00 م'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Evening slots row 3
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
                      onTap: () => setState(() => selectedTime = '06:00 م'),
                    ),
                  ),
                  Expanded(
                    child: TimeSlotCard(
                      time: '05:30 م',
                      isSelected: selectedTime == '05:30 م',
                      isDisabled: false,
                      onTap: () => setState(() => selectedTime = '05:30 م'),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(height: 40),
                  ),
                ],
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
                    'ملاحظات للطبيب (اختياري)',
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: AppColors.subtitle,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Tajawal',
                      height: 1.33,
                    ),
                  ),
                  NotesField(controller: _notesController),
                ],
              ),
            ),
          ),
          // Bottom confirmation bar
          SliverToBoxAdapter(
            child: BookingConfirmBar(
              price: '75,000 ل.س',
              dateTimeInfo: 'الخميس، 15 يونيو • 04:30 م',
              termsText: 'بالضغط على تأكيد، أنت توافق على شروط الإلغاء',
              onConfirm: () {
                // Handle confirmation
              },
            ),
          ),
          // Spacer for bottom
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }
}

class _TimeSlot {
  final String time;
  final bool isDisabled;
  final bool isSelectedDefault;

  _TimeSlot(this.time, this.isSelectedDefault, this.isDisabled);
}
