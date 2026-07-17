import 'package:flutter/material.dart';

class TimeSelector extends StatelessWidget {
  final List<String> times;
  final String? selectedTime;
  final Function(String) onSelect;

  const TimeSelector({
    super.key,
    required this.times,
    this.selectedTime,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: times.map((time) {
        final isSelected = selectedTime == time;
        return ChoiceChip(
          label: Text(time),
          selected: isSelected,
          onSelected: (val) {
            if (val) onSelect(time);
          },
        );
      }).toList(),
    );
  }
}
