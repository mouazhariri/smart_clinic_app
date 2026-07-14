import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../src/infrastructure/api/response/api_response.dart';
import '../../../../src/infrastructure/network/services/dio_client.dart';
import '../../../../src/infrastructure/storage/local_storage_service.dart';
import '../../../../src/logger/failure/exceptions/app_exception.dart';
import '../datasources/profile_data_source.dart';
import '../models/user_profile_model.dart';

part 'profile_repository.g.dart';

@Riverpod(keepAlive: true)
ProfileRepository profileRepository(Ref ref) {
  final networkService = ref.watch(networkServiceProvider());
  final localStorage = ref.watch(localStorageServiceProvider);
  return ProfileRepository(
    remoteDataSource: ProfileRemoteDataSource(networkService),
    localDataSource: ProfileLocalDataSource(localStorage),
  );
}

class ProfileRepository {
  ProfileRepository({
    required ProfileRemoteDataSource remoteDataSource,
    required ProfileLocalDataSource localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  final ProfileRemoteDataSource _remoteDataSource;
  final ProfileLocalDataSource _localDataSource;

  Future<ApiResponse<UserProfileModel>> getProfile() async {
    try {
      final result = await _remoteDataSource.getProfile();
      if (result.hasFailed) {
        throw AppException(message: result.message ?? 'Failed to fetch profile');
      }
      return result;
    } catch (_) {
      final profile = await _localDataSource.getProfile();
      return ApiResponse<UserProfileModel>.success(data: profile);
    }
  }

  Future<ApiResponse<void>> logout() async {
    try {
      final result = await _remoteDataSource.logout();
      if (result.hasFailed) {
        throw AppException(message: result.message ?? 'Failed to logout');
      }
    } catch (_) {
      // Remote logout is optional while endpoints are being integrated.
    }
    await _localDataSource.logout();
    return ApiResponse<void>.success();
  }
}
