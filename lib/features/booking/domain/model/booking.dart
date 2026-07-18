import 'package:equatable/equatable.dart';
import '../enums/booking_status.dart';
import '../enums/payment_type.dart';
import 'doctor_schedule.dart';
import 'patient_information.dart';
import 'payment_method.dart';

class Booking extends Equatable {
  const Booking({
    this.bookingId,
    this.doctor,
    this.clinic,
    this.selectedDate,
    this.selectedTime,
    this.status = BookingStatus.pending,
    this.paymentMethod,
    this.patientInformation,
    this.price = 0.0,
    this.notes = '',
  });

  final String? bookingId;
  final String? doctor;
  final String? clinic;
  final DateTime? selectedDate;
  final String? selectedTime;
  final BookingStatus status;
  final PaymentMethod? paymentMethod;
  final PatientInformation? patientInformation;
  final double price;
  final String notes;

  Booking copyWith({
    String? bookingId,
    String? doctor,
    String? clinic,
    DateTime? selectedDate,
    String? selectedTime,
    BookingStatus? status,
    PaymentMethod? paymentMethod,
    PatientInformation? patientInformation,
    double? price,
    String? notes,
  }) {
    return Booking(
      bookingId: bookingId ?? this.bookingId,
      doctor: doctor ?? this.doctor,
      clinic: clinic ?? this.clinic,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTime: selectedTime ?? this.selectedTime,
      status: status ?? this.status,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      patientInformation: patientInformation ?? this.patientInformation,
      price: price ?? this.price,
      notes: notes ?? this.notes,
    );
  }

  @override
  List<Object?> get props => [
        bookingId,
        doctor,
        clinic,
        selectedDate,
        selectedTime,
        status,
        paymentMethod,
        patientInformation,
        price,
        notes,
      ];
}
