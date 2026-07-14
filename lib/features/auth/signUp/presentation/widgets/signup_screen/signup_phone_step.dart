import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../src/application/router/app_routes.dart';
import '../../../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../../../src/resourses/font_manager/app_text_style.dart';
import 'signup_auth_input.dart';
import 'signup_field_label.dart';
import 'signup_primary_button.dart';
import 'signup_privacy_agreement.dart';
import 'syria_country_code_box.dart';

/// Step 1 — collects the phone number and the privacy agreement.
class SignupPhoneStep extends StatefulWidget {
  const SignupPhoneStep({
    super.key,
    required this.nationalPhoneController,
    required this.fullPhoneController,
    required this.onSendCode,
  });

  final TextEditingController nationalPhoneController;
  final TextEditingController fullPhoneController;

  /// Invoked with the normalized full phone number (e.g. "9639XXXXXXXX").
  /// The screen uses it to dispatch the OTP and advance to step 2.
  final Future<void> Function(String fullPhone) onSendCode;

  @override
  State<SignupPhoneStep> createState() => _SignupPhoneStepState();
}

class _SignupPhoneStepState extends State<SignupPhoneStep> {
  final _formKey = GlobalKey<FormState>();
  bool _acceptPrivacyPolicy = false;
  bool _isSending = false;

  void _onPhoneChanged(String value) {
    final normalized = value.replaceAll(RegExp(r'\D'), '');
    widget.fullPhoneController.text = '963$normalized';
  }

  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.tr('field_required');
    }
    if (value.replaceAll(RegExp(r'\D'), '').length < 8) {
      return context.tr('invalid_phone_number');
    }
    return null;
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _isSending = true);
    try {
      await widget.onSendCode(widget.fullPhoneController.text);
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
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
            SignupFieldLabel(label: context.tr('phone_number')),
            const SizedBox(height: 8),
            Directionality(
              textDirection: TextDirection.ltr,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SignupAuthInput(
                      controller: widget.nationalPhoneController,
                      hintText: context.tr('phone_hint_syria'),
                      keyboardType: TextInputType.phone,
                      textAlign: TextAlign.center,
                      validator: _validatePhone,
                      onChanged: _onPhoneChanged,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const SizedBox(width: 82, child: SyriaCountryCodeBox()),
                ],
              ),
            ),
            const SizedBox(height: 18),
            SignupPrivacyAgreement(
              value: _acceptPrivacyPolicy,
              onChanged: (value) => setState(() {
                _acceptPrivacyPolicy = value;
              }),
            ),
            const SizedBox(height: 28),
            SignupPrimaryButton(
              label: context.tr('send_verification_code'),
              onPressed:
                  (_acceptPrivacyPolicy && !_isSending) ? _submit : null,
              isLoading: _isSending,
            ),
            const SizedBox(height: 24),
            _LoginPrompt(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _LoginPrompt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          context.tr('already_have_account_prompt'),
          style: AppTextStyle.rubikRegular12.copyWith(
            color: AppColors.authHint,
          ),
        ),
        TextButton(
          onPressed: () => context.go(AppRoutes.signInScreen),
          child: Text(
            context.tr('login'),
            style: AppTextStyle.rubikSemiBold12.copyWith(
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
