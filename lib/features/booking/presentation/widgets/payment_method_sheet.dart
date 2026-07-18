import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:smart_clinic_app/src/resourses/color_manager/app_colors.dart';
import 'package:smart_clinic_app/src/resourses/font_manager/app_text_style.dart';
import '../../domain/model/payment_method.dart';
import '../controller/booking_controller.dart';
import '../controller/booking_state.dart';

class PaymentMethodSheet extends ConsumerStatefulWidget {
  const PaymentMethodSheet({super.key});

  @override
  ConsumerState<PaymentMethodSheet> createState() => _PaymentMethodSheetState();
}

class _PaymentMethodSheetState extends ConsumerState<PaymentMethodSheet> {
  PaymentMethod? _selected;

  @override
  void initState() {
    super.initState();
    _selected = ref.read(bookingControllerProvider).selectedPaymentMethod;
  }

  @override
  Widget build(BuildContext context) {
    final methods = [
      _MethodOption(
        method: const PaymentMethod(
          name: 'Syriatel Cash',
          description: 'Pay via electronic payment', id: '1', icon: '',
        ),
        icon: Icons.phone_android_outlined,
        localNameKey: 'syriatel_cash',
        localSubKey: 'syriatel_cash_sub',
      ),
      _MethodOption(
        method: const PaymentMethod(
          name: 'MTN Cash',
          description: 'Pay via electronic payment', id: '2', icon: '',
        ),
        icon: Icons.smartphone_outlined,
        localNameKey: 'mtn_cash',
        localSubKey: 'mtn_cash_sub',
      ),
      _MethodOption(
        method: const PaymentMethod(
          name: 'Cash at Clinic',
          description: 'Pay cash when you arrive', id: '3', icon: '',
        ),
        icon: Icons.payments_outlined,
        localNameKey: 'cash_in_clinic',
        localSubKey: 'cash_in_clinic_sub',
      ),
    ];

    return Container(
      padding: EdgeInsets.fromLTRB(
          20, 20, 20, MediaQuery.of(context).padding.bottom + 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle + close
          Center(child: _handle()),
          const SizedBox(height: 16),
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.close,
                    color: AppColors.authTitle, size: 22),
              ),
              const Spacer(),
              Text(
                context.tr('payment_method'),
                style: AppTextStyle.tajawalBold18
                    .copyWith(color: AppColors.authTitle),
              ),
              const Spacer(),
              const SizedBox(width: 22),
            ],
          ),
          const SizedBox(height: 20),
      
          // Payment options
          ...methods.map((opt) => _PaymentTile(
                option: opt,
                selected: _selected?.name == opt.method.name,
                onTap: () => setState(() => _selected = opt.method),
              )),
          const SizedBox(height: 20),
      
          // Confirm button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () {
                if (_selected != null) {
                  ref
                      .read(bookingControllerProvider.notifier)
                      .selectPaymentMethod(_selected!);
                }
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
              child: Text(context.tr('confirm_payment_method'),
                  style: AppTextStyle.tajawalBold16
                      .copyWith(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _handle() => Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: AppColors.dashNeutralBg,
          borderRadius: BorderRadius.circular(2),
        ),
      );
}

class _MethodOption {
  final PaymentMethod method;
  final IconData icon;
  final String localNameKey;
  final String localSubKey;

  const _MethodOption({
    required this.method,
    required this.icon,
    required this.localNameKey,
    required this.localSubKey,
  });
}

class _PaymentTile extends StatelessWidget {
  final _MethodOption option;
  final bool selected;
  final VoidCallback onTap;

  const _PaymentTile({
    required this.option,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary.withOpacity(0.06)
              : AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected
                ? AppColors.primary
                : AppColors.dashNeutralBg,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            // Radio indicator
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? AppColors.primary : AppColors.authHint,
                  width: 2,
                ),
              ),
              child: selected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 14),

            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.tr(option.localNameKey),
                    style: AppTextStyle.tajawalBold14
                        .copyWith(color: AppColors.authTitle),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    context.tr(option.localSubKey),
                    style: AppTextStyle.tajawalRegular12
                        .copyWith(color: AppColors.authSubtitle),
                  ),
                ],
              ),
            ),

            // Icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: selected
                    ? AppColors.primary.withOpacity(0.12)
                    : AppColors.dashNeutralBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(option.icon,
                  color: selected ? AppColors.primary : AppColors.authSubtitle,
                  size: 20),
            ),
          ],
        ),
      ),
    );
  }
}