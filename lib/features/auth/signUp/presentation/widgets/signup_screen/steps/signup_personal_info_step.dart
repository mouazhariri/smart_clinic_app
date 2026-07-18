import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smart_clinic_app/src/core/utils/extenssions/int_extenssion.dart';
import 'package:smart_clinic_app/src/core/utils/extenssions/widget_extensions.dart';

import '../../../../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../../../../src/resourses/font_manager/app_text_style.dart';
import '../signup_auth_input.dart';
import '../signup_field_label.dart';
import '../signup_primary_button.dart';

const int _kSyrianIdLength = 11;
const int _kMinPasswordLength = 6;

/// Payload emitted by [SignupPersonalInfoStep] once its form is valid.
class PersonalInfo {
  const PersonalInfo({
    required this.fullName,
    required this.nationalId,
    required this.password,
  });

  final String fullName;
  final String nationalId;
  final String password;
}

/// Step 3 — collects the account details: full name, Syrian National ID and password.
class SignupPersonalInfoStep extends StatefulWidget {
  const SignupPersonalInfoStep({
    super.key,
    required this.onSubmit,
    this.isSubmitting = false,
    required this.title,
    required this.subtitle,
  });

  /// Invoked with the validated personal info; the screen creates the account.
  final void Function(PersonalInfo info) onSubmit;
  final bool isSubmitting;
  final String title;
  final String subtitle;
  @override
  State<SignupPersonalInfoStep> createState() => _SignupPersonalInfoStepState();
}

class _SignupPersonalInfoStepState extends State<SignupPersonalInfoStep> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _nationalIdController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _fullNameController.dispose();
    _nationalIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return context.tr('field_required');
    if (text.length < 3) return context.tr('name_valdation_msg');
    return null;
  }

  String? _validateNationalId(String? value) {
    final digits = (value ?? '').replaceAll(RegExp(r'\D'), '');
    if (digits.isEmpty) return context.tr('please_enter_national_id');
    if (digits.length != _kSyrianIdLength)
      return context.tr('invalid_national_id');
    return null;
  }

  String? _validatePassword(String? value) {
    final text = value ?? '';
    if (text.isEmpty) return context.tr('please_enter_password');
    if (text.length < _kMinPasswordLength)
      return context.tr('password_too_short');
    return null;
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;
    widget.onSubmit(
      PersonalInfo(
        fullName: _fullNameController.text.trim(),
        nationalId: _nationalIdController.text.replaceAll(RegExp(r'\D'), ''),
        password: _passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
              Text(
              context.tr(widget.title),
              textAlign: TextAlign.start,
              style: AppTextStyle.rubikBold22.copyWith(
                color: AppColors.authTitle,
                fontSize: 19,
                height: 1,
              ),
            ).symmetricPadding(horizontal: 14),
            10.verticalSpace,
            Text(
              context.tr(widget.subtitle),
              // textAlign: TextAlign.end,
              style: AppTextStyle.rubikRegular14.copyWith(
                color: AppColors.authSubtitle,
              ),
            ).symmetricPadding(horizontal: 14),
            const SizedBox(height: 28),
            SignupFieldLabel(label: context.tr('full_name')),
            const SizedBox(height: 8),
            SignupAuthInput(
              controller: _fullNameController,
              hintText: context.tr('full_name_hint'),
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              validator: _validateName,
            ),
            const SizedBox(height: 18),
            SignupFieldLabel(label: context.tr('national_id')),
            const SizedBox(height: 8),
            SignupAuthInput(
              controller: _nationalIdController,
              hintText: context.tr('national_id_hint'),
              keyboardType: TextInputType.number,
              maxLength: _kSyrianIdLength,
              textInputAction: TextInputAction.next,
              validator: _validateNationalId,
            ),
            const SizedBox(height: 18),
            SignupFieldLabel(label: context.tr('password')),
            const SizedBox(height: 8),
            SignupAuthInput(
              controller: _passwordController,
              hintText: context.tr('password_hint'),
              obscureText: _obscurePassword,
              textInputAction: TextInputAction.done,
              validator: _validatePassword,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: AppColors.authIcon,
                  size: 20,
                ),
                onPressed: () => setState(() {
                  _obscurePassword = !_obscurePassword;
                }),
              ),
            ),
            const SizedBox(height: 30),
            SignupPrimaryButton(
              label: context.tr('create_account'),
              onPressed: widget.isSubmitting ? null : _submit,
              isLoading: widget.isSubmitting,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
