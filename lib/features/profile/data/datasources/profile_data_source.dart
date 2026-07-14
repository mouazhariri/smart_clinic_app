import '../../../../src/infrastructure/api/endpoint/api_endpoints.dart';
import '../../../../src/infrastructure/api/response/api_response.dart';
import '../../../../src/infrastructure/network/services/network_service.dart';
import '../../../../src/infrastructure/storage/local_storage_service.dart';
import '../../../../src/logger/log_services/dev_logger.dart';
import '../models/user_profile_model.dart';

class ProfileRemoteDataSource {
  ProfileRemoteDataSource(this._networkService);

  final NetworkService _networkService;

  Future<ApiResponse<UserProfileModel>> getProfile() async {
    try {
      final response = await _networkService.get(ApiEndPoints.profile);
      if (response.data == null || response.statusCode != 200) {
        throw Exception('Failed to load profile');
      }
      return ApiResponse.fromJson(
        response.data as Map<String, dynamic>,
        (json) => UserProfileModel.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      Dev.logError('Error in getProfile: $e');
      rethrow;
    }
  }

  Future<ApiResponse<void>> logout() async {
    try {
      final response = await _networkService.post(ApiEndPoints.logoutApi);
      if (response.data == null || response.statusCode != 200) {
        throw Exception('Failed to logout');
      }
      return ApiResponse.fromJson(response.data as Map<String, dynamic>, (_) {});
    } catch (e) {
      Dev.logError('Error in logout: $e');
      rethrow;
    }
  }
}

class ProfileLocalDataSource {
  const ProfileLocalDataSource(this._localStorageService);

  final LocalStorageService _localStorageService;

  Future<UserProfileModel> getProfile() async {
    return const UserProfileModel(
      fullNameKey: 'sample_user_full_name',
      emailKey: 'sample_user_email',
      phoneKey: 'sample_user_phone',
      languageCode: 'en',
      themeKey: 'system_default',
    );
  }

  Future<void> logout() => _localStorageService.logout();
}
