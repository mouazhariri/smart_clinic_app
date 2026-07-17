import 'package:flutter/material.dart';

import '../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../src/resourses/font_manager/app_text_style.dart';
import '../widgets/doctor_info_banner.dart';

/// Clean confirmation screen matching design screenshot exactly.
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
      backgroundColor: AppColors.dashBackground,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Success icon
            SliverToBoxAdapter(
              child: SizedBox(
                height: 220,
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
                      child: Icon(
                        Icons.check_rounded,
                        size: 36,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Title
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'تم تأكيد الحجز بنجاح!',
                  textAlign: TextAlign.center,
                  style: AppTextStyle.tajawalBold20.copyWith(color: AppColors.dark),
                ),
              ),
            ),
            // Subtitle
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 4),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'تم إرسال رسالة نصية (SMS) تحتوي على تفاصيل الموعد إلى رقم هاتفك.',
                  textAlign: TextAlign.center,
                  style: AppTextStyle.tajawalRegular14.copyWith(color: AppColors.subtitle),
                ),
              ),
            ),
            // Doctor info banner (from model / fake data)
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
            // Appointment details card (matching screenshot layout)
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
                      // Date / time row with icons
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
                                      'الخميس، 15 يونيو',
                                      textAlign: TextAlign.right,
                                      style: AppTextStyle.tajawalBold14.copyWith(
                                        color: AppColors.dark,
                                      ),
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
                                      '04:30 م',
                                      textAlign: TextAlign.right,
                                      style: AppTextStyle.tajawalBold16.copyWith(
                                        color: AppColors.dashPrimary,
                                      ),
                                    ),
                                    Icon(Icons.access_time, size: 16, color: AppColors.subtitle),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              spacing: 4,
                              children: [
                                Text(
                                  'التاريخ',
                                  textAlign: TextAlign.right,
                                  style: AppTextStyle.tajawalRegular10.copyWith(color: AppColors.subtitle),
                                ),
                                Text(
                                  'الوقت',
                                  textAlign: TextAlign.right,
                                  style: AppTextStyle.tajawalRegular10.copyWith(color: AppColors.subtitle),
                                ),
                              ],
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
                              style: AppTextStyle.tajawalBold10.copyWith(
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
                              'https://placehold.co/40x40',
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
                      // Clinic info
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        spacing: 4,
                        children: [
                          Text(
                            'عيادة المزة التخصصية',
                            textAlign: TextAlign.right,
                            style: AppTextStyle.tajawalBold14.copyWith(color: AppColors.dark),
                          ),
                          Text(
                            'دمشق، المزة، شارع المواساة، مقابل المشفى، بناء الأطباء، الطابق الثاني.',
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
                  spacing: 16,
                  children: [
                    Text(
                      'تفاصيل الدفع',
                      textAlign: TextAlign.right,
                      style: AppTextStyle.tajawalBold12.copyWith(color: AppColors.dark),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 16,
                      children: [
                        Text('75,000 ل.س', style: AppTextStyle.tajawalRegular14.copyWith(color: AppColors.dark)),
                        Text('سعر الكشفية', textAlign: TextAlign.right, style: AppTextStyle.tajawalRegular10.copyWith(color: AppColors.subtitle)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 16,
                      children: [
                        Text('مجاناً', style: AppTextStyle.tajawalRegular14.copyWith(color: AppColors.dark)),
                        Text('رسوم الحجز (التطبيق)', textAlign: TextAlign.right, style: AppTextStyle.tajawalRegular10.copyWith(color: AppColors.subtitle)),
                      ],
                    ),
                    Container(height: 1, color: AppColors.border),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 16,
                      children: [
                        Text('75,000 ل.س', style: AppTextStyle.tajawalBold16.copyWith(color: AppColors.dashPrimary)),
                        Text('الإجمالي', style: AppTextStyle.tajawalRegular14.copyWith(color: AppColors.subtitle)),
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
                          Text(
                            'الدفع نقداً في العيادة',
                            textAlign: TextAlign.right,
                            style: AppTextStyle.tajawalBold14.copyWith(color: AppColors.dashBodyNeutral),
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
          // Info message (attendance policy)
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
          // Action buttons matching screenshot
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
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text('عرض تفاصيل الموعد', style: AppTextStyle.tajawalBold16.copyWith(color: AppColors.white)),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors.dashBorder, width: 1),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text('إضافة إلى التقويم', style: AppTextStyle.tajawalBold16.copyWith(color: AppColors.dashBodyNeutral)),
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
