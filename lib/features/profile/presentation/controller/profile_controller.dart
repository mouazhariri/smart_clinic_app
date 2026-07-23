import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/user_profile.dart';
import '../../data/repositories/profile_repository.dart';
import 'profile_state.dart';

part 'profile_controller.g.dart';

@Riverpod(keepAlive: true)
class ProfileController extends _$ProfileController {
  @override
  FutureOr<ProfileState> build() async {
    Future<void>.microtask(() async { await getProfile(); });
    return ProfileState.init();
  }

  Future<UserProfile?> getProfile() async {
    try {
      state = AsyncData(state.value!.copyWith(profile: const AsyncLoading()));
      final repo = ref.read(profileRepositoryProvider);
      final response = await repo.getProfile();

      if (response.hasFailed) {
        state = AsyncData(
          state.value!.copyWith(
            profile: AsyncError(
              response.message ?? 'Something went wrong',
              StackTrace.fromString(response.message ?? ''),
            ),
          ),
        );
        return null;
      }

      final profile = response.data?.toEntity();
      state = AsyncData(state.value!.copyWith(profile: AsyncData(profile)));
      return profile;
    } catch (e, st) {
      state = AsyncData(state.value!.copyWith(profile: AsyncError(e, st)));
      return null;
    }
  }

  Future<void> logout() async {
    try {
      state = AsyncData(state.value!.copyWith(logoutState: const AsyncLoading()));
      final repo = ref.read(profileRepositoryProvider);
      final response = await repo.logout();

      if (response.hasFailed) {
        state = AsyncData(
          state.value!.copyWith(
            logoutState: AsyncError(
              response.message ?? 'Something went wrong',
              StackTrace.fromString(response.message ?? ''),
            ),
          ),
        );
        return;
      }

      state = AsyncData(state.value!.copyWith(logoutState: const AsyncData(null)));
    } catch (e, st) {
      state = AsyncData(state.value!.copyWith(logoutState: AsyncError(e, st)));
    }
  }
}