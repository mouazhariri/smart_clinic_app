class PaymentMethodResponse {
  final String id;
  final String name;
  final String icon;
  final String description;
  final String type;

  PaymentMethodResponse({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
    required this.type,
  });

  factory PaymentMethodResponse.fromJson(Map<String, dynamic> json) {
    return PaymentMethodResponse(
      id: json['id'] as String,
      name: json['name'] as String,
      icon: json['icon'] as String,
      description: json['description'] as String,
      type: json['type'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'icon': icon,
        'description': description,
        'type': type,
      };
}

class PaymentMethodsResponse {
  final List<PaymentMethodResponse> methods;

  PaymentMethodsResponse({required this.methods});

  factory PaymentMethodsResponse.fromJson(Map<String, dynamic> json) {
    return PaymentMethodsResponse(
      methods: (json['methods'] as List<dynamic>)
          .map((e) => PaymentMethodResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'methods': methods.map((e) => e.toJson()).toList(),
      };
}
