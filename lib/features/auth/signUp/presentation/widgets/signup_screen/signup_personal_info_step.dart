import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../../../src/resourses/font_manager/app_text_style.dart';
import 'signup_auth_input.dart';
import 'signup_field_label.dart';
import 'signup_primary_button.dart';

const int _kQidLength = 11;
const int _kMinPasswordLength = 6;

/// Payload emitted by [SignupPersonalInfoStep] once its form is valid.
class PersonalInfo {
  const PersonalInfo({
    required this.fullName,
    required this.qid,
    required this.password,
  });

  final String fullName;
  final String qid;
  final String password;
}

/// Step 3 — collects the account details: full name, Qatar ID and password.
class SignupPersonalInfoStep extends StatefulWidget {
  const SignupPersonalInfoStep({
    super.key,
    required this.onSubmit,
    this.isSubmitting = false,
  });

  /// Invoked with the validated personal info; the screen creates the account.
  final void Function(PersonalInfo info) onSubmit;
  final bool isSubmitting;

  @override
  State<SignupPersonalInfoStep> createState() => _SignupPersonalInfoStepState();
}

class _SignupPersonalInfoStepState extends State<SignupPersonalInfoStep> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _qidController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _fullNameController.dispose();
    _qidController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return context.tr('field_required');
    if (text.length < 3) return context.tr('name_valdation_msg');
    return null;
  }

  String? _validateQid(String? value) {
    final digits = (value ?? '').replaceAll(RegExp(r'\D'), '');
    if (digits.isEmpty) return context.tr('please_enter_qatar_id');
    if (digits.length != _kQidLength) return context.tr('invalid_qatar_id');
    return null;
  }

  String? _validatePassword(String? value) {
    final text = value ?? '';
    if (text.isEmpty) return context.tr('please_enter_password');
    if (text.length < _kMinPasswordLength) return context.tr('password_too_short');
    return null;
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;
    widget.onSubmit(
      PersonalInfo(
        fullName: _fullNameController.text.trim(),
        qid: _qidController.text.replaceAll(RegExp(r'\D'), ''),
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
            const SizedBox(height: 8),
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
            SignupFieldLabel(label: context.tr('qid')),
            const SizedBox(height: 8),
            SignupAuthInput(
              controller: _qidController,
              hintText: context.tr('qid_hint'),
              keyboardType: TextInputType.number,
              maxLength: _kQidLength,
              textInputAction: TextInputAction.next,
              validator: _validateQid,
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
