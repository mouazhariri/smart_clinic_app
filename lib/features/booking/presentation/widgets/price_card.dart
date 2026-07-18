import 'package:flutter/material.dart';

class PriceCard extends StatelessWidget {
  final double consultationFee;
  final double discount;
  final double total;

  const PriceCard({
    super.key,
    required this.consultationFee,
    this.discount = 0.0,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _row('سعر الكشفية', '${consultationFee.toStringAsFixed(0)} ريال'),
            const Divider(),
            _row('خصم', '${discount.toStringAsFixed(0)} ريال'),
            const Divider(),
            _row('الإجمالي', '${total.toStringAsFixed(0)} ريال', isBold: true),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: isBold ? const TextStyle(fontWeight: FontWeight.bold) : null),
        Text(value, style: isBold ? const TextStyle(fontWeight: FontWeight.bold) : null),
      ],
    );
  }
}
