// lib/features/appointments/presentation/controller/appointments_controller.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_clinic_app/features/appointments/domain/model/fake_appointments.dart';
import '../../../domain/model/appointment.dart';
import 'appointments_state.dart';

part 'appointments_controller.g.dart';

@Riverpod(keepAlive: true)
class AppointmentsController extends _$AppointmentsController {
  @override
  FutureOr<AppointmentsState> build() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return AppointmentsState(
      appointments: AsyncData(FakeAppointments.all),
    );
  }

  Future<void> refresh() async {
    final current = state.value;
    if (current == null) return;
    state = AsyncData(
      current.copyWith(appointments: const AsyncLoading()),
    );
    await Future.delayed(const Duration(milliseconds: 500));
    state = AsyncData(
      current.copyWith(
        appointments: AsyncData(FakeAppointments.all),
      ),
    );
  }

  void setTab(AppointmentsTab tab) {
    final current = state.value;
    if (current == null) return;
    state = AsyncData(current.copyWith(activeTab: tab));
  }

  Future<void> cancelAppointment(String id) async {
    final current = state.value;
    if (current == null) return;
    final list = current.allList.map((a) {
      if (a.id == id) {
        return Appointment(
          id: a.id,
          doctorId: a.doctorId,
          doctorName: a.doctorName,
          doctorSpecialty: a.doctorSpecialty,
          doctorImageUrl: a.doctorImageUrl,
          date: a.date,
          time: a.time,
          status: AppointmentStatus.cancelled,
          clinicAddress: a.clinicAddress,
          phoneNumber: a.phoneNumber,
          sessionDetails: a.sessionDetails,
        );
      }
      return a;
    }).toList();
    state = AsyncData(
      current.copyWith(appointments: AsyncData(list)),
    );
  }
}

/// Nearest upcoming appointment for the home screen card
final nearestAppointmentProvider = Provider<Appointment?>((ref) {
  final list = ref
          .watch(appointmentsControllerProvider)
          .value
          ?.allList ??
      [];
  final upcoming = list
      .where((a) => a.isUpcoming)
      .toList()
    ..sort((a, b) => a.date.compareTo(b.date));
  return upcoming.isEmpty ? null : upcoming.first;
});