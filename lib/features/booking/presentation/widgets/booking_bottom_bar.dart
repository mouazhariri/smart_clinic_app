import 'package:flutter/material.dart';

class BookingBottomBar extends StatelessWidget {
  final double price;
  final String? selectedTime;
  final DateTime? selectedDate;
  final VoidCallback? onBookPressed;
  const BookingBottomBar({
    super.key,
    required this.price,
    this.selectedTime,
    this.selectedDate,
    this.onBookPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('السعر: $price ريال'),
                if (selectedTime != null) Text('الوقت: $selectedTime'),
                if (selectedDate != null) Text('التاريخ: ${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}'),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: onBookPressed,
            child: const Text('متابعة الحجز'),
          ),
        ],
      ),
    );
  }
}
