import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../src/core/shared_widgets/app_loader.dart';
import '../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../src/resourses/font_manager/app_text_style.dart';
import '../controller/doctors_controller.dart';
import '../controller/doctors_state.dart';
import '../widgets/doctor_card_widget.dart';
import '../widgets/doctors_filter_sheet.dart';
import '../widgets/smart_clinic_app_bar.dart';

class DoctorsScreen extends ConsumerStatefulWidget {
  const DoctorsScreen({super.key});

  @override
  ConsumerState<DoctorsScreen> createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends ConsumerState<DoctorsScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openFilterSheet(DoctorsState state) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DoctorsFilterSheet(
        currentFilter: state.filter,
        totalResults: state.filteredDoctors.length,
        onApply: (filter) {
          ref.read(doctorsControllerProvider.notifier).applyFilter(filter);
        },
        onClear: () {
          ref.read(doctorsControllerProvider.notifier).clearFilter();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final asyncState = ref.watch(doctorsControllerProvider);
    final state = asyncState.value ?? DoctorsState.init();
    final controller = ref.read(doctorsControllerProvider.notifier);
    final filter = state.filter;

    // Active chip labels
    final activeChips = filter.activeChipLabels(
      allAvailLabel: '',
      todayLabel: context.tr('today'),
      tomorrowLabel: context.tr('tomorrow'),
      thisWeekLabel: context.tr('this_week'),
      maleLabel: context.tr('doctor_male'),
      femaleLabel: context.tr('doctor_female'),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SmartClinicAppBar(
            title: context.tr('doctors'),
            subtitle: context.tr('find_your_doctor'),
          ),

          // ── Search + Filter row ──────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Row(
              children: [
                // Filter button (blue when active)

                // Search field
                Expanded(
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFEEEEEE)),
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: controller.updateSearchQuery,
                      style: AppTextStyle.tajawalRegular14.copyWith(
                        color: AppColors.authTitle,
                      ),
                      decoration: InputDecoration(
                        hintText: context.tr('search_doctor'),
                        hintStyle: AppTextStyle.tajawalRegular14.copyWith(
                          color: const Color(0xFFBBBBBB),
                        ),
                        prefixIcon: const Icon(
                          Icons.search_rounded,
                          color: Color(0xFFBBBBBB),
                          size: 20,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                GestureDetector(
                  onTap: () => _openFilterSheet(state),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: filter.hasActiveFilters
                          ? AppColors.primary
                          : AppColors.primary,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.tune_rounded,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Active filter chips ──────────────────────────────────
          if (activeChips.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    // Availability chip
                    if (filter.availability != AvailabilityFilter.all)
                      _FilterChip(
                        label: _availLabel(context, filter.availability),
                        onRemove: controller.removeAvailabilityFilter,
                      ),
                    if (filter.availability != AvailabilityFilter.all &&
                        filter.gender != GenderFilter.all)
                      const SizedBox(width: 8),

                    // Gender chip
                    if (filter.gender != GenderFilter.all)
                      _FilterChip(
                        label: filter.gender == GenderFilter.male
                            ? context.tr('doctor_male')
                            : context.tr('doctor_female'),
                        onRemove: controller.removeGenderFilter,
                      ),
                  ],
                ),
              ),
            ),

          // ── Results count ────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '${context.tr('found')} ',
                    style: AppTextStyle.tajawalRegular14.copyWith(
                      color: AppColors.authSubtitle,
                    ),
                  ),
                  TextSpan(
                    text: '${state.filteredDoctors.length} ',
                    style: AppTextStyle.tajawalBold14.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  TextSpan(
                    text: context.tr('doctor_count_label'),
                    style: AppTextStyle.tajawalBold14.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Doctor list ──────────────────────────────────────────
          Expanded(
            child: asyncState.isLoading
                ? const Center(child: AppLoader())
                : state.filteredDoctors.isEmpty
                ? _EmptyState()
                : RefreshIndicator(
                    onRefresh: controller.getDoctors,
                    child: ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                      itemCount: state.filteredDoctors.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        return DoctorCardWidget(
                          doctor: state.filteredDoctors[index],
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  String _availLabel(BuildContext context, AvailabilityFilter f) {
    switch (f) {
      case AvailabilityFilter.today:
        return context.tr('today');
      case AvailabilityFilter.tomorrow:
        return context.tr('tomorrow');
      case AvailabilityFilter.thisWeek:
        return context.tr('this_week');
      case AvailabilityFilter.all:
        return '';
    }
  }
}

// ── Active filter chip ─────────────────────────────────────────────────────
class _FilterChip extends StatelessWidget {
  final String label;
  final VoidCallback onRemove;

  const _FilterChip({required this.label, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withOpacity(0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: onRemove,
            child: const Icon(
              Icons.close_rounded,
              size: 14,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: AppTextStyle.tajawalRegular12.copyWith(
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Empty state ────────────────────────────────────────────────────────────
class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.search_off_rounded,
            size: 64,
            color: Color(0xFFCCCCCC),
          ),
          const SizedBox(height: 16),
          Text(
            context.tr('no_doctors_found'),
            style: AppTextStyle.tajawalBold16.copyWith(
              color: AppColors.authSubtitle,
            ),
          ),
        ],
      ),
    );
  }
}
