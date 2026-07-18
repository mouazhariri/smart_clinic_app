import 'package:flutter/material.dart';

class AppointmentSummaryCard extends StatelessWidget {
  final String doctorName;
  final String clinicName;
  final DateTime date;
  final String time;
  final String bookingNumber;
  const AppointmentSummaryCard({
    super.key,
    required this.doctorName,
    required this.clinicName,
    required this.date,
    required this.time,
    required this.bookingNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(doctorName, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Row(children: [Icon(Icons.calendar_today, size: 16, color: Colors.blue), const SizedBox(width: 4), Text('${date.year}-${date.month}-${date.day}')]),
            const SizedBox(height: 4),
            Row(children: [Icon(Icons.access_time, size: 16, color: Colors.blue), const SizedBox(width: 4), Text(time)]),
            const SizedBox(height: 4),
            Text('عيادة $clinicName'),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
              child: Text(bookingNumber, style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
