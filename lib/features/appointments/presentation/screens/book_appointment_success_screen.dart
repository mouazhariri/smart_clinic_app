import 'package:flutter/material.dart';

import '../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../src/resourses/font_manager/app_text_style.dart';
import '../widgets/doctor_info_banner.dart';

/// Clean success screen after booking confirmation.
class BookAppointmentSuccessScreen extends StatelessWidget {
  const BookAppointmentSuccessScreen({
    super.key,
    required this.doctorName,
    required this.doctorSpecialty,
    required this.doctorImageUrl,
    required this.appointmentInfo,
  });

  final String doctorName;
  final String doctorSpecialty;
  final String doctorImageUrl;
  final String appointmentInfo;

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
          // Success icon
          SliverToBoxAdapter(
            child: SizedBox(
              height: 224,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 44,
                    child: Container(
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
                  ),
                  Positioned(
                    top: 64,
                    child: Container(
                      width: 40,
                      height: 40,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Success message
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
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
          // Doctor info card (summary)
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
          // Appointment info card
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
                    _InfoRow(
                      label: 'التاريخ والوقت',
                      value: 'الخميس، 15 يونيو • 04:30 م',
                      valueColor: AppColors.dark,
                      showEdit: true,
                    ),
                    Container(height: 1, color: AppColors.divider),
                    _InfoRow(
                      label: 'المريض',
                      value: 'أحمد المحمد',
                      valueColor: AppColors.dark,
                    ),
                    Container(height: 1, color: AppColors.divider),
                    _InfoRow(
                      label: 'موقع العيادة',
                      value: 'عيادة المزة التخصصية',
                      valueColor: AppColors.dark,
                      subtitle: 'دمشق، المزة، شارع المواساة، مقابل المشفى، بناء الأطباء، الطابق الثاني.',
                    ),
                    Container(height: 1, color: AppColors.divider),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '#أ ج ل - 9874',
                                style: AppTextStyle.tajawalBold10.copyWith(
                                  color: AppColors.dashPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'رقم الحجز',
                          style: AppTextStyle.tajawalRegular10.copyWith(
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
          // Payment info
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
                    _InfoRow(
                      label: 'سعر الكشفية',
                      value: '75,000 ل.س',
                      valueColor: AppColors.dark,
                    ),
                    _InfoRow(
                      label: 'رسوم الحجز (التطبيق)',
                      value: 'مجاناً',
                      valueColor: AppColors.dark,
                    ),
                    Container(height: 1, color: AppColors.border),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 16,
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
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 4,
                              children: [
                                Text(
                                  'الدفع نقداً في العيادة',
                                  textAlign: TextAlign.right,
                                  style: AppTextStyle.tajawalBold14.copyWith(
                                    color: AppColors.dashBodyNeutral,
                                  ),
                                ),
                                Text(
                                  'يتم الدفع عند الحضور للموعد',
                                  textAlign: TextAlign.right,
                                  style: AppTextStyle.tajawalRegular10.copyWith(
                                    color: AppColors.subtitle,
                                  ),
                                ),
                              ],
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
          // Buttons
          SliverPadding(
            padding: const EdgeInsets.all(24),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 16,
                children: [
                  SizedBox(
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
                        'عرض تفاصيل الموعد',
                        style: AppTextStyle.tajawalBold16.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors.dashBorder, width: 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'إضافة إلى التقويم',
                        style: AppTextStyle.tajawalBold16.copyWith(
                          color: AppColors.dashBodyNeutral,
                        ),
                      ),
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

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
    required this.valueColor,
    this.subtitle,
    this.showEdit = false,
  });
  final String label;
  final String value;
  final Color valueColor;
  final String? subtitle;
  final bool showEdit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      spacing: 4,
      children: [
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
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      textAlign: TextAlign.right,
                      style: AppTextStyle.tajawalRegular10.copyWith(
                        color: AppColors.subtitle,
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
        ),
      ],
    );
  }
}
