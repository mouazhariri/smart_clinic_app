import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/user_profile.dart';

part 'profile_state.freezed.dart';

@freezed
abstract class ProfileState with _$ProfileState {
  const factory ProfileState({
    required AsyncValue<UserProfile?> profile,
    required AsyncValue<void> logoutState,
  }) = _ProfileState;

  factory ProfileState.init() => const ProfileState(
        profile: AsyncData(null),
        logoutState: AsyncData(null),
      );
}