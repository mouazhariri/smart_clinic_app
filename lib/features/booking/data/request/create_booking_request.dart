class CreateBookingRequest {
  final String doctorId;
  final DateTime date;
  final String time;
  final String? notes;
  final String? paymentMethodId;

  CreateBookingRequest({
    required this.doctorId,
    required this.date,
    required this.time,
    this.notes,
    this.paymentMethodId,
  });

  Map<String, dynamic> toJson() => {
        'doctor_id': doctorId,
        'date': date.toIso8601String(),
        'time': time,
        'notes': notes,
        'payment_method_id': paymentMethodId,
      };
}
