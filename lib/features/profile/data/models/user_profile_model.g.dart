// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserProfileModel _$UserProfileModelFromJson(Map<String, dynamic> json) =>
    _UserProfileModel(
      fullNameKey: json['fullNameKey'] as String,
      emailKey: json['emailKey'] as String,
      phoneKey: json['phoneKey'] as String,
      languageCode: json['languageCode'] as String,
      themeKey: json['themeKey'] as String,
    );

Map<String, dynamic> _$UserProfileModelToJson(_UserProfileModel instance) =>
    <String, dynamic>{
      'fullNameKey': instance.fullNameKey,
      'emailKey': instance.emailKey,
      'phoneKey': instance.phoneKey,
      'languageCode': instance.languageCode,
      'themeKey': instance.themeKey,
    };
