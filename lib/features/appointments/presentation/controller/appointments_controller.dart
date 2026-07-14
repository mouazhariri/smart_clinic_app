import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../src/infrastructure/network/services/dio_client.dart';
import '../../../doctors/domain/entities/doctor.dart';
import '../../data/datasources/appointments_local_data_source.dart';
import '../../data/datasources/appointments_remote_data_source.dart';
import '../../data/repositories/appointments_repository_impl.dart';
import '../../domain/entities/appointment.dart';
import '../../domain/repositories/appointments_repository.dart';
import '../../domain/usecases/book_appointment_use_case.dart';
import '../../domain/usecases/cancel_appointment_use_case.dart';
import '../../domain/usecases/get_appointments_use_case.dart';
import 'appointments_state.dart';

final appointmentsLocalDataSourceProvider = Provider<AppointmentsLocalDataSource>(
  (ref) => AppointmentsLocalDataSourceImpl(),
);

final appointmentsRemoteDataSourceProvider = Provider<AppointmentsRemoteDataSource>(
  (ref) => AppointmentsRemoteDataSourceImpl(ref.watch(networkServiceProvider())),
);

final appointmentsRepositoryProvider = Provider<AppointmentsRepository>(
  (ref) => AppointmentsRepositoryImpl(
    localDataSource: ref.watch(appointmentsLocalDataSourceProvider),
    remoteDataSource: ref.watch(appointmentsRemoteDataSourceProvider),
  ),
);

final getAppointmentsUseCaseProvider = Provider<GetAppointmentsUseCase>(
  (ref) => GetAppointmentsUseCase(ref.watch(appointmentsRepositoryProvider)),
);

final bookAppointmentUseCaseProvider = Provider<BookAppointmentUseCase>(
  (ref) => BookAppointmentUseCase(ref.watch(appointmentsRepositoryProvider)),
);

final cancelAppointmentUseCaseProvider = Provider<CancelAppointmentUseCase>(
  (ref) => CancelAppointmentUseCase(ref.watch(appointmentsRepositoryProvider)),
);

final appointmentsControllerProvider =
    StateNotifierProvider<AppointmentsController, AppointmentsState>(
  (ref) => AppointmentsController(
    getAppointmentsUseCase: ref.watch(getAppointmentsUseCaseProvider),
    bookAppointmentUseCase: ref.watch(bookAppointmentUseCaseProvider),
    cancelAppointmentUseCase: ref.watch(cancelAppointmentUseCaseProvider),
  )..loadAppointments(),
);

class AppointmentsController extends StateNotifier<AppointmentsState> {
  AppointmentsController({
    required GetAppointmentsUseCase getAppointmentsUseCase,
    required BookAppointmentUseCase bookAppointmentUseCase,
    required CancelAppointmentUseCase cancelAppointmentUseCase,
  })  : _getAppointmentsUseCase = getAppointmentsUseCase,
        _bookAppointmentUseCase = bookAppointmentUseCase,
        _cancelAppointmentUseCase = cancelAppointmentUseCase,
        super(const AppointmentsState());

  final GetAppointmentsUseCase _getAppointmentsUseCase;
  final BookAppointmentUseCase _bookAppointmentUseCase;
  final CancelAppointmentUseCase _cancelAppointmentUseCase;
  final Uuid _uuid = const Uuid();

  Future<void> loadAppointments() async {
    state = state.copyWith(isLoading: true);
    try {
      final appointments = await _getAppointmentsUseCase();
      state = state.copyWith(appointments: appointments, isLoading: false);
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'something_went_wrong_please_try_again_later',
      );
    }
  }

  void selectDate(DateTime date) {
    state = state.copyWith(selectedDate: date, selectedTime: null);
  }

  void selectTime(String time) {
    state = state.copyWith(selectedTime: time);
  }

  Future<bool> bookAppointment(Doctor doctor) async {
    if (!state.canConfirm(doctor)) return false;

    state = state.copyWith(isLoading: true);
    try {
      final appointment = Appointment(
        id: _uuid.v4(),
        doctorId: doctor.id,
        doctorName: doctor.name,
        specialty: doctor.specialty,
        date: state.selectedDate!,
        time: state.selectedTime!,
        status: AppointmentStatus.confirmed,
        clinicAddress: doctor.clinicAddress,
      );

      await _bookAppointmentUseCase(appointment);
      final appointments = await _getAppointmentsUseCase();
      state = state.copyWith(
        appointments: appointments,
        clearSelection: true,
        isLoading: false,
        successMessage: 'appointment_booked_successfully',
      );
      return true;
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'something_went_wrong_please_try_again_later',
      );
      return false;
    }
  }

  Future<void> cancelAppointment(String appointmentId) async {
    state = state.copyWith(isLoading: true);
    try {
      await _cancelAppointmentUseCase(appointmentId);
      final appointments = await _getAppointmentsUseCase();
      state = state.copyWith(
        appointments: appointments,
        isLoading: false,
        successMessage: 'appointment_cancelled_successfully',
      );
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'something_went_wrong_please_try_again_later',
      );
    }
  }
}
