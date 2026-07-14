import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../src/application/router/app_routes.dart';
import '../../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../../src/resourses/font_manager/app_text_style.dart';
import '../widgets/signup_screen/signup_auth_input.dart';
import '../widgets/signup_screen/signup_field_label.dart';
import '../widgets/signup_screen/signup_privacy_agreement.dart';
import '../widgets/signup_screen/signup_progress_header.dart';
import '../widgets/signup_screen/syria_country_code_box.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullPhoneController = TextEditingController();
  final _nationalPhoneController = TextEditingController();
  bool _acceptPrivacyPolicy = false;

  @override
  void initState() {
    super.initState();
    _setInitialPhone();
  }

  @override
  void dispose() {
    _fullPhoneController.dispose();
    _nationalPhoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.authBackground,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 18),
                  SignupProgressHeader(
                    stepLabel: context.tr('step_1_of_3'),
                    progress: .33,
                  ),
                  const SizedBox(height: 46),
                  _SignupTitleSection(),
                  const SizedBox(height: 30),
                  SignupFieldLabel(label: context.tr('phone_number')),
                  const SizedBox(height: 8),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: SignupAuthInput(
                            controller: _nationalPhoneController,
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
                  const Spacer(),
                  _SubmitButton(
                    enabled: _acceptPrivacyPolicy,
                    onPressed: _submit,
                  ),
                  const SizedBox(height: 106),
                  _LoginFooter(phoneController: _fullPhoneController),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _setInitialPhone() {
    if (widget.phoneNumber.isEmpty) return;
    final normalized = widget.phoneNumber.replaceAll(RegExp(r'\D'), '');
    final national = normalized.startsWith('963')
        ? normalized.replaceFirst('963', '')
        : normalized;
    _nationalPhoneController.text = national;
    _fullPhoneController.text = '963$national';
  }

  void _onPhoneChanged(String value) {
    final normalized = value.replaceAll(RegExp(r'\D'), '');
    _fullPhoneController.text = '963$normalized';
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

  void _submit() {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;
    context.push(AppRoutes.verificationScreen, extra: _fullPhoneController.text);
  }
}

class _SignupTitleSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: Text(
            context.tr('join_us_now'),
            textAlign: TextAlign.end,
            style: AppTextStyle.rubikBold22.copyWith(
              color: AppColors.authTitle,
              fontSize: 26,
              height: 1.1,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: Text(
            context.tr('join_us_subtitle'),
            textAlign: TextAlign.end,
            style: AppTextStyle.rubikRegular14.copyWith(
              color: AppColors.authSubtitle,
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({required this.enabled, required this.onPressed});

  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: FilledButton(
        onPressed: enabled ? onPressed : null,
        style: FilledButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.primary,
          disabledBackgroundColor: AppColors.primary.withOpacity(.45),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: Text(
          context.tr('send_verification_code'),
          style: AppTextStyle.rubikSemiBold14.copyWith(
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}

class _LoginFooter extends StatelessWidget {
  const _LoginFooter({required this.phoneController});

  final TextEditingController phoneController;

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
