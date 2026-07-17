import 'package:equatable/equatable.dart';
import '../enums/payment_type.dart';

class PaymentMethod extends Equatable {
  const PaymentMethod({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
    this.isSelected = false,
    this.type = PaymentType.cash,
  });

  final String id;
  final String name;
  final String icon;
  final String description;
  final bool isSelected;
  final PaymentType type;

  PaymentMethod copyWith({
    String? id,
    String? name,
    String? icon,
    String? description,
    bool? isSelected,
    PaymentType? type,
  }) {
    return PaymentMethod(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      description: description ?? this.description,
      isSelected: isSelected ?? this.isSelected,
      type: type ?? this.type,
    );
  }

  @override
  List<Object?> get props => [id, name, icon, description, isSelected, type];
}
