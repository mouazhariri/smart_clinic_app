import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../../src/resourses/font_manager/app_text_style.dart';
import '../../domain/entities/doctor.dart';

class DoctorAboutSection extends StatefulWidget {
  final Doctor doctor;
  const DoctorAboutSection({super.key, required this.doctor});
  @override
  State<DoctorAboutSection> createState() => _DoctorAboutSectionState();
}

class _DoctorAboutSectionState extends State<DoctorAboutSection> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final about = widget.doctor.about ?? context.tr('no_description');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.tr('about_doctor'),
            style: AppTextStyle.tajawalBold16.copyWith(color: AppColors.authTitle)),
        const SizedBox(height: 8),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          alignment: Alignment.topCenter,
          child: Text(
            about,
            maxLines: _expanded ? null : 4,
            overflow: _expanded ? TextOverflow.visible : TextOverflow.ellipsis,
            style: AppTextStyle.tajawalRegular14.copyWith(
                color: AppColors.bodyColor, height: 1.6),
          ),
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: () => setState(() => _expanded = !_expanded),
          child: Text(
            _expanded ? context.tr('read_less') : context.tr('read_more'),
            style: AppTextStyle.tajawalSemiBold14.copyWith(color: AppColors.primary),
          ),
        ),
      ],
    );
  }
}