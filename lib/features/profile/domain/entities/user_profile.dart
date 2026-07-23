import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';

@freezed
abstract class UserProfile with _$UserProfile {
  const UserProfile._();

  const factory UserProfile({
    required String fullName,
    required String qid,
    required String email,
    String? phoneNumber,
    String? avatarUrl,
  }) = _UserProfile;

  factory UserProfile.empty() => const UserProfile(
        fullName: '',
        qid: '',
        email: '',
      );

  /// Fallback initials shown in the avatar circle when there's no photo.
  String get initials {
    final trimmed = fullName.trim();
    if (trimmed.isEmpty) return 'SU';
    final parts = trimmed.split(RegExp(r'\s+'));
    final first = parts.first.isNotEmpty ? parts.first[0] : '';
    final last = parts.length > 1 && parts.last.isNotEmpty ? parts.last[0] : '';
    return (first + last).toUpperCase();
  }
}