import '../../../../src/infrastructure/storage/local_storage_service.dart';
import '../models/user_profile_model.dart';

abstract class ProfileLocalDataSource {
  Future<UserProfileModel> getProfile();
  Future<void> logout();
}

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  const ProfileLocalDataSourceImpl(this._localStorageService);

  final LocalStorageService _localStorageService;

  @override
  Future<UserProfileModel> getProfile() async {
    return const UserProfileModel(
      fullNameKey: 'sample_user_full_name',
      emailKey: 'sample_user_email',
      phoneKey: 'sample_user_phone',
      languageCode: 'en',
      themeKey: 'system_default',
    );
  }

  @override
  Future<void> logout() => _localStorageService.logout();
}
