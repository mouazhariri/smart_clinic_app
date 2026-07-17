import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/enums/payment_type.dart';
import '../../domain/model/appointment_slot.dart';
import '../../domain/model/patient_information.dart';
import '../../domain/model/payment_method.dart';
import '../data/repository/booking_repository.dart';
import '../data/request/create_booking_request.dart';
import 'booking_state.dart';

part 'booking_controller.g.dart';

@riverpod
class BookingController extends _$BookingController {
  @override
  BookingState build() {
    return const BookingState();
  }

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

  void loadSchedule(List<DateTime> dates, List<String> times) {
    final slots = times.map((t) => AppointmentSlot(time: t, isAvailable: true)).toList();
    state = state.copyWith(
      availableDates: dates,
      availableSlots: slots,
    );
  }

  void selectDate(DateTime date) {
    state = state.copyWith(selectedDate: date, selectedTime: null);
  }

  void selectTime(String time) {
    state = state.copyWith(selectedTime: time);
  }

  void updateNotes(String notes) {
    state = state.copyWith(notes: notes);
  }

  void updatePatientInfo(PatientInformation info) {
    state = state.copyWith(patientInformation: info);
  }

  void selectPayment(PaymentMethod method) {
    final others = state.selectedPaymentMethod != null
        ? [PaymentMethod(
            id: state.selectedPaymentMethod!.id,
            name: state.selectedPaymentMethod!.name,
            icon: state.selectedPaymentMethod!.icon,
            description: state.selectedPaymentMethod!.description,
            isSelected: false,
            type: state.selectedPaymentMethod!.type,
          )]
        : <PaymentMethod>[];

    final updated = others.map((m) => m.copyWith(isSelected: false)).toList();
    updated.add(method.copyWith(isSelected: true));

    state = state.copyWith(
      selectedPaymentMethod: method.copyWith(isSelected: true),
    );
  }

  Future<bool> createBooking(String doctorId) async {
    if (state.selectedDate == null || state.selectedTime == null) {
      return false;
    }
    state = state.copyWith(isLoading: true, error: null);
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
        state = state.copyWith(isLoading: false, error: result.message);
        return false;
      }
      state = state.copyWith(
        isLoading: false,
        isBookingCreated: true,
        booking: null,
      );
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<bool> confirmBooking(String bookingId) async {
    state = state.copyWith(isLoading: true, error: null);
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

  void resetBooking() {
    state = const BookingState();
  }
}
