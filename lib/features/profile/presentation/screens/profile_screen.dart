import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../src/application/router/app_routes.dart';
import '../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../src/resourses/font_manager/app_text_style.dart';
import '../../../doctors/presentation/widgets/smart_clinic_app_bar.dart';
import '../../domain/entities/profile_menu_action.dart';
import '../../domain/entities/profile_menu_item.dart';
import '../../domain/entities/profile_menu_section.dart';
import '../controller/profile_controller.dart';
import '../controller/profile_state.dart';
import '../widgets/language_selector_dialog.dart';
import '../widgets/profile_header_card.dart';
import '../widgets/profile_menu_section_widget.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  List<ProfileMenuSection> _sections() {
    return const [
      ProfileMenuSection(
        titleKey: 'account_settings',
        items: [
          ProfileMenuItem(
            icon: Icons.person_outline_rounded,
            titleKey: 'personal_information',
            action: ProfileMenuAction.personalInformation,
          ),
          ProfileMenuItem(
            icon: Icons.lock_outline_rounded,
            titleKey: 'security_password',
            action: ProfileMenuAction.securityPassword,
          ),
        ],
      ),
      ProfileMenuSection(
        titleKey: 'preferences',
        items: [
          ProfileMenuItem(
            icon: Icons.notifications_outlined,
            titleKey: 'notifications_alerts',
            action: ProfileMenuAction.notifications,
          ),
          ProfileMenuItem(
            icon: Icons.translate_rounded,
            titleKey: 'app_language',
            action: ProfileMenuAction.language,
          ),
        ],
      ),
      ProfileMenuSection(
        titleKey: 'others',
        items: [
          ProfileMenuItem(
            icon: Icons.help_outline_rounded,
            titleKey: 'help_support',
            action: ProfileMenuAction.helpSupport,
          ),
          ProfileMenuItem(
            icon: Icons.handshake_outlined,
            titleKey: 'terms_and_privacy',
            action: ProfileMenuAction.termsAndPrivacy,
          ),
          ProfileMenuItem(
            icon: Icons.logout_rounded,
            titleKey: 'logout',
            action: ProfileMenuAction.logout,
            isDanger: true,
            showChevron: false,
          ),
        ],
      ),
    ];
  }

  Future<bool?> _confirmLogout(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(context.tr('logout'), style: AppTextStyle.interBold18),
        content: Text(context.tr('logout_confirmation_message'), style: AppTextStyle.interRegular14),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(context.tr('cancel'))),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(context.tr('logout'), style: const TextStyle(color: AppColors.errorRed)),
          ),
        ],
      ),
    );
  }

  Future<void> _onMenuTap(BuildContext context, WidgetRef ref, ProfileMenuAction action) async {
    switch (action) {
      case ProfileMenuAction.language:
        LanguageSelectorDialog.show(context);
        break;
      case ProfileMenuAction.termsAndPrivacy:
        context.push(AppRoutes.termsPrivacyScreen);
        break;
      case ProfileMenuAction.logout:
        final confirmed = await _confirmLogout(context);
        if (confirmed != true) return;
        await ref.read(profileControllerProvider.notifier).logout();
        if (context.mounted) context.go(AppRoutes.signInScreen);
        break;
      case ProfileMenuAction.personalInformation:
        // TODO: navigate to personal information screen
        break;
      case ProfileMenuAction.securityPassword:
        // TODO: navigate to security & password screen
        break;
      case ProfileMenuAction.notifications:
        // TODO: navigate to notifications settings screen
        break;
      case ProfileMenuAction.helpSupport:
        // TODO: navigate to help & support screen
        break;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileControllerProvider).value ?? ProfileState.init();
    final profile = profileState.profile.value;
    final isLoading = profileState.profile.isLoading;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          SmartClinicAppBar(
            title: context.tr('profile'),
            subtitle: context.tr('manage_personal_information'),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => ref.read(profileControllerProvider.notifier).getProfile(),
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                children: [
                  ProfileHeaderCard(profile: profile, isLoading: isLoading),
                  const SizedBox(height: 22),
                  for (final section in _sections()) ...[
                    ProfileMenuSectionWidget(
                      section: section,
                      onItemTap: (item) => _onMenuTap(context, ref, item.action),
                    ),
                    const SizedBox(height: 18),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}