import 'package:flutter/material.dart';

class SuccessHeader extends StatelessWidget {
  final String title;
  final String description;
  const SuccessHeader({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle),
          child: const Icon(Icons.check, size: 60, color: Colors.white),
        ),
        const SizedBox(height: 24),
        Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(description, textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}
