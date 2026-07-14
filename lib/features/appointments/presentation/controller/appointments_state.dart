import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../doctors/domain/entities/doctor.dart';
import '../../domain/entities/appointment.dart';

class AppointmentsState {
  const AppointmentsState({
    required this.appointments,
    this.selectedDate,
    this.selectedTime,
    required this.bookingState,
    this.successMessage,
  });

  factory AppointmentsState.init() {
    return const AppointmentsState(
      appointments: AsyncData([]),
      bookingState: AsyncData(null),
    );
  }

  final AsyncValue<List<Appointment>> appointments;
  final DateTime? selectedDate;
  final String? selectedTime;
  final AsyncValue<void> bookingState;
  final String? successMessage;

  List<Appointment> get upcomingAppointments => (appointments.value ?? [])
      .where((appointment) => appointment.status != AppointmentStatus.cancelled)
      .where((appointment) => appointment.date
          .isAfter(DateTime.now().subtract(const Duration(days: 1))))
      .toList();

  List<Appointment> get historyAppointments => (appointments.value ?? [])
      .where((appointment) =>
          appointment.status == AppointmentStatus.cancelled ||
          appointment.status == AppointmentStatus.completed ||
          appointment.date.isBefore(DateTime.now()))
      .toList();

  bool canConfirm(Doctor doctor) {
    return selectedDate != null && selectedTime != null;
  }

  AppointmentsState copyWith({
    AsyncValue<List<Appointment>>? appointments,
    DateTime? selectedDate,
    String? selectedTime,
    bool clearSelection = false,
    AsyncValue<void>? bookingState,
    String? successMessage,
  }) {
    return AppointmentsState(
      appointments: appointments ?? this.appointments,
      selectedDate: clearSelection ? null : selectedDate ?? this.selectedDate,
      selectedTime: clearSelection ? null : selectedTime ?? this.selectedTime,
      bookingState: bookingState ?? this.bookingState,
      successMessage: successMessage,
    );
  }
}
