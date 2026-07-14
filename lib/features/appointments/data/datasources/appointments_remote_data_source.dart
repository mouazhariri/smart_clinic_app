import 'package:dio/dio.dart';

import '../../../../src/infrastructure/network/services/network_service.dart';
import '../models/appointment_model.dart';

abstract class AppointmentsRemoteDataSource {
  Future<List<AppointmentModel>> getAppointments();
  Future<void> bookAppointment(AppointmentModel appointment);
  Future<void> cancelAppointment(String appointmentId);
}

class AppointmentsRemoteDataSourceImpl implements AppointmentsRemoteDataSource {
  const AppointmentsRemoteDataSourceImpl(this._networkService);

  final NetworkService<Response> _networkService;

  @override
  Future<List<AppointmentModel>> getAppointments() async {
    final response = await _networkService.get('/appointments');
    final data = response.data as Map<String, dynamic>;
    final items = data['data'] as List<dynamic>;
    return items
        .map((item) => AppointmentModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> bookAppointment(AppointmentModel appointment) async {
    await _networkService.post('/appointments', data: appointment.toJson());
  }

  @override
  Future<void> cancelAppointment(String appointmentId) async {
    await _networkService.delete('/appointments/$appointmentId');
  }
}
