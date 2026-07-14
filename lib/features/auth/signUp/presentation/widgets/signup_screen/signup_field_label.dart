import 'package:flutter/material.dart';

import '../../../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../../../src/resourses/font_manager/app_text_style.dart';

class SignupFieldLabel extends StatelessWidget {
  const SignupFieldLabel({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Padding(
        padding: const EdgeInsetsDirectional.only(end: 8),
        child: Text(
          label,
          style: AppTextStyle.rubikRegular12.copyWith(color: AppColors.bodyColor),
        ),
      ),
    );
  }
}
