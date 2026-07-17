import 'package:flutter/material.dart';

class AddCalendarButton extends StatelessWidget {
  final VoidCallback onPressed;
  const AddCalendarButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(onPressed: onPressed, child: const Text('إضافة إلى التقويم')),
    );
  }
}
