import 'package:smart_clinic_app/features/booking/domain/enums/payment_type.dart';

class PaymentMethod {
  final String id;
  final String name;
  final String description;
  final String icon;
  final bool isSelected;
  final PaymentType type;

  const PaymentMethod({
    this.id = '',
    required this.name,
    this.description = '',
    this.icon = '',
    this.isSelected = false,
    this.type = PaymentType.cash,
  });

  PaymentMethod copyWith({
    String? id,
    String? name,
    String? description,
    String? icon,
    bool? isSelected,
    PaymentType? type,
  }) {
    return PaymentMethod(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      isSelected: isSelected ?? this.isSelected,
      type: type ?? this.type,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentMethod &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}