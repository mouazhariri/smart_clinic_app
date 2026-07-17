import '../../domain/model/booking.dart';
import '../../domain/enums/booking_status.dart';
import '../models/booking_model.dart'; // Not created yet; mapping handled inline for now

class BookingMapper {
  static Booking toDomain(dynamic data) {
    return Booking(
      bookingId: data['booking_id'] as String?,
      doctor: data['doctor_name'] as String?,
      clinic: data['clinic_name'] as String?,
      selectedDate: data['date'] != null ? DateTime.parse(data['date']) : null,
      selectedTime: data['time'] as String?,
      status: BookingStatus.values.firstWhere(
        (e) => e.name == (data['status'] ?? 'pending'),
        orElse: () => BookingStatus.pending,
      ),
      notes: data['notes'] as String? ?? '',
    );
  }

  static Map<String, dynamic> toData(Booking booking) => {
        'booking_id': booking.bookingId,
        'doctor_name': booking.doctor,
        'clinic_name': booking.clinic,
        'date': booking.selectedDate?.toIso8601String(),
        'time': booking.selectedTime,
        'status': booking.status.name,
        'notes': booking.notes,
      };
}
