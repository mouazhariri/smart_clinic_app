import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_clinic_app/features/appointments/presentation/controller/appointments_state.dart';

import '../../../../src/application/router/app_routes.dart';
import '../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../src/resourses/font_manager/app_text_style.dart';
import '../../../doctors/domain/entities/doctor.dart';
import '../controller/appointments_controller.dart';
import '../widgets/doctor_info_banner.dart';

/// Clean confirmation/review screen matching design screenshot.
/// Receives selected info from controller/model.
/// Allows edit (navigate back) and calls controller to confirm booking.
class BookAppointmentStep2Screen extends ConsumerWidget {
  const BookAppointmentStep2Screen({
    super.key,
    required this.doctor,
    this.onEdit,
  });

  final Doctor doctor;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.read(appointmentsControllerProvider).value ?? const AppointmentsState(
          appointments: AsyncData([]),
          bookingState: AsyncData(null),
        );

    final selectedDate = state.selectedDate;
    final selectedTime = state.selectedTime;
    final controller = ref.read(appointmentsControllerProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.dashBackground,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Minimal header (matching screenshot - no large title bar)
            SliverToBoxAdapter(
              child: Container(
                height: 60,
                color: AppColors.white,
                padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 12),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(width: 1, color: AppColors.innerBorder)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('تأكيد الحجز', style: AppTextStyle.tajawalBold16.copyWith(color: AppColors.dark)),
                  ],
                ),
              ),
            ),
            // Doctor info banner (from FakeDoctors model)
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
            // Appointment info card (matching screenshot design exactly)
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              sliver: SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.innerBorder, width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    spacing: 16,
                    children: [
                      // Date / time with icons and edit link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 16,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              spacing: 4,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  spacing: 6,
                                  children: [
                                    Text(
                                      selectedDate != null ? '${selectedDate!.day} ${_monthNameSimple(selectedDate!.month)}' : '--',
                                      textAlign: TextAlign.right,
                                      style: AppTextStyle.tajawalBold14.copyWith(color: AppColors.dark),
                                    ),
                                    Icon(Icons.calendar_today_outlined, size: 16, color: AppColors.subtitle),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  spacing: 6,
                                  children: [
                                    Text(
                                      selectedTime ?? '--',
                                      textAlign: TextAlign.right,
                                      style: AppTextStyle.tajawalBold16.copyWith(color: AppColors.dashPrimary),
                                    ),
                                    Icon(Icons.access_time, size: 16, color: AppColors.subtitle),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Edit link
                          GestureDetector(
                            onTap: onEdit,
                            child: Text(
                              'تعديل',
                              style: AppTextStyle.tajawalRegular12.copyWith(
                                color: AppColors.dashPrimary,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Booking number tag
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF6FF),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 6,
                          children: [
                            Text(
                              '#أ ج ل - 9874',
                              textAlign: TextAlign.right,
                              style: AppTextStyle.tajawalBold12.copyWith(
                                color: AppColors.dashPrimary,
                              ),
                            ),
                            Icon(Icons.tag, size: 14, color: AppColors.dashPrimary),
                          ],
                        ),
                      ),
                      // Patient info row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 16,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              spacing: 4,
                              children: [
                                Text(
                                  'أحمد المحمد',
                                  textAlign: TextAlign.right,
                                  style: AppTextStyle.tajawalBold14.copyWith(color: AppColors.dark),
                                ),
                                Text(
                                  'المريض',
                                  textAlign: TextAlign.right,
                                  style: AppTextStyle.tajawalRegular10.copyWith(color: AppColors.subtitle),
                                ),
                              ],
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Image.network(
                              doctor.imageUrl ?? 'https://placehold.co/40x40',
                              width: 40,
                              height: 40,
                              fit: BoxFit.fill,
                              errorBuilder: (_, __, ___) => Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: AppColors.dashBackground,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Clinic info (from doctor model)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        spacing: 4,
                        children: [
                          Text(
                            doctor.clinicAddress,
                            textAlign: TextAlign.right,
                            style: AppTextStyle.tajawalBold14.copyWith(color: AppColors.dark),
                          ),
                          Text(
                            doctor.location ?? 'دمشق، المزة، شارع المواساة، مقابل المشفى، بناء الأطباء، الطابق الثاني.',
                            textAlign: TextAlign.right,
                            style: AppTextStyle.tajawalRegular10.copyWith(color: AppColors.subtitle),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          // Payment details (from design)
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            sliver: SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.innerBorder, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: 12,
                  children: [
                    Text('تفاصيل الدفع', textAlign: TextAlign.right, style: AppTextStyle.tajawalBold12.copyWith(color: AppColors.dark)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 16,
                      children: [
                        Text('سعر الكشفية', textAlign: TextAlign.right, style: AppTextStyle.tajawalRegular10.copyWith(color: AppColors.subtitle)),
                        Text('${doctor.consultationFee.toInt()} ل.س', style: AppTextStyle.tajawalRegular14.copyWith(color: AppColors.dark)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 16,
                      children: [
                        Text('رسوم الحجز (التطبيق)', textAlign: TextAlign.right, style: AppTextStyle.tajawalRegular10.copyWith(color: AppColors.subtitle)),
                        Text('مجاناً', style: AppTextStyle.tajawalRegular14.copyWith(color: AppColors.dark)),
                      ],
                    ),
                    Container(height: 1, color: AppColors.divider),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 16,
                      children: [
                        Text('الإجمالي', style: AppTextStyle.tajawalRegular14.copyWith(color: AppColors.subtitle)),
                        Text('${doctor.consultationFee.toInt()} ل.س', style: AppTextStyle.tajawalBold16.copyWith(color: AppColors.dashPrimary)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Payment method card
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            sliver: SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.innerBorder, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: 16,
                  children: [
                    Text('طريقة الدفع', textAlign: TextAlign.right, style: AppTextStyle.tajawalBold12.copyWith(color: AppColors.dark)),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.dashBackground,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 8,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              spacing: 4,
                              children: [
                                Text('الدفع نقداً في العيادة', textAlign: TextAlign.right, style: AppTextStyle.tajawalBold14.copyWith(color: AppColors.dashBodyNeutral)),
                                Text('يتم الدفع عند الحضور للموعد', textAlign: TextAlign.right, style: AppTextStyle.tajawalRegular10.copyWith(color: AppColors.subtitle)),
                              ],
                            ),
                          ),
                          Text('تغيير الطريقة', textAlign: TextAlign.right, style: AppTextStyle.tajawalRegular12.copyWith(color: AppColors.dashPrimary, decoration: TextDecoration.underline)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Info message (attendance policy from design)
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            sliver: SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F9FF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 8,
                  children: [
                    Expanded(
                      child: Text(
                        'يرجى الحضور قبل الموعد بـ 15 دقيقة. يمكنك إلغاء أو تعديل الحجز مجاناً قبل 24 ساعة من الموعد.',
                        textAlign: TextAlign.right,
                        style: AppTextStyle.tajawalRegular12.copyWith(color: const Color(0xFF0EA5E9)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Confirm button matching screenshot (calls controller.bookAppointment)
          SliverPadding(
            padding: const EdgeInsets.all(24),
            sliver: SliverToBoxAdapter(
              child: Consumer(
                builder: (context, ref, child) {
                  final state = ref.watch(appointmentsControllerProvider).value ?? const AppointmentsState(appointments: AsyncData([]), bookingState: AsyncData(null));
                  return SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: FilledButton(
                      onPressed: state.bookingState.isLoading ? null : () async {
                        final booked = await ref.read(appointmentsControllerProvider.notifier).bookAppointment(doctor);
                        if (context.mounted && booked) {
                          context.go(AppRoutes.bookAppointmentSuccessScreen, extra: {'doctor': doctor, 'appointmentInfo': ''});
                        }
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.dashPrimary,
                        disabledBackgroundColor: AppColors.disabledButton,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: state.bookingState.isLoading
                          ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.white))
                          : Text('حفظ ومتابعة الحجز', style: AppTextStyle.tajawalBold16.copyWith(color: AppColors.white)),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
          ),

      ),
    );
  }

  String _monthNameSimple(int month) {
    const names = ['', 'يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو', 'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر'];
    return names[month.clamp(1, 12)];
  }
}
