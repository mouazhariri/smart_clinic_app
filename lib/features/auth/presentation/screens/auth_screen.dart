import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:smart_clinic_app/src/application/router/app_routes.dart';
import 'package:smart_clinic_app/src/resourses/color_manager/app_colors.dart';
import 'package:smart_clinic_app/src/resourses/font_manager/app_text_style.dart';

class AuthLandingScreen extends StatelessWidget {
  const AuthLandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: [
              const Spacer(flex: 2),
              Container(
                width: 96,
                height: 96,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.medical_services_outlined,
                  color: AppColors.white,
                  size: 46,
                ),
              ),
              const SizedBox(height: 34),
              Text(
                context.tr('appName'),
                textAlign: TextAlign.center,
                style: AppTextStyle.rubikBold22.copyWith(
                  color: AppColors.authTitle,
                  fontSize: 30,
                  height: 1,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                context.tr('auth_landing_subtitle'),
                textAlign: TextAlign.center,
                style: AppTextStyle.rubikRegular14.copyWith(
                  color: AppColors.authSubtitle,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 28),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 10,
                runSpacing: 10,
                children: [
                  _FeatureChip(label: context.tr('trusted_doctors')),
                  _FeatureChip(label: context.tr('quick_booking')),
                  _FeatureChip(label: context.tr('safe_reliable')),
                ],
              ),
              const Spacer(flex: 3),
              _AuthActionButton(
                label: context.tr('create_new_account'),
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                onPressed: () => context.go(AppRoutes.signUpScreen, extra: ''),
              ),
              const SizedBox(height: 12),
              _AuthActionButton(
                label: context.tr('already_have_account_short'),
                backgroundColor: AppColors.authLightBlue,
                foregroundColor: AppColors.primary,
                onPressed: () => context.go(AppRoutes.signInScreen),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  const Expanded(child: Divider(color: AppColors.authDivider)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Text(
                      context.tr('or'),
                      style: AppTextStyle.rubikRegular12.copyWith(
                        color: AppColors.authHint,
                      ),
                    ),
                  ),
                  const Expanded(child: Divider(color: AppColors.authDivider)),
                ],
              ),
              const SizedBox(height: 18),
              _AuthActionButton(
                label: context.tr('continue_as_guest'),
                backgroundColor: AppColors.white,
                foregroundColor: AppColors.bodyColor,
                borderColor: AppColors.authInputBorder,
                onPressed: () => context.go(AppRoutes.homeScreen),
              ),
              const SizedBox(height: 28),
              Text.rich(
                TextSpan(
                  text: context.tr('auth_terms_prefix'),
                  children: [
                    TextSpan(text: context.tr('terms_of_use')),
                    TextSpan(text: context.tr('and_privacy_policy')),
                  ],
                ),
                textAlign: TextAlign.center,
                style: AppTextStyle.interRegular10.copyWith(
                  color: AppColors.authSubtitle,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureChip extends StatelessWidget {
  const _FeatureChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: AppColors.authLightBlue,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: AppTextStyle.rubikSemiBold12.copyWith(color: AppColors.primary),
      ),
    );
  }
}

class _AuthActionButton extends StatelessWidget {
  const _AuthActionButton({
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.onPressed,
    this.borderColor,
  });

  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color? borderColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 46,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          elevation: 0,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
            side: BorderSide(color: borderColor ?? backgroundColor),
          ),
        ),
        child: Text(
          label,
          style: AppTextStyle.rubikSemiBold14.copyWith(color: foregroundColor),
        ),
      ),
    );
  }
}
