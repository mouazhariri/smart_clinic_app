import 'package:flutter/material.dart';

class ViewAppointmentButton extends StatelessWidget {
  final VoidCallback onPressed;
  const ViewAppointmentButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(onPressed: onPressed, child: const Text('عرض تفاصيل الموعد')),
    );
  }
}
