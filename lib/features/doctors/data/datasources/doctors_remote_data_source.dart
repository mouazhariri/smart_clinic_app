import '../../../../src/infrastructure/api/endpoint/api_endpoints.dart';
import '../../../../src/infrastructure/api/response/api_response.dart';
import '../../../../src/infrastructure/network/services/network_service.dart';
import '../../../../src/logger/log_services/dev_logger.dart';
import '../models/doctor_model.dart';

class DoctorsRemoteDataSource {
  const DoctorsRemoteDataSource(this._networkService);

  final NetworkService _networkService;

  Future<ApiResponse<List<DoctorModel>>> getDoctors() async {
    try {
      final response = await _networkService.get(ApiEndPoints.doctors);

      if (response.data == null || response.statusCode != 200) {
        throw Exception('Failed to load doctors');
      }

      return ApiResponse.fromJson(
        response.data as Map<String, dynamic>,
        (json) => (json as List<dynamic>)
            .map((item) => DoctorModel.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
    } catch (e) {
      Dev.logError('Error in getDoctors: $e');
      rethrow;
    }
  }

  Future<ApiResponse<DoctorModel>> getDoctorById(String id) async {
    try {
      final response = await _networkService.get(
        ApiEndPoints.doctorDetails,
        queryParameters: {'doctor_id': id},
      );

      if (response.data == null || response.statusCode != 200) {
        throw Exception('Failed to load doctor details');
      }

      return ApiResponse.fromJson(
        response.data as Map<String, dynamic>,
        (json) => DoctorModel.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      Dev.logError('Error in getDoctorById: $e');
      rethrow;
    }
  }
}
