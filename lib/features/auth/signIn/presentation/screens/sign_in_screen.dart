import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../src/application/router/app_routes.dart';
import '../../../../../src/core/shared_widgets/app_toast.dart';
import '../../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../../src/resourses/font_manager/app_text_style.dart';
import '../controller/sign_in_controller.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _nationalPhoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _phoneController.dispose();
    _nationalPhoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(signInControllerProvider, (prev, next) {
      if (next is AsyncData && prev is AsyncLoading) {
        if (next.value?.signinResponseModel?.userExist ?? false) {
          context.push(AppRoutes.verificationScreen, extra: _phoneController.text);
        } else {
          context.go(AppRoutes.signUpScreen, extra: _phoneController.text);
        }
      } else if (next is AsyncError) {
        AppToast.errorToast(next.error.toString());
      }
    });

    final signInState = ref.watch(signInControllerProvider);
    final isLoading = signInState is AsyncLoading;

    return Scaffold(
      backgroundColor: AppColors.authBackground,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const Spacer(flex: 2),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Text(
                    context.tr('welcome_back_title'),
                    textAlign: TextAlign.end,
                    style: AppTextStyle.rubikBold22.copyWith(
                      color: AppColors.authTitle,
                      fontSize: 28,
                      height: 1.1,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Text(
                    context.tr('signin_subtitle'),
                    textAlign: TextAlign.end,
                    style: AppTextStyle.rubikRegular14.copyWith(
                      color: AppColors.authSubtitle,
                      height: 1.35,
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                _FieldLabel(label: context.tr('phone_number')),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _AuthTextField(
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
                    SizedBox(
                      width: 82,
                      child: _CountryCodeBox(
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                _FieldLabel(label: context.tr('password')),
                const SizedBox(height: 8),
                _AuthTextField(
                  controller: _passwordController,
                  hintText: context.tr('password_hint'),
                  obscureText: _obscurePassword,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return context.tr('please_enter_password');
                    }
                    return null;
                  },
                  prefixIcon: const Icon(Icons.lock, color: AppColors.authIconMuted, size: 18),
                  suffixIcon: IconButton(
                    onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      color: AppColors.authIcon,
                      size: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      context.tr('forget_password'),
                      style: AppTextStyle.rubikSemiBold12.copyWith(color: AppColors.primary),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: FilledButton(
                    onPressed: isLoading ? null : _submit,
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      disabledBackgroundColor: AppColors.primary.withOpacity(.55),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(color: AppColors.white, strokeWidth: 2),
                          )
                        : Text(
                            context.tr('login'),
                            style: AppTextStyle.rubikSemiBold14.copyWith(color: AppColors.white),
                          ),
                  ),
                ),
                const Spacer(flex: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      context.tr('dont_have_account'),
                      style: AppTextStyle.rubikRegular12.copyWith(color: AppColors.authHint),
                    ),
                    TextButton(
                      onPressed: () => context.go(AppRoutes.signUpScreen, extra: _phoneController.text),
                      child: Text(
                        context.tr('create_new_account_short'),
                        style: AppTextStyle.rubikSemiBold12.copyWith(color: AppColors.primary),
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
    );
  }

  void _onPhoneChanged(String value) {
    final normalized = value.replaceAll(RegExp(r'\D'), '');
    _phoneController.text = '963$normalized';
    ref.read(signInControllerProvider.notifier).checkPhoneFilled(normalized.isNotEmpty);
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    await ref.read(signInControllerProvider.notifier).signIn(_phoneController.text);
    ref.read(signInControllerProvider.notifier)
      ..makeResendButtonVisible(false)
      ..makeConfirmButtonVisible(true);
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

class _AuthTextField extends StatelessWidget {
  const _AuthTextField({
    required this.controller,
    required this.hintText,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    this.textAlign = TextAlign.start,
    this.prefixIcon,
    this.suffixIcon,
  });

  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final TextAlign textAlign;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      onChanged: onChanged,
      textAlign: textAlign,
      style: AppTextStyle.rubikRegular14.copyWith(color: AppColors.authTitle),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyle.rubikRegular12.copyWith(color: AppColors.authHint),
        filled: true,
        fillColor: AppColors.white,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
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
  const _CountryCodeBox({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
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
            Container(width: 18, height: 14, color: AppColors.authFlagPlaceholder),
          ],
        ),
      ),
    );
  }
}
