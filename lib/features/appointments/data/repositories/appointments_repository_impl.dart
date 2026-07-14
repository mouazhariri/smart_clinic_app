import '../../domain/entities/appointment.dart';
import '../../domain/repositories/appointments_repository.dart';
import '../datasources/appointments_local_data_source.dart';
import '../datasources/appointments_remote_data_source.dart';
import '../models/appointment_model.dart';

class AppointmentsRepositoryImpl implements AppointmentsRepository {
  const AppointmentsRepositoryImpl({
    required AppointmentsLocalDataSource localDataSource,
    required AppointmentsRemoteDataSource remoteDataSource,
  })  : _localDataSource = localDataSource,
        _remoteDataSource = remoteDataSource;

  static const bool _useRemoteDataSource = false;

  final AppointmentsLocalDataSource _localDataSource;
  final AppointmentsRemoteDataSource _remoteDataSource;

  @override
  Future<List<Appointment>> getAppointments() async {
    final models = _useRemoteDataSource
        ? await _remoteDataSource.getAppointments()
        : await _localDataSource.getAppointments();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> bookAppointment(Appointment appointment) async {
    final model = AppointmentModel.fromEntity(appointment);
    if (_useRemoteDataSource) {
      await _remoteDataSource.bookAppointment(model);
    }
    await _localDataSource.saveAppointment(model);
  }

  @override
  Future<void> cancelAppointment(String appointmentId) async {
    if (_useRemoteDataSource) {
      await _remoteDataSource.cancelAppointment(appointmentId);
    }
    final appointments = await _localDataSource.getAppointments();
    final appointment = appointments.firstWhere(
      (item) => item.id == appointmentId,
    );
    await _localDataSource.updateAppointment(
      appointment.copyWith(status: AppointmentStatus.cancelled),
    );
  }
}
