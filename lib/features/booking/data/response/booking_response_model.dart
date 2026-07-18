class BookingResponseModel {
  final String bookingId;
  final String doctorName;
  final String clinicName;
  final String date;
  final String time;
  final String status;
  final String? notes;

  BookingResponseModel({
    required this.bookingId,
    required this.doctorName,
    required this.clinicName,
    required this.date,
    required this.time,
    required this.status,
    this.notes,
  });

  factory BookingResponseModel.fromJson(Map<String, dynamic> json) {
    return BookingResponseModel(
      bookingId: json['booking_id'] as String,
      doctorName: json['doctor_name'] as String,
      clinicName: json['clinic_name'] as String,
      date: json['date'] as String,
      time: json['time'] as String,
      status: json['status'] as String,
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'booking_id': bookingId,
        'doctor_name': doctorName,
        'clinic_name': clinicName,
        'date': date,
        'time': time,
        'status': status,
        'notes': notes,
      };
}
