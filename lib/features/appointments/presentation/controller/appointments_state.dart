import 'package:equatable/equatable.dart';

import '../../../doctors/domain/entities/doctor.dart';
import '../../domain/entities/appointment.dart';

class AppointmentsState extends Equatable {
  const AppointmentsState({
    this.appointments = const [],
    this.selectedDate,
    this.selectedTime,
    this.isLoading = false,
    this.errorMessage,
    this.successMessage,
  });

  final List<Appointment> appointments;
  final DateTime? selectedDate;
  final String? selectedTime;
  final bool isLoading;
  final String? errorMessage;
  final String? successMessage;

  List<Appointment> get upcomingAppointments => appointments
      .where((appointment) => appointment.status != AppointmentStatus.cancelled)
      .where((appointment) => appointment.date
          .isAfter(DateTime.now().subtract(const Duration(days: 1))))
      .toList();

  List<Appointment> get historyAppointments => appointments
      .where((appointment) =>
          appointment.status == AppointmentStatus.cancelled ||
          appointment.status == AppointmentStatus.completed ||
          appointment.date.isBefore(DateTime.now()))
      .toList();

  bool canConfirm(Doctor doctor) {
    return selectedDate != null && selectedTime != null;
  }

  AppointmentsState copyWith({
    List<Appointment>? appointments,
    DateTime? selectedDate,
    String? selectedTime,
    bool clearSelection = false,
    bool? isLoading,
    String? errorMessage,
    String? successMessage,
  }) {
    return AppointmentsState(
      appointments: appointments ?? this.appointments,
      selectedDate: clearSelection ? null : selectedDate ?? this.selectedDate,
      selectedTime: clearSelection ? null : selectedTime ?? this.selectedTime,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      successMessage: successMessage,
    );
  }

  @override
  List<Object?> get props => [
        appointments,
        selectedDate,
        selectedTime,
        isLoading,
        errorMessage,
        successMessage,
      ];
}
