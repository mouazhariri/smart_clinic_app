import 'package:flutter/material.dart';

class PolicyCard extends StatelessWidget {
  final String cancellationPolicy;
  final String reschedulePolicy;

  const PolicyCard({
    super.key,
    this.cancellationPolicy = 'يرجى الحضور قبل الموعد بـ 15 دقيقة.',
    this.reschedulePolicy = 'في حال الإلغاء يرجى إبلاغنا قبل 24 ساعة.',
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('سياسة الإلغاء وإعادة الجدولة', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('• $cancellationPolicy', style: Theme.of(context).textTheme.bodySmall),
            Text('• $reschedulePolicy', style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
