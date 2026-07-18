import 'package:flutter/material.dart';

import '../../../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../../../src/resourses/font_manager/app_text_style.dart';

/// Reusable text field used across the signup steps.
class SignupAuthInput extends StatelessWidget {
  const SignupAuthInput({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.textAlign = TextAlign.start,
    this.obscureText = false,
    this.suffixIcon,
    this.maxLength,
    this.textInputAction,
  });

  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final TextAlign textAlign;
  final bool obscureText;
  final Widget? suffixIcon;
  final int? maxLength;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
      textAlign: textAlign,
      textDirection: TextDirection.ltr,
      obscureText: obscureText,
      maxLength: maxLength,
      style: AppTextStyle.rubikRegular14.copyWith(color: AppColors.authTitle),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyle.rubikRegular12.copyWith(color: AppColors.authHint),
        counterText: '',
        filled: true,
        fillColor: AppColors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        suffixIcon: suffixIcon,
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
