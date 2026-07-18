import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smart_clinic_app/features/booking/data/repository/booking_repository.dart';

import '../../data/request/create_booking_request.dart';
import '../../domain/enums/payment_type.dart';
import '../../domain/model/appointment_slot.dart';
import '../../domain/model/patient_information.dart';
import '../../domain/model/payment_method.dart';
import 'booking_state.dart';

part 'booking_controller.g.dart';

@riverpod
class BookingController extends _$BookingController {
  @override
  BookingState build() => const BookingState();

  // ── Doctor info ───────────────────────────────────────────────────────────
  void loadDoctorInfo({
    required String doctorName,
    required String doctorSpecialty,
    required String clinicName,
    double price = 0.0,
  }) {
    state = state.copyWith(
      doctorName: doctorName,
      doctorSpecialty: doctorSpecialty,
      clinicName: clinicName,
      price: price,
    );
  }

  // ── Schedule ──────────────────────────────────────────────────────────────
  void loadSchedule(List<DateTime> dates, List<String> times) {
    final slots = times
        .map((t) => AppointmentSlot(time: t, isAvailable: true))
        .toList();
    state = state.copyWith(
      availableDates: dates,
      availableSlots: slots,
    );
  }

  // ── Date selection ────────────────────────────────────────────────────────
  void selectDate(DateTime date) {
    // Clear selectedTime when date changes
    state = state.copyWith(
      selectedDate: date,
      clearSelectedTime: true,
    );
  }

  // ── Time selection ────────────────────────────────────────────────────────
  void selectTime(String time) {
    state = state.copyWith(selectedTime: time);
  }

  // ── Notes ─────────────────────────────────────────────────────────────────
  void updateNotes(String notes) {
    state = state.copyWith(notes: notes);
  }

  // ── Patient info ──────────────────────────────────────────────────────────
  // Called from PatientInformationSheet with named params
  void updatePatientInfo({
    DateTime? birthDate,
    String? city,
    String? gender,
  }) {
    final current = state.patientInformation;
    state = state.copyWith(
      patientInformation: PatientInformation(
        birthDate: birthDate ?? current?.birthDate,
        city: city ?? current?.city,
        gender: gender ?? current?.gender,
      ),
    );
  }

  // Also keep an overload that accepts a full object
  // (used internally if needed)
  void setPatientInfo(PatientInformation info) {
    state = state.copyWith(patientInformation: info);
  }

  // ── Payment ───────────────────────────────────────────────────────────────
  // selectPaymentMethod — name used in the screens
  void selectPaymentMethod(PaymentMethod method) {
    state = state.copyWith(
      selectedPaymentMethod: method.copyWith(isSelected: true),
    );
  }

  // Keep old name as alias so nothing breaks if referenced elsewhere
  void selectPayment(PaymentMethod method) => selectPaymentMethod(method);

  // ── Create booking ────────────────────────────────────────────────────────
  Future<bool> createBooking(String doctorId) async {
    if (state.selectedDate == null || state.selectedTime == null) {
      return false;
    }
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final repo = ref.read(bookingRepositoryProvider);
      final request = CreateBookingRequest(
        doctorId: doctorId,
        date: state.selectedDate!,
        time: state.selectedTime!,
        notes: state.notes.isNotEmpty ? state.notes : null,
        paymentMethodId: state.selectedPaymentMethod?.id,
      );
      final result = await repo.createBooking(request);
      if (result.hasFailed) {
        state = state.copyWith(
          isLoading: false,
          error: result.message,
        );
        return false;
      }
      state = state.copyWith(
        isLoading: false,
        isBookingCreated: true,
      );
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  // ── Confirm booking ───────────────────────────────────────────────────────
  Future<bool> confirmBooking(String bookingId) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final repo = ref.read(bookingRepositoryProvider);
      final result = await repo.confirmBooking(bookingId);
      if (result.hasFailed) {
        state = state.copyWith(isLoading: false, error: result.message);
        return false;
      }
      state = state.copyWith(isLoading: false, isConfirmed: true);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  // ── Reset ─────────────────────────────────────────────────────────────────
  void resetBooking() => state = const BookingState();
}