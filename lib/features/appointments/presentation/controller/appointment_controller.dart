// lib/features/appointments/presentation/controller/appointment_controller.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_clinic_app/features/appointments/domain/model/fake_appointments.dart';

import '../../domain/model/appointment.dart';
import 'appointment_state.dart';

part 'appointment_controller.g.dart';

@Riverpod(keepAlive: true)
class AppointmentController extends _$AppointmentController {
  @override
  FutureOr<AppointmentState> build() async {
    // Load fake data — replace with repo call when API is ready
    await Future.delayed(const Duration(milliseconds: 300));
    return AppointmentState(
      appointments: AsyncData(FakeAppointments.all),
    );
  }

  Future<void> refresh() async {
    final current = state.value;
    if (current == null) return;
    state = AsyncData(current.copyWith(isLoading: true));
    await Future.delayed(const Duration(milliseconds: 500)); // fake delay
    state = AsyncData(current.copyWith(
      appointments: AsyncData(FakeAppointments.all),
      isLoading: false,
    ));
  }

  /// Patient confirms they are now in the clinic
  Future<void> confirmArrival(String appointmentId) async {
    final current = state.value;
    if (current == null) return;
    final list = current.appointments.value ?? [];
    final updated = list.map((a) {
      if (a.id == appointmentId) {
        return Appointment(
          id: a.id,
          doctorId: a.doctorId,
          doctorName: a.doctorName,
          doctorSpecialty: a.doctorSpecialty,
          doctorImageUrl: a.doctorImageUrl,
          date: a.date,
          time: a.time,
          status: AppointmentStatus.inClinic,
          queueNumber: a.queueNumber,
          currentTurn: a.currentTurn,
          estimatedWaitMinutes: a.estimatedWaitMinutes,
          patientsAhead: a.patientsAhead,
          clinicAddress: a.clinicAddress,
          phoneNumber: a.phoneNumber,
          sessionDetails: a.sessionDetails,
        );
      }
      return a;
    }).toList();
    state = AsyncData(current.copyWith(appointments: AsyncData(updated)));
  }

  /// Report that the clinic is late
  void reportLate(String appointmentId) {
    // TODO: call API
  }
}

// ── Convenience providers ──────────────────────────────────────────────────

/// Single appointment by id
final appointmentByIdProvider =
    Provider.family<Appointment?, String>((ref, id) {
  final list = ref
          .watch(appointmentControllerProvider)
          .value
          ?.appointments
          .value ??
      [];
  try {
    return list.firstWhere((a) => a.id == id);
  } catch (_) {
    return null;
  }
});

/// Nearest upcoming appointment
final nearestAppointmentProvider = Provider<Appointment?>((ref) {
  return ref.watch(appointmentControllerProvider).value?.nearest;
});

