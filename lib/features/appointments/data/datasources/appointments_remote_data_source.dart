import '../../../../src/infrastructure/api/endpoint/api_endpoints.dart';
import '../../../../src/infrastructure/api/response/api_response.dart';
import '../../../../src/infrastructure/network/services/network_service.dart';
import '../../../../src/logger/log_services/dev_logger.dart';
import '../models/appointment_model.dart';

class AppointmentsRemoteDataSource {
  const AppointmentsRemoteDataSource(this._networkService);

  final NetworkService _networkService;

  Future<ApiResponse<List<AppointmentModel>>> getAppointments() async {
    try {
      final response = await _networkService.get(ApiEndPoints.appointments);

      if (response.data == null || response.statusCode != 200) {
        throw Exception('Failed to load appointments');
      }

      return ApiResponse.fromJson(
        response.data as Map<String, dynamic>,
        (json) => (json as List<dynamic>)
            .map((item) => AppointmentModel.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
    } catch (e) {
      Dev.logError('Error in getAppointments: $e');
      rethrow;
    }
  }

  Future<ApiResponse<AppointmentModel>> bookAppointment(
    AppointmentModel appointment,
  ) async {
    try {
      final response = await _networkService.post(
        ApiEndPoints.bookAppointment,
        data: appointment.toJson(),
      );

      if (response.data == null || response.statusCode != 200) {
        throw Exception('Failed to book appointment');
      }

      return ApiResponse.fromJson(
        response.data as Map<String, dynamic>,
        (json) => AppointmentModel.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      Dev.logError('Error in bookAppointment: $e');
      rethrow;
    }
  }

  Future<ApiResponse<void>> cancelAppointment(String appointmentId) async {
    try {
      final response = await _networkService.delete(
        ApiEndPoints.cancelAppointment,
        queryParameters: {'appointment_id': appointmentId},
      );

      if (response.data == null || response.statusCode != 200) {
        throw Exception('Failed to cancel appointment');
      }

      return ApiResponse.fromJson(
        response.data as Map<String, dynamic>,
        (_) {},
      );
    } catch (e) {
      Dev.logError('Error in cancelAppointment: $e');
      rethrow;
    }
  }
}
