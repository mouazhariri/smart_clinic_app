import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../src/resourses/color_manager/app_colors.dart';
import '../../../doctors/domain/entities/doctor.dart';
import 'doctor_filter_chip.dart';
import 'doctor_horizontal_card.dart';
import 'home_section_header.dart';

/// "Top doctors" section: a header, a row of filter chips and a horizontally
/// scrollable list of doctor cards. Owns the active filter (SRP).
class TopDoctorsSection extends StatefulWidget {
  const TopDoctorsSection({
    super.key,
    required this.doctors,
    this.onViewAll,
    this.filters = const [],
  });

  final List<Doctor> doctors;
  final VoidCallback? onViewAll;

  /// Extra filter chips (besides "Latest"); each maps to a [Doctor.specialty].
  final List<DoctorFilter> filters;

  @override
  State<TopDoctorsSection> createState() => _TopDoctorsSectionState();
}

class _TopDoctorsSectionState extends State<TopDoctorsSection> {
  int _selectedIndex = 0;

  List<Doctor> get _visible {
    if (_selectedIndex == 0) return widget.doctors;
    final active = widget.filters[_selectedIndex - 1];
    return widget.doctors.where((d) => d.specialty == active.specialty).toList();
  }

  @override
  Widget build(BuildContext context) {
    final chips = <DoctorFilter>[
      DoctorFilter(label: context.tr('latest'), specialty: ''),
      ...widget.filters,
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HomeSectionHeader(
          title: context.tr('top_doctors'),
          actionLabel: context.tr('view_all'),
          onAction: widget.onViewAll,
          useExtraBold: true,
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 36,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            itemCount: chips.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final chip = chips[index];
              return DoctorFilterChip(
                label: chip.labelKey == null
                    ? chip.label
                    : context.tr(chip.labelKey!),
                selected: index == _selectedIndex,
                onTap: () => setState(() => _selectedIndex = index),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 300,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            itemCount: _visible.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) =>
                DoctorHorizontalCard(doctor: _visible[index]),
          ),
        ),
      ],
    );
  }
}

/// Describes a filter chip for the doctors list.
class DoctorFilter {
  const DoctorFilter({required this.label, required this.specialty, this.labelKey});

  final String label;
  final String? labelKey;
  final String specialty;
}
