import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../src/core/localization/current_language.dart';
import '../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../src/resourses/font_manager/app_text_style.dart';

class LanguageSelectorDialog extends ConsumerWidget {
  const LanguageSelectorDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => const LanguageSelectorDialog(),
    );
  }

  Widget _option(
    BuildContext context,
    WidgetRef ref, {
    required String code,
    required String label,
    required String currentCode,
  }) {
    final selected = currentCode == code;
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () {
        ref.read(currentLanguageProvider.notifier).changeLanguage(context, code);
        Navigator.of(context).pop();
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary.withOpacity(0.08) : AppColors.background,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: selected ? AppColors.primary : AppColors.border),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: AppTextStyle.interSemiBold14.copyWith(
                  color: selected ? AppColors.primary : AppColors.textPrimary,
                ),
              ),
            ),
            if (selected) const Icon(Icons.check_circle_rounded, color: AppColors.primary, size: 20),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentCode = ref.watch(currentLanguageProvider);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(context.tr('select_language'), style: AppTextStyle.interBold18),
            const SizedBox(height: 18),
            _option(context, ref, code: 'en', label: context.tr('english_language'), currentCode: currentCode),
            _option(context, ref, code: 'ar', label: context.tr('arabic_language'), currentCode: currentCode),
          ],
        ),
      ),
    );
  }
}