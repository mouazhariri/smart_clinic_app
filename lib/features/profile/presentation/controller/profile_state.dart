import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/user_profile.dart';

class ProfileState {
  const ProfileState({required this.profile, required this.logoutState});

  factory ProfileState.init() {
    return const ProfileState(
      profile: AsyncData(null),
      logoutState: AsyncData(null),
    );
  }

  final AsyncValue<UserProfile?> profile;
  final AsyncValue<void> logoutState;

  ProfileState copyWith({
    AsyncValue<UserProfile?>? profile,
    AsyncValue<void>? logoutState,
  }) {
    return ProfileState(
      profile: profile ?? this.profile,
      logoutState: logoutState ?? this.logoutState,
    );
  }
}
