import 'package:flutter/material.dart';

import '../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../src/resourses/font_manager/app_text_style.dart';
import '../widgets/doctor_info_banner.dart';

/// Clean second step: confirm appointment.
class BookAppointmentStep2Screen extends StatelessWidget {
  const BookAppointmentStep2Screen({
    super.key,
    required this.doctorName,
    required this.doctorSpecialty,
    required this.doctorImageUrl,
    required this.appointmentDateTime,
  });

  final String doctorName;
  final String doctorSpecialty;
  final String doctorImageUrl;
  final String appointmentDateTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomScrollView(
        slivers: [
          // Header
          SliverToBoxAdapter(
            child: Container(
              height: 60,
              color: AppColors.white,
              padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 12),
              decoration: BoxDecoration(
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
                      'تأكيد الحجز',
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
          // Success icon area
          SliverToBoxAdapter(
            child: SizedBox(
              height: 200,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Outer ring
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0D9488),
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 32,
                        color: const Color(0xFFF0FDFA),
                      ),
                    ),
                  ),
                  // Check icon placeholder
                  Container(
                    width: 40,
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
          // Message
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 8,
                children: [
                  Text(
                    'تم تأكيد الحجز بنجاح!',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.tajawalBold20.copyWith(
                      color: AppColors.dark,
                    ),
                  ),
                  Text(
                    'تم إرسال رسالة نصية (SMS) تحتوي على تفاصيل الموعد إلى رقم هاتفك.',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.tajawalRegular16.copyWith(
                      color: AppColors.subtitle,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Doctor info card
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            sliver: SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.dashBackground,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DoctorInfoBanner(
                  name: doctorName,
                  specialty: doctorSpecialty,
                  imageUrl: doctorImageUrl,
                ),
              ),
            ),
          ),
          // Appointment details
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
                  spacing: 16,
                  children: [
                    _DetailRow(
                      label: 'التاريخ والوقت',
                      value: appointmentDateTime,
                      valueColor: AppColors.dashPrimary,
                      showEdit: true,
                    ),
                    Container(
                      height: 1,
                      color: AppColors.divider,
                    ),
                    _DetailRow(
                      label: 'المريض',
                      value: 'أحمد المحمد',
                      valueColor: AppColors.dark,
                    ),
                    _DetailRow(
                      label: 'موقع العيادة',
                      value: 'عيادة المزة التخصصية\nدمشق، المزة، شارع المواساة، مقابل المشفى، بناء الأطباء، الطابق الثاني.',
                      valueColor: AppColors.subtitle,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Payment details
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
                  spacing: 16,
                  children: [
                    Text(
                      'تفاصيل الدفع',
                      textAlign: TextAlign.right,
                      style: AppTextStyle.tajawalBold12.copyWith(
                        color: AppColors.dark,
                      ),
                    ),
                    _PaymentRow(
                      label: 'سعر الكشفية',
                      value: '75,000 ل.س',
                    ),
                    _PaymentRow(
                      label: 'رسوم الحجز (التطبيق)',
                      value: 'مجاناً',
                    ),
                    Container(
                      height: 1,
                      color: AppColors.border,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '75,000 ل.س',
                          style: AppTextStyle.tajawalBold16.copyWith(
                            color: AppColors.dashPrimary,
                          ),
                        ),
                        Text(
                          'الإجمالي',
                          style: AppTextStyle.tajawalRegular14.copyWith(
                            color: AppColors.subtitle,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Payment method
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
                    Text(
                      'طريقة الدفع',
                      textAlign: TextAlign.right,
                      style: AppTextStyle.tajawalBold12.copyWith(
                        color: AppColors.dark,
                      ),
                    ),
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
                          Text(
                            'الدفع نقداً في العيادة',
                            textAlign: TextAlign.right,
                            style: AppTextStyle.tajawalBold14.copyWith(
                              color: AppColors.dashBodyNeutral,
                            ),
                          ),
                          Text(
                            'تغيير الطريقة',
                            textAlign: TextAlign.right,
                            style: AppTextStyle.tajawalRegular12.copyWith(
                              color: AppColors.dashPrimary,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Info message
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
                        style: AppTextStyle.tajawalRegular12.copyWith(
                          color: const Color(0xFF0EA5E9),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Confirm button
          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              color: AppColors.white,
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.dashPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'تأكيد الحجز',
                    style: AppTextStyle.tajawalBold16.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.label,
    required this.value,
    required this.valueColor,
    this.showEdit = false,
  });

  final String label;
  final String value;
  final Color valueColor;
  final bool showEdit;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 16,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 4,
            children: [
              Text(
                label,
                textAlign: TextAlign.right,
                style: AppTextStyle.tajawalRegular10.copyWith(
                  color: AppColors.subtitle,
                ),
              ),
              Text(
                value,
                textAlign: TextAlign.right,
                style: AppTextStyle.tajawalBold14.copyWith(
                  color: valueColor,
                ),
              ),
            ],
          ),
        ),
        if (showEdit)
          Text(
            'تعديل',
            textAlign: TextAlign.right,
            style: AppTextStyle.tajawalRegular12.copyWith(
              color: AppColors.dashPrimary,
              decoration: TextDecoration.underline,
            ),
          ),
      ],
    );
  }
}

class _PaymentRow extends StatelessWidget {
  const _PaymentRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 16,
      children: [
        Text(
          value,
          textAlign: TextAlign.right,
          style: AppTextStyle.tajawalRegular14.copyWith(
            color: AppColors.dark,
          ),
        ),
        Text(
          label,
          textAlign: TextAlign.right,
          style: AppTextStyle.tajawalRegular10.copyWith(
            color: AppColors.subtitle,
          ),
        ),
      ],
    );
  }
}
