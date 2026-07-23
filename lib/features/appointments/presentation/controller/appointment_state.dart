// lib/features/appointments/presentation/controller/appointment_state.dart
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/model/appointment.dart';

class AppointmentState extends Equatable {
  final AsyncValue<List<Appointment>> appointments;
  final bool isLoading;
  final String? error;

  const AppointmentState({
    this.appointments = const AsyncData([]),
    this.isLoading = false,
    this.error,
  });

  factory AppointmentState.init() => const AppointmentState();

  // Nearest upcoming appointment
  Appointment? get nearest {
    final list = appointments.value ?? [];
    final now = DateTime.now();
    final upcoming = list
        .where((a) =>
            a.status != AppointmentStatus.completed &&
            a.status != AppointmentStatus.cancelled &&
            a.date.isAfter(now.subtract(const Duration(hours: 1))))
        .toList()
      ..sort((a, b) => a.date.compareTo(b.date));
    return upcoming.isEmpty ? null : upcoming.first;
  }

  AppointmentState copyWith({
    AsyncValue<List<Appointment>>? appointments,
    bool? isLoading,
    String? error,
  }) {
    return AppointmentState(
      appointments: appointments ?? this.appointments,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [appointments, isLoading, error];
}