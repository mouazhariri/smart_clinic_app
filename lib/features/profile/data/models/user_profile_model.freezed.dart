// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

part of 'user_profile_model.dart';

mixin _$UserProfileModel {
  String get fullNameKey;
  String get emailKey;
  String get phoneKey;
  String get languageCode;
  String get themeKey;
  Map<String, dynamic> toJson();
}

class _UserProfileModel extends UserProfileModel {
  const _UserProfileModel({
    required this.fullNameKey,
    required this.emailKey,
    required this.phoneKey,
    required this.languageCode,
    required this.themeKey,
  }) : super._();

  @override
  final String fullNameKey;
  @override
  final String emailKey;
  @override
  final String phoneKey;
  @override
  final String languageCode;
  @override
  final String themeKey;

  @override
  Map<String, dynamic> toJson() => _$UserProfileModelToJson(this);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is _UserProfileModel &&
            fullNameKey == other.fullNameKey &&
            emailKey == other.emailKey &&
            phoneKey == other.phoneKey &&
            languageCode == other.languageCode &&
            themeKey == other.themeKey;
  }

  @override
  int get hashCode => Object.hash(
        fullNameKey,
        emailKey,
        phoneKey,
        languageCode,
        themeKey,
      );
}
