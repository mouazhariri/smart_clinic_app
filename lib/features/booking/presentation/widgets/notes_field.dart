import 'package:flutter/material.dart';

class NotesField extends StatelessWidget {
  final String value;
  final Function(String) onChanged;
  const NotesField({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        labelText: 'ملاحظات للطبيب (اختياري)',
        border: OutlineInputBorder(),
      ),
      maxLines: 3,
      controller: TextEditingController(text: value),
      onChanged: onChanged,
    );
  }
}
