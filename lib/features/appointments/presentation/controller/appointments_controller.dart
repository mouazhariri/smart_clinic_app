import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../../doctors/domain/entities/doctor.dart';
import '../../data/models/appointment_model.dart';
import '../../data/repositories/appointments_repository.dart';
import '../../domain/entities/appointment.dart';
import 'appointments_state.dart';

part 'appointments_controller.g.dart';

@Riverpod(keepAlive: true)
class AppointmentsController extends _$AppointmentsController {
  @override
  FutureOr<AppointmentsState> build() async {
    Future<void>.microtask(() async { await getAppointments(); });
    return AppointmentsState.init();
  }

  final Uuid _uuid = const Uuid();

  Future<List<Appointment>?> getAppointments() async {
    try {
      state = AsyncData(
        state.value!.copyWith(appointments: const AsyncLoading()),
      );
      final repo = ref.read(appointmentsRepositoryProvider);
      final response = await repo.getAppointments();

      if (response.hasFailed) {
        state = AsyncData(
          state.value!.copyWith(
            appointments: AsyncError(
              response.message ?? 'Something went wrong',
              StackTrace.fromString(response.message ?? ''),
            ),
          ),
        );
        return null;
      }

      final appointments =
          response.data?.map((model) => model.toEntity()).toList() ?? [];
      state = AsyncData(
        state.value!.copyWith(appointments: AsyncData(appointments)),
      );
      return appointments;
    } catch (e, st) {
      state = AsyncData(
        state.value!.copyWith(appointments: AsyncError(e, st)),
      );
      return null;
    }
  }

  void selectDate(DateTime date) {
    final currentState = state.value;
    if (currentState == null) return;
    state = AsyncData(
      currentState.copyWith(selectedDate: date, selectedTime: null),
    );
  }

  void selectTime(String time) {
    final currentState = state.value;
    if (currentState == null) return;
    state = AsyncData(currentState.copyWith(selectedTime: time));
  }

  Future<bool> bookAppointment(Doctor doctor) async {
    final currentState = state.value;
    if (currentState == null || !currentState.canConfirm(doctor)) return false;

    try {
      state = AsyncData(currentState.copyWith(bookingState: const AsyncLoading()));
      final appointment = Appointment(
        id: _uuid.v4(),
        doctorId: doctor.id,
        doctorName: doctor.name,
        specialty: doctor.specialty,
        date: currentState.selectedDate!,
        time: currentState.selectedTime!,
        status: AppointmentStatus.confirmed,
        clinicAddress: doctor.clinicAddress,
      );

      final repo = ref.read(appointmentsRepositoryProvider);
      final response = await repo.bookAppointment(
        AppointmentModel.fromEntity(appointment),
      );

      if (response.hasFailed) {
        state = AsyncData(
          state.value!.copyWith(
            bookingState: AsyncError(
              response.message ?? 'Something went wrong',
              StackTrace.fromString(response.message ?? ''),
            ),
          ),
        );
        return false;
      }

      await getAppointments();
      state = AsyncData(
        state.value!.copyWith(
          clearSelection: true,
          bookingState: const AsyncData(null),
          successMessage: 'appointment_booked_successfully',
        ),
      );
      return true;
    } catch (e, st) {
      state = AsyncData(
        state.value!.copyWith(bookingState: AsyncError(e, st)),
      );
      return false;
    }
  }

  Future<void> cancelAppointment(String appointmentId) async {
    try {
      state = AsyncData(
        state.value!.copyWith(bookingState: const AsyncLoading()),
      );
      final repo = ref.read(appointmentsRepositoryProvider);
      final response = await repo.cancelAppointment(appointmentId);

      if (response.hasFailed) {
        state = AsyncData(
          state.value!.copyWith(
            bookingState: AsyncError(
              response.message ?? 'Something went wrong',
              StackTrace.fromString(response.message ?? ''),
            ),
          ),
        );
        return;
      }

      await getAppointments();
      state = AsyncData(
        state.value!.copyWith(
          bookingState: const AsyncData(null),
          successMessage: 'appointment_cancelled_successfully',
        ),
      );
    } catch (e, st) {
      state = AsyncData(
        state.value!.copyWith(bookingState: AsyncError(e, st)),
      );
    }
  }
}
