import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../src/infrastructure/storage/local_storage_service.dart';
import '../../data/datasources/profile_local_data_source.dart';
import '../../data/repositories/profile_repository_impl.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../domain/usecases/get_profile_use_case.dart';
import '../../domain/usecases/logout_use_case.dart';
import 'profile_state.dart';

final profileLocalDataSourceProvider = Provider<ProfileLocalDataSource>(
  (ref) => ProfileLocalDataSourceImpl(ref.watch(localStorageServiceProvider)),
);

final profileRepositoryProvider = Provider<ProfileRepository>(
  (ref) => ProfileRepositoryImpl(ref.watch(profileLocalDataSourceProvider)),
);

final getProfileUseCaseProvider = Provider<GetProfileUseCase>(
  (ref) => GetProfileUseCase(ref.watch(profileRepositoryProvider)),
);

final logoutUseCaseProvider = Provider<LogoutUseCase>(
  (ref) => LogoutUseCase(ref.watch(profileRepositoryProvider)),
);

final profileControllerProvider =
    StateNotifierProvider<ProfileController, ProfileState>(
  (ref) => ProfileController(
    getProfileUseCase: ref.watch(getProfileUseCaseProvider),
    logoutUseCase: ref.watch(logoutUseCaseProvider),
  )..loadProfile(),
);

class ProfileController extends StateNotifier<ProfileState> {
  ProfileController({
    required GetProfileUseCase getProfileUseCase,
    required LogoutUseCase logoutUseCase,
  })  : _getProfileUseCase = getProfileUseCase,
        _logoutUseCase = logoutUseCase,
        super(const ProfileState());

  final GetProfileUseCase _getProfileUseCase;
  final LogoutUseCase _logoutUseCase;

  Future<void> loadProfile() async {
    state = state.copyWith(isLoading: true);
    try {
      final profile = await _getProfileUseCase();
      state = state.copyWith(profile: profile, isLoading: false);
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'something_went_wrong_please_try_again_later',
      );
    }
  }

  Future<void> logout() async {
    await _logoutUseCase();
  }
}
