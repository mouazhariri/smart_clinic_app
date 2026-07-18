import 'package:easy_localization/easy_localization.dart' as local;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_clinic_app/src/core/utils/extenssions/int_extenssion.dart';
import 'package:smart_clinic_app/src/core/utils/extenssions/widget_extensions.dart';

import '../../../../../../../src/application/router/app_routes.dart';
import '../../../../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../../../../src/resourses/font_manager/app_text_style.dart';
import '../signup_auth_input.dart';
import '../signup_field_label.dart';
import '../signup_primary_button.dart';
import '../signup_privacy_agreement.dart';
import '../syria_country_code_box.dart';

/// Step 1 — collects the phone number and the privacy agreement.
class SignupPhoneStep extends StatefulWidget {
  const SignupPhoneStep({
    super.key,
    required this.nationalPhoneController,
    required this.fullPhoneController,
    required this.onSendCode,
    required this.title,
    required this.subtitle,
  });

  final TextEditingController nationalPhoneController;
  final TextEditingController fullPhoneController;

  /// Invoked with the normalized full phone number (e.g. "9639XXXXXXXX").
  /// The screen uses it to dispatch the OTP and advance to step 2.
  final Future<void> Function(String fullPhone) onSendCode;
  final String title;
  final String subtitle;
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
          crossAxisAlignment: CrossAxisAlignment.start,
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
            12.verticalSpace,
            SignupFieldLabel(label: context.tr('phone_number')),
            12.verticalSpace,
            Directionality(
              textDirection: TextDirection.ltr,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 82, child: SyriaCountryCodeBox()),
                  const SizedBox(width: 8),

                  Expanded(
                    child: SignupAuthInput(
                      controller: widget.nationalPhoneController,
                      hintText: context.tr('phone_hint_syria'),
                      keyboardType: TextInputType.phone,
                      validator: _validatePhone,
                      onChanged: _onPhoneChanged,
                    ),
                  ),
                ],
              ),
            ),
            25.verticalSpace,
            SignupPrivacyAgreement(
              value: _acceptPrivacyPolicy,
              onChanged: (value) => setState(() {
                _acceptPrivacyPolicy = value;
              }),
            ),
            const SizedBox(height: 45),
            SignupPrimaryButton(
              label: context.tr('send_verification_code'),
              onPressed: (_acceptPrivacyPolicy && !_isSending) ? _submit : null,
              isLoading: _isSending,
            ),
            SizedBox(height: MediaQuery.sizeOf(context).height / 3),
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
