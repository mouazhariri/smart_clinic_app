import 'package:flutter/material.dart';

import '../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../src/resourses/font_manager/app_text_style.dart';

/// Clean optional notes text field for booking.
class NotesField extends StatelessWidget {
  const NotesField({
    super.key,
    this.controller,
  });

  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 124,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.dashBorder, width: 1),
      ),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.right,
        maxLines: 4,
        style: AppTextStyle.tajawalRegular14.copyWith(
          color: AppColors.dashBodyNeutral,
          height: 1.5,
        ),
        decoration: InputDecoration(
          hintText: 'اكتب ملاحظاتك هنا...',
          hintStyle: AppTextStyle.tajawalRegular14.copyWith(
            color: AppColors.placeholder,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
