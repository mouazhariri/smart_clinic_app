import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user_profile.dart';

part 'user_profile_model.freezed.dart';
part 'user_profile_model.g.dart';

@freezed
abstract class UserProfileModel with _$UserProfileModel {
  const UserProfileModel._();

  const factory UserProfileModel({
    required String fullNameKey,
    required String emailKey,
    required String phoneKey,
    required String languageCode,
    required String themeKey,
  }) = _UserProfileModel;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);

  UserProfile toEntity() {
    return UserProfile(
      fullName: fullNameKey,
      qid: phoneKey,
      email: emailKey,
      phoneNumber: phoneKey
    );
  }
}
