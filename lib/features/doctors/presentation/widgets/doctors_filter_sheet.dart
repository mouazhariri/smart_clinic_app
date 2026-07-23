import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../src/resourses/font_manager/app_text_style.dart';
import '../controller/doctors_state.dart';

class DoctorsFilterSheet extends StatefulWidget {
  final DoctorFilter currentFilter;
  final int totalResults;
  final ValueChanged<DoctorFilter> onApply;
  final VoidCallback onClear;

  const DoctorsFilterSheet({
    super.key,
    required this.currentFilter,
    required this.totalResults,
    required this.onApply,
    required this.onClear,
  });

  @override
  State<DoctorsFilterSheet> createState() => _DoctorsFilterSheetState();
}

class _DoctorsFilterSheetState extends State<DoctorsFilterSheet> {
  late AvailabilityFilter _availability;
  late GenderFilter _gender;
  late Set<int> _minRatings;
  final _minPriceController = TextEditingController();
  final _maxPriceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _availability = widget.currentFilter.availability;
    _gender = widget.currentFilter.gender;
    _minRatings = Set.from(widget.currentFilter.minRatings);
    if (widget.currentFilter.minPrice != null) {
      _minPriceController.text =
          widget.currentFilter.minPrice!.toStringAsFixed(0);
    }
    if (widget.currentFilter.maxPrice != null) {
      _maxPriceController.text =
          widget.currentFilter.maxPrice!.toStringAsFixed(0);
    }
  }

  @override
  void dispose() {
    _minPriceController.dispose();
    _maxPriceController.dispose();
    super.dispose();
  }

  DoctorFilter get _currentFilter => DoctorFilter(
        availability: _availability,
        gender: _gender,
        minRatings: _minRatings,
        minPrice: _minPriceController.text.isNotEmpty
            ? double.tryParse(_minPriceController.text)
            : null,
        maxPrice: _maxPriceController.text.isNotEmpty
            ? double.tryParse(_maxPriceController.text)
            : null,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.fromLTRB(
        20,
        20,
        20,
        MediaQuery.of(context).padding.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ───────────────────────────────────────────────
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.close_rounded,
                    color: AppColors.authTitle),
              ),
              const Spacer(),
              Text(
                context.tr('filter_results'),
                style: AppTextStyle.tajawalBold18
                    .copyWith(color: AppColors.authTitle),
              ),
              const Spacer(),
              const SizedBox(width: 24),
            ],
          ),
          const SizedBox(height: 20),

          Flexible(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Availability ────────────────────────────────
                  _SectionLabel(context.tr('available_appointments')),
                  const SizedBox(height: 10),
                  _SegmentRow(
                    options: [
                      context.tr('all'),
                      context.tr('today'),
                      context.tr('tomorrow'),
                      context.tr('this_week'),
                    ],
                    selected: _availability.index,
                    onSelect: (i) => setState(() =>
                        _availability = AvailabilityFilter.values[i]),
                  ),
                  const SizedBox(height: 20),

                  // ── Gender ──────────────────────────────────────
                  _SectionLabel(context.tr('doctor_gender')),
                  const SizedBox(height: 10),
                  _SegmentRow(
                    options: [
                      context.tr('all'),
                      context.tr('doctor_male'),
                      context.tr('doctor_female'),
                    ],
                    selected: _gender.index,
                    onSelect: (i) => setState(
                        () => _gender = GenderFilter.values[i]),
                  ),
                  const SizedBox(height: 20),

                  // ── Rating ──────────────────────────────────────
                  _SectionLabel(context.tr('rating')),
                  const SizedBox(height: 10),
                  ...[5, 4, 3, 2, 1].map((stars) {
                    final checked = _minRatings.contains(stars);
                    return _RatingCheckRow(
                      stars: stars,
                      checked: checked,
                      onToggle: (val) {
                        setState(() {
                          if (val) {
                            _minRatings.add(stars);
                          } else {
                            _minRatings.remove(stars);
                          }
                        });
                      },
                    );
                  }),
                  const SizedBox(height: 20),

                  // ── Price range ─────────────────────────────────
                  _SectionLabel(context.tr('consultation_price')),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: _PriceField(
                          controller: _maxPriceController,
                          hint: context.tr('max_price'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _PriceField(
                          controller: _minPriceController,
                          hint: context.tr('min_price'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),

          // ── Footer buttons ────────────────────────────────────────
          Row(
            children: [
              // Clear all — red text
              TextButton(
                onPressed: () {
                  widget.onClear();
                  Navigator.pop(context);
                },
                child: Text(
                  context.tr('clear_all'),
                  style: AppTextStyle.tajawalBold16.copyWith(
                    color: const Color(0xFFE53935),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Show results — blue button with count
              Expanded(
                child: SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onApply(_currentFilter);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      '${context.tr('show_results')} ${widget.totalResults} ${context.tr('doctor_count_label')}',
                      style: AppTextStyle.tajawalBold16.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Section label ──────────────────────────────────────────────────────────
class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        text,
        style: AppTextStyle.tajawalBold16.copyWith(
          color: AppColors.authTitle,
        ),
      ),
    );
  }
}

// ── Segment row (pill toggles) ─────────────────────────────────────────────
class _SegmentRow extends StatelessWidget {
  final List<String> options;
  final int selected;
  final ValueChanged<int> onSelect;

  const _SegmentRow({
    required this.options,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: options.asMap().entries.map((e) {
        final i = e.key;
        final label = e.value;
        final isSelected = selected == i;
        return Expanded(
          child: GestureDetector(
            onTap: () => onSelect(i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              margin: EdgeInsets.only(right: i < options.length - 1 ? 6 : 0),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary
                    : const Color(0xFFF5F6FA),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isSelected
                      ? AppColors.primary
                      : const Color(0xFFE0E0E0),
                ),
              ),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: AppTextStyle.tajawalRegular12.copyWith(
                  color: isSelected ? Colors.white : AppColors.authTitle,
                  fontWeight:
                      isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

// ── Rating check row ───────────────────────────────────────────────────────
class _RatingCheckRow extends StatelessWidget {
  final int stars;
  final bool checked;
  final ValueChanged<bool> onToggle;

  const _RatingCheckRow({
    required this.stars,
    required this.checked,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onToggle(!checked),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            // Custom checkbox
            AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: checked ? AppColors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: checked
                      ? AppColors.primary
                      : const Color(0xFFCCCCCC),
                  width: 1.5,
                ),
              ),
              child: checked
                  ? const Icon(Icons.check,
                      size: 14, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 12),

            // Stars visual
            Row(
              children: List.generate(
                5,
                (i) => Icon(
                  i < stars ? Icons.star_rounded : Icons.star_rounded,
                  size: 20,
                  color: i < stars
                      ? const Color(0xFFFFC107)
                      : const Color(0xFFE0E0E0),
                ),
              ),
            ),
            const SizedBox(width: 8),

            // Label
            Text(
              stars == 5
                  ? context.tr('five_stars')
                  : '${context.tr('rating_above', args: [stars.toString()])}',
              style: AppTextStyle.tajawalRegular14.copyWith(
                color: checked
                    ? AppColors.primary
                    : AppColors.authSubtitle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Price input field ──────────────────────────────────────────────────────
class _PriceField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  const _PriceField({
    required this.controller,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F6FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: AppTextStyle.tajawalRegular14
            .copyWith(color: AppColors.authTitle),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: AppTextStyle.tajawalRegular14
              .copyWith(color: const Color(0xFFBBBBBB)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }
}