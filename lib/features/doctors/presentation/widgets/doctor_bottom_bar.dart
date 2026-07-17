import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import '../../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../../src/resourses/font_manager/app_text_style.dart';
import '../../../../src/core/shared_widgets/custom_button_widget.dart';
import '../../domain/entities/doctor.dart';
class DoctorBottomBar extends StatelessWidget {
  final Doctor doctor;
  const DoctorBottomBar({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 12, 20, MediaQuery.of(context).padding.bottom + 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(context.tr('consultation_fee'), style: AppTextStyle.tajawalRegular12),
                Text(
                  '${doctor.price} ${context.tr('syrian_pound_short')}',
                  style: AppTextStyle.tajawalBold20.copyWith(color: AppColors.primary),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: CustomButtonWidget(
              text: context.tr('book_appointment'),
              isFiled: true,
              height: 60,
              width: double.infinity,
              radius: 10,
              backgroundColor: AppColors.primary,
              color: AppColors.white,
              style: AppTextStyle.interSemiBold16.copyWith(
                color: AppColors.white,
              ),
              onTap: () => context.push(AppRoutes.bookAppointmentPath(doctor.id)),
            ),
          ),
        ],
      ),
    );
  }
}