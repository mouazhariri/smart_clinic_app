import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:smart_clinic_app/features/doctors/domain/entities/doctor.dart';
import '../../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../../src/resourses/font_manager/app_text_style.dart';
class DoctorWorkingHours extends StatelessWidget {
  final Doctor doctor;
  const DoctorWorkingHours({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    // Generate test data if workingHours is null
    final hours = doctor.workingHours ?? [
      WorkingHour(day: context.tr('sunday_wednesday'), time: '09:00 AM - 04:00 PM'),
      WorkingHour(day: context.tr('thursday'), time: '09:00 AM - 02:00 PM'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.tr('working_hours'), style: AppTextStyle.tajawalBold16),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            // boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
          ),
          child: Column(
            children: hours.map((h) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(h.day, style: AppTextStyle.tajawalRegular14),
                      
                      Text(h.time, style: AppTextStyle.tajawalBold14.copyWith(color: AppColors.authSubtitle)),
                    ],
                  ),
                  Divider(color: AppColors.background)
                ],
              ),
            )).toList(),
          ),
        ),
      ],
    );
  }
}

// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:smart_clinic_app/src/resourses/color_manager/app_colors.dart';
// import 'package:smart_clinic_app/src/resourses/font_manager/app_text_style.dart';
// import 'package:smart_clinic_app/features/home/domain/entities/doctor.dart';

// class DoctorWorkingHours extends StatelessWidget {
//   final Doctor doctor;
//   const DoctorWorkingHours({super.key, required this.doctor});

//   @override
//   Widget build(BuildContext context) {
//     final hours = doctor.workingHours ?? const [];
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(context.tr('working_hours'),
//               style: AppTextStyle.tajawalBold16.copyWith(color: AppColors.authTitle)),
//           const SizedBox(height: 12),
//           Container(
//             decoration: BoxDecoration(
//               color: AppColors.white,
//               borderRadius: BorderRadius.circular(16),
//               boxShadow: [
//                 BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10,
//                     offset: const Offset(0, 3)),
//               ],
//             ),
//             child: hours.isEmpty
//                 ? Padding(
//                     padding: const EdgeInsets.all(16),
//                     child: Text(context.tr('no_working_hours_available'),
//                         style: AppTextStyle.tajawalRegular14.copyWith(
//                             color: AppColors.authSubtitle)),
//                   )
//                 : Column(
//                     children: List.generate(hours.length, (i) {
//                       final h = hours[i];
//                       final closed = h.time.trim().isEmpty;
//                       final last = i == hours.length - 1;
//                       return Column(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 16, vertical: 14),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(h.day,
//                                     style: AppTextStyle.tajawalRegular14.copyWith(
//                                         color: closed
//                                             ? AppColors.errorRed
//                                             : AppColors.authTitle)),
//                                 closed
//                                     ? Container(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 12, vertical: 4),
//                                         decoration: BoxDecoration(
//                                           color: AppColors.errorRed.withOpacity(0.1),
//                                           borderRadius: BorderRadius.circular(20),
//                                         ),
//                                         child: Text(context.tr('closed'),
//                                             style: AppTextStyle.tajawalRegular12
//                                                 .copyWith(
//                                                     fontWeight: FontWeight.w600,
//                                                     color: AppColors.errorRed)),
//                                       )
//                                     : Text(h.time,
//                                         style: AppTextStyle.tajawalRegular14
//                                             .copyWith(color: AppColors.authSubtitle)),
//                               ],
//                             ),
//                           ),
//                           if (!last)
//                             const Divider(height: 1, indent: 16, endIndent: 16,
//                                 color: AppColors.dashNeutralBg),
//                         ],
//                       );
//                     }),
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
// }