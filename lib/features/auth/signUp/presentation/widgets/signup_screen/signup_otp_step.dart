import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../../../src/resourses/font_manager/app_text_style.dart';
import 'signup_primary_button.dart';

const int _kOtpSeconds = 90;
const int _kOtpLength = 6;

/// Step 2 — verifies the OTP sent to [phone].
///
/// Self-contained: owns the OTP controller, countdown timer and resend logic.
class SignupOtpStep extends StatefulWidget {
  const SignupOtpStep({
    super.key,
    required this.phone,
    required this.onConfirm,
    required this.onResend,
  });

  final String phone;

  /// Invoked once the OTP passes local validation; the screen advances to step 3.
  final VoidCallback onConfirm;

  /// Invoked when the user taps "resend"; the screen dispatches a new OTP.
  final Future<void> Function() onResend;

  @override
  State<SignupOtpStep> createState() => _SignupOtpStepState();
}

class _SignupOtpStepState extends State<SignupOtpStep> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();
  final _focusNode = FocusNode();
  Timer? _timer;
  int _remaining = _kOtpSeconds;
  bool _resending = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
    WidgetsBinding.instance.addPostFrameCallback((_) => _focusNode.requestFocus());
  }

  @override
  void dispose() {
    _timer?.cancel();
    _otpController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    _remaining = _kOtpSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_remaining > 0) {
        setState(() => _remaining--);
      } else {
        timer.cancel();
      }
    });
  }

  String get _timerText {
    final minutes = (_remaining ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remaining % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  bool get _canResend => _remaining == 0 && !_resending;

  Future<void> _resend() async {
    setState(() => _resending = true);
    try {
      await widget.onResend();
      if (mounted) _startTimer();
    } finally {
      if (mounted) setState(() => _resending = false);
    }
  }

  void _confirm() {
    _focusNode.unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;
    widget.onConfirm();
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
            _MaskedPhone(phone: widget.phone),
            const SizedBox(height: 24),
            _OtpField(controller: _otpController, focusNode: _focusNode),
            const SizedBox(height: 24),
            _OtpTimerRow(
              remaining: _remaining,
              timerText: _timerText,
              canResend: _canResend,
              resending: _resending,
              onResend: _resend,
            ),
            const SizedBox(height: 28),
            SignupPrimaryButton(
              label: context.tr('confirm'),
              onPressed: _confirm,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _MaskedPhone extends StatelessWidget {
  const _MaskedPhone({required this.phone});
  final String phone;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Text(
        phone.replaceRange(0, phone.length - 3, '********'),
        textAlign: TextAlign.center,
        style: AppTextStyle.rubikSemiBold16.copyWith(
          color: AppColors.primary,
        ),
      ),
    );
  }
}

class _OtpField extends StatelessWidget {
  const _OtpField({required this.controller, required this.focusNode});

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    final baseTheme = PinTheme(
      width: 52,
      height: 60,
      textStyle:
          AppTextStyle.rubikRegular20.copyWith(color: AppColors.primary),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.authInputBorder),
      ),
    );

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Center(
        child: Pinput(
          controller: controller,
          focusNode: focusNode,
          length: _kOtpLength,
          keyboardType: TextInputType.number,
          defaultPinTheme: baseTheme,
          focusedPinTheme: baseTheme.copyBorderWith(
            border: Border.all(color: AppColors.primary),
          ),
          errorPinTheme: baseTheme.copyBorderWith(
            border: Border.all(color: AppColors.errorRed),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return context.tr('please_enter_code');
            }
            if (value.length < _kOtpLength) {
              return context.tr('code_must_be_6_numbers');
            }
            return null;
          },
        ),
      ),
    );
  }
}

class _OtpTimerRow extends StatelessWidget {
  const _OtpTimerRow({
    required this.remaining,
    required this.timerText,
    required this.canResend,
    required this.resending,
    required this.onResend,
  });

  final int remaining;
  final String timerText;
  final bool canResend;
  final bool resending;
  final Future<void> Function() onResend;

  @override
  Widget build(BuildContext context) {
    if (canResend) {
      return GestureDetector(
        onTap: resending ? null : () => onResend(),
        child: Text(
          context.tr('resend_otp'),
          textAlign: TextAlign.center,
          style: AppTextStyle.rubikRegular14.copyWith(
            color: resending ? AppColors.authHint : AppColors.primary,
            decoration: TextDecoration.underline,
            decorationColor: AppColors.primary,
          ),
        ),
      );
    }
    return Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        style: AppTextStyle.rubikRegular14.copyWith(color: AppColors.authHint),
        children: [
          TextSpan(text: context.tr('verificationExpired')),
          const TextSpan(text: ' '),
          TextSpan(
            text: timerText,
            style: AppTextStyle.rubikSemiBold14.copyWith(
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
