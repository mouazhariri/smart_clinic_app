import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/enums/payment_type.dart';
import '../../domain/model/payment_method.dart';
import '../controller/booking_controller.dart';

class PaymentMethodSheet extends ConsumerStatefulWidget {
  const PaymentMethodSheet({super.key});

  @override
  ConsumerState<PaymentMethodSheet> createState() => _PaymentMethodSheetState();
}

class _PaymentMethodSheetState extends ConsumerState<PaymentMethodSheet> {
  int? selectedIndex;

  final List<PaymentMethod> methods = const [
    PaymentMethod(
      id: 'cash',
      name: 'الدفع نقداً',
      icon: 'cash',
      description: 'الدفع نقداً في العيادة',
      type: PaymentType.cash,
    ),
    PaymentMethod(
      id: 'cash_wallet',
      name: 'المحفظة النقدية',
      icon: 'wallet',
      description: 'الدفع من المحفظة النقدية',
      type: PaymentType.cashWallet,
    ),
    PaymentMethod(
      id: 'visa',
      name: 'بطاقة فيزا',
      icon: 'credit_card',
      description: 'الدفع ببطاقة فيزا',
      type: PaymentType.visa,
    ),
    PaymentMethod(
      id: 'insurance',
      name: 'تأمين صحي',
      icon: 'shield',
      description: 'الدفع عن طريق التأمين',
      type: PaymentType.insurance,
    ),
  ];

  @override
  void initState() {
    super.initState();
    final current = ref.read(bookingControllerProvider).selectedPaymentMethod;
    if (current != null) {
      selectedIndex = methods.indexWhere((m) => m.id == current.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          const Text('طريقة الدفع', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          ...List.generate(methods.length, (index) {
            final method = methods[index];
            return ListTile(
              leading: Radio<int>(
                value: index,
                groupValue: selectedIndex,
                onChanged: (val) {
                  setState(() => selectedIndex = val);
                },
              ),
              title: Text(method.name),
              subtitle: Text(method.description, style: Theme.of(context).textTheme.bodySmall),
              onTap: () {
                setState(() => selectedIndex = index);
              },
            );
          }),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: selectedIndex != null
                  ? () {
                      ref.read(bookingControllerProvider.notifier).selectPayment(
                            methods[selectedIndex!],
                          );
                      Navigator.pop(context);
                    }
                  : null,
              child: const Text('متابعة'),
            ),
          ),
        ],
      ),
    );
  }
}
