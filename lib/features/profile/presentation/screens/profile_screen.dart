import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../src/application/router/app_routes.dart';
import '../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../src/resourses/font_manager/app_text_style.dart';
import '../../../doctors/presentation/widgets/smart_clinic_app_bar.dart';
import '../controller/profile_controller.dart';
import '../controller/profile_state.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState =
        ref.watch(profileControllerProvider).valueOrNull ?? ProfileState.init();
    final profile = profileState.profile.valueOrNull;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          SmartClinicAppBar(
            title: context.tr('profile'),
            subtitle: context.tr('manage_personal_information'),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
              children: [
                Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 92,
                        height: 92,
                        decoration: BoxDecoration(
                          color: AppColors.primaryBg,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Icon(Icons.person, size: 48, color: AppColors.primary),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        context.tr(profile?.fullNameKey ?? 'sample_user_full_name'),
                        style: AppTextStyle.interBold20,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        context.tr(profile?.emailKey ?? 'sample_user_email'),
                        style: AppTextStyle.interRegular14.copyWith(color: AppColors.textSecondary),
                      ),
                      const SizedBox(height: 18),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.edit_outlined),
                          label: Text(context.tr('edit_profile')),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                _ProfileTile(
                  icon: Icons.phone_outlined,
                  title: context.tr('phone_number'),
                  value: context.tr(profile?.phoneKey ?? 'sample_user_phone'),
                ),
                _ProfileTile(
                  icon: Icons.language_outlined,
                  title: context.tr('language'),
                  value: context.locale.languageCode == 'ar' ? 'العربية' : 'English',
                ),
                _ProfileTile(
                  icon: Icons.dark_mode_outlined,
                  title: context.tr('theme'),
                  value: context.tr(profile?.themeKey ?? 'system_default'),
                ),
                _ProfileTile(
                  icon: Icons.logout_rounded,
                  title: context.tr('logout'),
                  value: '',
                  danger: true,
                  onTap: () async {
                    await ref.read(profileControllerProvider.notifier).logout();
                    if (context.mounted) {
                      context.go(AppRoutes.signInScreen);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  const _ProfileTile({
    required this.icon,
    required this.title,
    required this.value,
    this.danger = false,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String value;
  final bool danger;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(icon, color: danger ? AppColors.errorRed : AppColors.primary),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: AppTextStyle.interMedium16.copyWith(
                  color: danger ? AppColors.errorRed : AppColors.textPrimary,
                ),
              ),
            ),
            if (value.isNotEmpty)
              Text(
                value,
                style: AppTextStyle.interRegular14.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
