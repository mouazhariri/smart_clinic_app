import 'package:flutter/material.dart';

class PaymentCard extends StatelessWidget {
  final String selectedPaymentName;
  final String selectedPaymentDescription;
  final VoidCallback? onEdit;

  const PaymentCard({
    super.key,
    required this.selectedPaymentName,
    required this.selectedPaymentDescription,
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
                Expanded(child: Text('طريقة الدفع', style: Theme.of(context).textTheme.titleSmall)),
                if (onEdit != null)
                  TextButton(onPressed: onEdit, child: const Text('تعديل')),
              ],
            ),
            const SizedBox(height: 8),
            Text(selectedPaymentName),
            Text(selectedPaymentDescription, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
