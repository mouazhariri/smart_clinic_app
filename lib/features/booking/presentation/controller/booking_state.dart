import 'package:equatable/equatable.dart';

import '../../domain/model/appointment_slot.dart';
import '../../domain/model/booking.dart';
import '../../domain/model/patient_information.dart';
import '../../domain/model/payment_method.dart';

class BookingState extends Equatable {
  const BookingState({
    this.isLoading = false,
    this.doctorName = '',
    this.doctorSpecialty = '',
    this.clinicName = '',
    this.selectedDate,
    this.selectedTime,
    this.availableDates = const [],
    this.availableSlots = const [],
    this.selectedPaymentMethod,
    this.patientInformation,
    this.price = 0.0,
    this.notes = '',
    this.booking,
    this.error,
    this.isBookingCreated = false,
    this.isConfirmed = false,
  });

  final bool isLoading;
  final String doctorName;
  final String doctorSpecialty;
  final String clinicName;
  final DateTime? selectedDate;
  final String? selectedTime;
  final List<DateTime> availableDates;
  final List<AppointmentSlot> availableSlots;
  final PaymentMethod? selectedPaymentMethod;
  final PatientInformation? patientInformation;
  final double price;
  final String notes;
  final Booking? booking;
  final String? error;
  final bool isBookingCreated;
  final bool isConfirmed;

  // ── copyWith ──────────────────────────────────────────────────────────────
  // Sentinel flags allow nullable fields to be explicitly cleared to null
  BookingState copyWith({
    bool? isLoading,
    String? doctorName,
    String? doctorSpecialty,
    String? clinicName,
    DateTime? selectedDate,
    String? selectedTime,
    List<DateTime>? availableDates,
    List<AppointmentSlot>? availableSlots,
    PaymentMethod? selectedPaymentMethod,
    PatientInformation? patientInformation,
    double? price,
    String? notes,
    Booking? booking,
    String? error,
    bool? isBookingCreated,
    bool? isConfirmed,
    // ── Sentinels ─────────────────
    bool clearSelectedTime = false,
    bool clearError = false,
    bool clearSelectedDate = false,
  }) {
    return BookingState(
      isLoading: isLoading ?? this.isLoading,
      doctorName: doctorName ?? this.doctorName,
      doctorSpecialty: doctorSpecialty ?? this.doctorSpecialty,
      clinicName: clinicName ?? this.clinicName,
      selectedDate:
          clearSelectedDate ? null : (selectedDate ?? this.selectedDate),
      selectedTime:
          clearSelectedTime ? null : (selectedTime ?? this.selectedTime),
      availableDates: availableDates ?? this.availableDates,
      availableSlots: availableSlots ?? this.availableSlots,
      selectedPaymentMethod:
          selectedPaymentMethod ?? this.selectedPaymentMethod,
      patientInformation: patientInformation ?? this.patientInformation,
      price: price ?? this.price,
      notes: notes ?? this.notes,
      booking: booking ?? this.booking,
      error: clearError ? null : (error ?? this.error),
      isBookingCreated: isBookingCreated ?? this.isBookingCreated,
      isConfirmed: isConfirmed ?? this.isConfirmed,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        doctorName,
        doctorSpecialty,
        clinicName,
        selectedDate,
        selectedTime,
        availableDates,
        availableSlots,
        selectedPaymentMethod,
        patientInformation,
        price,
        notes,
        booking,
        error,
        isBookingCreated,
        isConfirmed,
      ];
}