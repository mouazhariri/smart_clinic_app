import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../domain/model/specialty.dart';
import '../../domain/model/specialty_catalog.dart';
import 'home_section_header.dart';
import 'specialty_tile.dart';

/// Specialties section: a header followed by a horizontally scrollable list.
class HomeSpecialtiesSection extends StatelessWidget {
  const HomeSpecialtiesSection({
    super.key,
    this.specialties = SpecialtyCatalog.all,
    this.onViewAll,
    this.onSpecialtyTap,
  });

  final List<Specialty> specialties;
  final VoidCallback? onViewAll;
  final ValueChanged<Specialty>? onSpecialtyTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HomeSectionHeader(
          title: context.tr('specialties'),
          actionLabel: context.tr('view_all'),
          onAction: onViewAll,
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 112,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            itemCount: specialties.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final specialty = specialties[index];
              return SpecialtyTile(
                specialty: specialty,
                onTap: onSpecialtyTap == null ? null : () => onSpecialtyTap!(specialty),
              );
            },
          ),
        ),
      ],
    );
  }
}
