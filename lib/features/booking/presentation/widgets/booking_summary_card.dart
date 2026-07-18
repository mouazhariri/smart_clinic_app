import 'package:flutter/material.dart';

class BookingSummaryCard extends StatelessWidget {
  final String doctorName;
  final String clinicName;
  final String appointmentInfo;
  final VoidCallback? onEdit;

  const BookingSummaryCard({
    super.key,
    required this.doctorName,
    required this.clinicName,
    required this.appointmentInfo,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: Text(doctorName, style: Theme.of(context).textTheme.titleMedium)),
                if (onEdit != null)
                  TextButton(onPressed: onEdit, child: const Text('تعديل')),
              ],
            ),
            const SizedBox(height: 8),
            Text('عيادة $clinicName'),
            const SizedBox(height: 4),
            Text(appointmentInfo),
          ],
        ),
      ),
    );
  }
}
