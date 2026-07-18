import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_clinic_app/features/booking/domain/model/patient_information.dart';

import 'package:smart_clinic_app/src/resourses/color_manager/app_colors.dart';
import 'package:smart_clinic_app/src/resourses/font_manager/app_text_style.dart';
import '../controller/booking_controller.dart';

class PatientInformationSheet extends ConsumerStatefulWidget {
  const PatientInformationSheet({super.key});

  @override
  ConsumerState<PatientInformationSheet> createState() =>
      _PatientInformationSheetState();
}

class _PatientInformationSheetState
    extends ConsumerState<PatientInformationSheet> {
  final _dateController = TextEditingController();
  String? _selectedCity;
  String? _selectedGender;
  DateTime? _pickedDate;

  final List<String> _cities = [
    'Damascus', 'Aleppo', 'Homs', 'Latakia', 'Hama',
    'Tartus', 'Deir ez-Zor', 'Raqqa', 'Daraa', 'Suwayda',
  ];

  @override
  void initState() {
    super.initState();
    final info =
        ref.read(bookingControllerProvider).patientInformation;
    if (info != null) {
      _pickedDate = info.birthDate;
      if (_pickedDate != null) {
        _dateController.text =
            '${_pickedDate!.day.toString().padLeft(2, '0')}/'
            '${_pickedDate!.month.toString().padLeft(2, '0')}/'
            '${_pickedDate!.year}';
      }
      _selectedCity = info.city;
      _selectedGender = info.gender;
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
          Center(child: _handle()),
          const SizedBox(height: 20),
      
          // Header row
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.close,
                    color: AppColors.authTitle, size: 22),
              ),
              const Spacer(),
              Text(
                context.tr('last_step'),
                style: AppTextStyle.tajawalBold18
                    .copyWith(color: AppColors.authTitle),
              ),
              const Spacer(),
              const SizedBox(width: 22),
            ],
          ),
          const SizedBox(height: 8),
      
          Text(
            context.tr('last_step_body'),
            style: AppTextStyle.tajawalRegular14.copyWith(
              color: AppColors.authSubtitle,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 20),
      
          // Birth date
          _FieldLabel(context.tr('birth_date')),
          const SizedBox(height: 6),
          GestureDetector(
            onTap: () => _pickDate(context),
            child: AbsorbPointer(
              child: _StyledTextField(
                controller: _dateController,
                hint: context.tr('birth_date_hint'),
                suffixIcon: Icons.calendar_today_outlined,
              ),
            ),
          ),
          const SizedBox(height: 16),
      
          // City
          _FieldLabel(context.tr('city')),
          const SizedBox(height: 6),
          _CityDropdown(
            cities: _cities,
            selected: _selectedCity,
            hint: context.tr('city_hint'),
            onChanged: (val) => setState(() => _selectedCity = val),
          ),
          const SizedBox(height: 16),
      
          // Gender
          _FieldLabel(context.tr('gender')),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: _GenderButton(
                  label: context.tr('male'),
                  icon: Icons.male,
                  selected: _selectedGender == 'Male',
                  onTap: () => setState(() => _selectedGender = 'Male'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _GenderButton(
                  label: context.tr('female'),
                  icon: Icons.female,
                  selected: _selectedGender == 'Female',
                  onTap: () => setState(() => _selectedGender = 'Female'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
      
          // Save button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: _save,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
              child: Text(context.tr('save_info'),
                  style: AppTextStyle.tajawalBold16
                      .copyWith(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _pickedDate ?? DateTime(1990),
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _pickedDate = picked;
        _dateController.text =
            '${picked.day.toString().padLeft(2, '0')}/'
            '${picked.month.toString().padLeft(2, '0')}/'
            '${picked.year}';
      });
    }
  }

  void _save() {
    ref.read(bookingControllerProvider.notifier).updatePatientInfo(
      // PatientInformation()
          birthDate: _pickedDate,
          city: _selectedCity,
          gender: _selectedGender,
        );
    Navigator.pop(context);
  }

  Widget _handle() => Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: AppColors.dashNeutralBg,
          borderRadius: BorderRadius.circular(2),
        ),
      );
}

// Helpers
class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: AppTextStyle.tajawalSemiBold14
            .copyWith(color: AppColors.authTitle));
  }
}

class _StyledTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hint;
  final IconData? suffixIcon;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;

  const _StyledTextField({
    this.controller,
    required this.hint,
    this.suffixIcon,
    this.keyboardType,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      onChanged: onChanged,
      style: AppTextStyle.tajawalRegular14.copyWith(color: AppColors.authTitle),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTextStyle.tajawalRegular14
            .copyWith(color: AppColors.authHint),
        suffixIcon: suffixIcon != null
            ? Icon(suffixIcon, color: AppColors.authHint, size: 18)
            : null,
        filled: true,
        fillColor: AppColors.dashNeutralBg,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class _CityDropdown extends StatelessWidget {
  final List<String> cities;
  final String? selected;
  final String hint;
  final ValueChanged<String?> onChanged;

  const _CityDropdown({
    required this.cities,
    required this.selected,
    required this.hint,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: AppColors.dashNeutralBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selected,
          hint: Text(hint,
              style: AppTextStyle.tajawalRegular14
                  .copyWith(color: AppColors.authHint)),
          isExpanded: true,
          icon:
              const Icon(Icons.keyboard_arrow_down, color: AppColors.authHint),
          items: cities
              .map((c) => DropdownMenuItem(
                    value: c,
                    child: Text(c,
                        style: AppTextStyle.tajawalRegular14
                            .copyWith(color: AppColors.authTitle)),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class _GenderButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _GenderButton({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color:
              selected ? AppColors.primary : AppColors.dashNeutralBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected
                ? AppColors.primary
                : Colors.transparent,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                size: 20,
                color: selected ? Colors.white : AppColors.authSubtitle),
            const SizedBox(width: 6),
            Text(label,
                style: AppTextStyle.tajawalSemiBold14.copyWith(
                    color: selected ? Colors.white : AppColors.authSubtitle)),
          ],
        ),
      ),
    );
  }
}