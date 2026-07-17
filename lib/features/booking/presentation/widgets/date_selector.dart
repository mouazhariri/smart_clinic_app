import 'package:flutter/material.dart';

class DateSelector extends StatelessWidget {
  final List<DateTime> dates;
  final DateTime? selectedDate;
  final Function(DateTime) onSelect;
  final bool Function(DateTime) isDisabled;

  const DateSelector({
    super.key,
    required this.dates,
    this.selectedDate,
    required this.onSelect,
    required this.isDisabled,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dates.length,
        itemBuilder: (context, index) {
          final date = dates[index];
          final disabled = isDisabled(date);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: GestureDetector(
              onTap: disabled ? null : () => onSelect(date),
              child: Container(
                width: 60,
                decoration: BoxDecoration(
                  color: disabled ? Colors.grey.shade300 : (selectedDate == date ? Colors.blue : Colors.white),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: disabled ? Colors.grey : Colors.blue),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${date.day}', style: TextStyle(color: disabled ? Colors.grey : (selectedDate == date ? Colors.white : Colors.black), fontWeight: FontWeight.bold)),
                    Text('${_dayAbbr(date.weekday)}', style: TextStyle(color: disabled ? Colors.grey : (selectedDate == date ? Colors.white : Colors.black), fontSize: 10)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String _dayAbbr(int weekday) {
    const map = {1: 'Mon', 2: 'Tue', 3: 'Wed', 4: 'Thu', 5: 'Fri', 6: 'Sat', 7: 'Sun'};
    return map[weekday] ?? '';
  }
}
