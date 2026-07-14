import 'package:flutter/material.dart';

import '../../../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../../../src/resourses/font_manager/app_text_style.dart';

class SignupAuthInput extends StatelessWidget {
  const SignupAuthInput({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.textAlign = TextAlign.start,
  });

  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
      textAlign: textAlign,
      textDirection: TextDirection.ltr,
      style: AppTextStyle.rubikRegular14.copyWith(color: AppColors.authTitle),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyle.rubikRegular12.copyWith(color: AppColors.authHint),
        filled: true,
        fillColor: AppColors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: AppColors.authInputBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: AppColors.errorRed),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: AppColors.errorRed),
        ),
      ),
    );
  }
}
