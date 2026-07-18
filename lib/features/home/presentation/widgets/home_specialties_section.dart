import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../domain/model/specialty.dart';
import '../../domain/model/specialty_catalog.dart';
import 'home_section_header.dart';
import 'specialty_tile.dart';

class HomeSpecialtiesSection extends StatelessWidget {
  const HomeSpecialtiesSection({
    super.key,
    this.specialties ,
    this.onViewAll,
    this.onSpecialtyTap,
  });

  final List<Specialty>? specialties;

  final VoidCallback? onViewAll;

  final ValueChanged<Specialty>? onSpecialtyTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeSectionHeader(
          title: context.tr("specialties"),
          actionLabel: context.tr("view_all"),
          onAction: onViewAll,
        ),

        const SizedBox(height: 18),

        SizedBox(
          height: 111,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: specialties?.length?? SpecialtyCatalog.all.length,
            padding: EdgeInsets.zero,
            separatorBuilder: (_, __) => const SizedBox(width: 14),
            itemBuilder: (_, index) {
              final item = specialties?[index]?? SpecialtyCatalog.all[index];

              return SpecialtyTile(
                specialty: item,
                onTap: () => onSpecialtyTap?.call(item),
              );
            },
          ),
        ),
      ],
    );
  }
}