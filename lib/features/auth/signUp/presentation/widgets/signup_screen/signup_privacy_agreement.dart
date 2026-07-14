import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../../../src/resourses/font_manager/app_text_style.dart';

class SignupPrivacyAgreement extends StatelessWidget {
  const SignupPrivacyAgreement({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox.adaptive(
          value: value,
          onChanged: (checked) => onChanged(checked ?? false),
          activeColor: AppColors.primary,
          side: const BorderSide(color: AppColors.authInputBorder),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: GestureDetector(
            onTap: () => onChanged(!value),
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
    );
  }
}
