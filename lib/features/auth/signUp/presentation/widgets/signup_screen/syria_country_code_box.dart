import 'package:flutter/material.dart';

import '../../../../../../gen/assets.gen.dart';
import '../../../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../../../src/resourses/font_manager/app_text_style.dart';

class SyriaCountryCodeBox extends StatelessWidget {
  const SyriaCountryCodeBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
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
            Assets.icons.syriaFlagIcon.svg(width: 18, height: 14),
          ],
        ),
      ),
    );
  }
}
