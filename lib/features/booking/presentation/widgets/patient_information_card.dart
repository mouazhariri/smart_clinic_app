import 'package:flutter/material.dart';

class PatientInformationCard extends StatelessWidget {
  final String? birthDate;
  final String? gender;
  final String? city;
  final VoidCallback? onEdit;

  const PatientInformationCard({
    super.key,
    this.birthDate,
    this.gender,
    this.city,
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
                Expanded(child: Text('معلومات المريض', style: Theme.of(context).textTheme.titleSmall)),
                if (onEdit != null)
                  TextButton(onPressed: onEdit, child: const Text('تعديل')),
              ],
            ),
            const SizedBox(height: 8),
            if (birthDate != null) Text('تاريخ الميلاد: $birthDate'),
            if (city != null) Text('المدينة: $city'),
            if (gender != null) Text('الجنس: $gender'),
          ],
        ),
      ),
    );
  }
}
