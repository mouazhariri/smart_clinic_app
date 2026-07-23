import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_clinic_app/src/core/localization/current_language.dart';
import 'package:smart_clinic_app/src/resourses/color_manager/app_colors.dart';

import '../../../doctors/presentation/widgets/smart_clinic_app_bar.dart';
import '../widgets/language_option_tile.dart';

class ChangeLanguageScreen extends ConsumerWidget {
  const ChangeLanguageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLanguageCode = ref.watch(currentLanguageProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          SmartClinicAppBar(
            title: context.tr('change_language'),
            subtitle: context.tr('choose_preferred_language'),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              children: [
                // for (final language in AppLanguages.all)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: LanguageOptionTile(
                      // language: language,
                      isSelected:context.locale.languageCode == currentLanguageCode,
                      onTap: () => ref
                          .read(currentLanguageProvider.notifier)
                          .changeLanguage(context, currentLanguageCode),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}