import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_clinic_app/src/core/utils/extenssions/int_extenssion.dart';
import 'package:smart_clinic_app/src/core/utils/extenssions/widget_extensions.dart';
import 'package:smart_clinic_app/src/resourses/font_manager/app_text_style.dart';

import '../../../../../src/application/router/app_routes.dart';
import '../../../../../src/core/shared_widgets/app_toast.dart';
import '../../../../../src/resourses/color_manager/app_colors.dart';
import '../controller/signUp_controller.dart';
import '../../domain/model/signUp_params.dart';
import '../../domain/model/signup_response.dart';
import '../widgets/signup_screen/steps/signup_otp_step.dart';
import '../widgets/signup_screen/steps/signup_personal_info_step.dart';
import '../widgets/signup_screen/steps/signup_phone_step.dart';
import '../widgets/signup_screen/signup_progress_header.dart';

/// Three-step signup flow (phone → OTP → personal information) implemented as a
/// single screen driving a [PageView] stepper.
class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key, this.phoneNumber = ''});

  final String phoneNumber;

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  static const int _stepCount = 3;

  late final PageController _pageController;
  late final TextEditingController _nationalPhoneController;
  late final TextEditingController _fullPhoneController;
  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _nationalPhoneController = TextEditingController();
    _fullPhoneController = TextEditingController();
    _setInitialPhone(widget.phoneNumber);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _nationalPhoneController.dispose();
    _fullPhoneController.dispose();
    super.dispose();
  }

  void _setInitialPhone(String phone) {
    if (phone.isEmpty) return;
    final normalized = phone.replaceAll(RegExp(r'\D'), '');
    final national = normalized.startsWith('963')
        ? normalized.replaceFirst('963', '')
        : normalized;
    _nationalPhoneController.text = national;
    _fullPhoneController.text = '963$national';
  }

  void _goToStep(int step) {
    if (step < 0 || step >= _stepCount) return;
    setState(() => _currentStep = step);
    _pageController.animateToPage(
      step,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
  }

  bool _onBack() {
    if (_currentStep == 0) return false;
    _goToStep(_currentStep - 1);
    return true;
  }

  Future<void> _onSendCode(String fullPhone) async {
    ref.read(signUpControllerProvider.notifier).setPhone(fullPhone);
    await ref.read(signUpControllerProvider.notifier).sendOtp(fullPhone);
    _goToStep(1);
  }

  void _onConfirmOtp() => _goToStep(2);

  Future<void> _onResendOtp() => ref
      .read(signUpControllerProvider.notifier)
      .sendOtp(_fullPhoneController.text);

  void _onCreateAccount(PersonalInfo info) {
    ref
        .read(signUpControllerProvider.notifier)
        .signUp(
          SignupParams(
            fullName: info.fullName,
            mobileNumber: _fullPhoneController.text,
            qid: info.nationalId,
            password: info.password,
            otp: null,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<SignupResponseModel?>>(signUpControllerProvider, (
      previous,
      next,
    ) {
      final wasLoading = previous is AsyncLoading;
      if (wasLoading && next is AsyncData) {
        context.go(AppRoutes.homeScreen);
      } else if (wasLoading && next is AsyncError) {
        AppToast.errorToast(next.error.toString());
      }
    });

    final isSubmitting = ref.watch(signUpControllerProvider).isLoading;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        if (!_onBack()) context.go(AppRoutes.authScreen);
      },
      child: Scaffold(
        backgroundColor: AppColors.authBackground,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SignupTopBar(onBack: _onBack),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 22),
                child: SignupProgressHeader(
                  stepLabel: context.tr(_stepLabelKey(_currentStep)),
                  progress: (_currentStep + 1) / _stepCount,
                  title: context.tr('signup_card_title'),
                  subtitle: context.tr('signup_card_subtitle'),
                ),
              ),

              25.verticalSpace,
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    SignupPhoneStep(
                      nationalPhoneController: _nationalPhoneController,
                      fullPhoneController: _fullPhoneController,
                      onSendCode: _onSendCode,
                      title: _titleKey(_currentStep),
                      subtitle: _subtitleKey(_currentStep),
                    ),
                    SignupOtpStep(
                      phone: _fullPhoneController.text,
                      onConfirm: _onConfirmOtp,
                      onResend: _onResendOtp,
                      title: _titleKey(_currentStep),
                      subtitle: _subtitleKey(_currentStep),
                    ),
                    SignupPersonalInfoStep(
                      onSubmit: _onCreateAccount,
                      isSubmitting: isSubmitting,
                      title: _titleKey(_currentStep),
                      subtitle: _subtitleKey(_currentStep),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _stepLabelKey(int step) =>
      const ['step_1_of_3', 'step_2_of_3', 'step_3_of_3'][step];

  static String _titleKey(int step) =>
      const ['join_us_now', 'enter_otp_title', 'personal_info_title'][step];

  static String _subtitleKey(int step) => const [
    'join_us_subtitle',
    'otp_sent_message',
    'personal_info_subtitle',
  ][step];
}

class _SignupTopBar extends StatelessWidget {
  const _SignupTopBar({required this.onBack});
  final bool Function() onBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 20, 0),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              if (!onBack()) context.go(AppRoutes.authScreen);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.authTitle,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
