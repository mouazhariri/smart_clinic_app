import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_local_data_source.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  const ProfileRepositoryImpl(this._localDataSource);

  final ProfileLocalDataSource _localDataSource;

  @override
  Future<UserProfile> getProfile() async {
    final model = await _localDataSource.getProfile();
    return model.toEntity();
  }

  @override
  Future<void> logout() => _localDataSource.logout();
}
