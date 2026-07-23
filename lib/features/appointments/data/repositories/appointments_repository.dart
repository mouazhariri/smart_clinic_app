import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../src/infrastructure/api/response/api_response.dart';
import '../../../../src/infrastructure/network/services/dio_client.dart';
import '../../../../src/logger/failure/exceptions/app_exception.dart';
import '../../domain/model/appointment.dart';
import '../datasources/appointments_local_data_source.dart';
import '../datasources/appointments_remote_data_source.dart';
import '../models/appointment_model.dart';

part 'appointments_repository.g.dart';

@Riverpod(keepAlive: true)
AppointmentsRepository appointmentsRepository(Ref ref) {
  final networkService = ref.watch(networkServiceProvider());
  return AppointmentsRepository(
    remoteDataSource: AppointmentsRemoteDataSource(networkService),
    localDataSource: AppointmentsLocalDataSourceImpl(),
  );
}

class AppointmentsRepository {
  AppointmentsRepository({
    required AppointmentsRemoteDataSource remoteDataSource,
    required AppointmentsLocalDataSource localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  final AppointmentsRemoteDataSource _remoteDataSource;
  final AppointmentsLocalDataSource _localDataSource;

  Future<ApiResponse<List<AppointmentModel>>> getAppointments() async {
    try {
      final result = await _remoteDataSource.getAppointments();
      if (result.hasFailed) {
        throw AppException(
          message: result.message ?? 'Failed to fetch appointments',
        );
      }
      return result;
    } catch (_) {
      final localAppointments = await _localDataSource.getAppointments();
      return ApiResponse<List<AppointmentModel>>.success(
        data: localAppointments,
      );
    }
  }

  Future<ApiResponse<AppointmentModel>> bookAppointment(
    AppointmentModel appointment,
  ) async {
    try {
      final result = await _remoteDataSource.bookAppointment(appointment);
      if (result.hasFailed) {
        throw AppException(
          message: result.message ?? 'Failed to book appointment',
        );
      }
      await _localDataSource.saveAppointment(result.data ?? appointment);
      return result;
    } catch (_) {
      await _localDataSource.saveAppointment(appointment);
      return ApiResponse<AppointmentModel>.success(data: appointment);
    }
  }

  Future<ApiResponse<void>> cancelAppointment(String appointmentId) async {
    try {
      final result = await _remoteDataSource.cancelAppointment(appointmentId);
      if (result.hasFailed) {
        throw AppException(
          message: result.message ?? 'Failed to cancel appointment',
        );
      }
    } catch (_) {
      // Keep local-first behavior until endpoint is available.
    }

    final appointments = await _localDataSource.getAppointments();
    final appointment = appointments.firstWhere(
      (item) => item.id == appointmentId,
    );
    await _localDataSource.updateAppointment(
      appointment.copyWith(status: AppointmentStatus.cancelled),
    );
    return ApiResponse<void>.success();
  }
}
