import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../src/application/router/app_routes.dart';
import '../../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../../src/resourses/font_manager/app_text_style.dart';
import '../controller/signUp_controller.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullPhoneController = TextEditingController();
  final _nationalPhoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.phoneNumber.isNotEmpty) {
      _fullPhoneController.text = widget.phoneNumber;
      _nationalPhoneController.text = widget.phoneNumber.replaceFirst('963', '');
    }
  }

  @override
  void dispose() {
    _fullPhoneController.dispose();
    _nationalPhoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signUpController = ref.read(signUpControllerProvider.notifier);
    final acceptPrivacyPolicy = signUpController.acceptPrivacyPolicy;

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
                  _SignupProgressHeader(
                    stepLabel: context.tr('step_1_of_3'),
                    progress: .33,
                  ),
                  const SizedBox(height: 46),
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
                  const SizedBox(height: 30),
                  _FieldLabel(label: context.tr('phone_number')),
                  const SizedBox(height: 8),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _AuthInput(
                            controller: _nationalPhoneController,
                            hintText: context.tr('phone_hint_syria'),
                            keyboardType: TextInputType.phone,
                            textAlign: TextAlign.center,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return context.tr('field_required');
                              }
                              return null;
                            },
                            onChanged: _onPhoneChanged,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const SizedBox(width: 82, child: _CountryCodeBox()),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox.adaptive(
                        value: acceptPrivacyPolicy,
                        onChanged: (_) {
                          signUpController.toggleAcceptedPrivacyPolicy();
                          setState(() {});
                        },
                        activeColor: AppColors.primary,
                        side: const BorderSide(color: AppColors.authInputBorder),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            signUpController.toggleAcceptedPrivacyPolicy();
                            setState(() {});
                          },
                          child: Text(
                            context.tr('agree_privacy_full'),
                            textAlign: TextAlign.end,
                            style: AppTextStyle.rubikSemiBold12.copyWith(
                              color: AppColors.authTitle,
                              height: 1.55,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: FilledButton(
                      onPressed: acceptPrivacyPolicy ? _submit : null,
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
                  ),
                  const SizedBox(height: 106),
                  Row(
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
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onPhoneChanged(String value) {
    final normalized = value.replaceAll(RegExp(r'\D'), '');
    _fullPhoneController.text = '963$normalized';
    ref.read(signUpControllerProvider.notifier).setPhone(_fullPhoneController.text);
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    context.push(AppRoutes.verificationScreen, extra: _fullPhoneController.text);
  }
}

class _SignupProgressHeader extends StatelessWidget {
  const _SignupProgressHeader({required this.stepLabel, required this.progress});

  final String stepLabel;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 18),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                color: AppColors.authFlagPlaceholder,
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    context.tr('personal_info_title'),
                    style: AppTextStyle.rubikBold22.copyWith(
                      color: AppColors.authTitle,
                      fontSize: 19,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    context.tr('personal_info_subtitle'),
                    style: AppTextStyle.rubikRegular12.copyWith(
                      color: AppColors.authSubtitle,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 4,
              backgroundColor: AppColors.authDivider,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            stepLabel,
            style: AppTextStyle.interRegular10.copyWith(color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.label});

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

class _AuthInput extends StatelessWidget {
  const _AuthInput({
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

class _CountryCodeBox extends StatelessWidget {
  const _CountryCodeBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.authInputBorder),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '+963',
            style: AppTextStyle.rubikSemiBold12.copyWith(color: AppColors.authTitle),
          ),
          const SizedBox(width: 6),
          Assets.icons.syriaFlagIcon.svg(width: 18, height: 14),
        ],
      ),
    );
  }
}
