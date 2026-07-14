// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_model.dart';

HomeModel _$HomeModelFromJson(Map<String, dynamic> json) => HomeModel(
      userNameKey: json['userNameKey'] as String? ?? 'sample_user_name',
      bannerTitleKey:
          json['bannerTitleKey'] as String? ?? 'healthcare_made_easy',
      bannerDescriptionKey: json['bannerDescriptionKey'] as String? ??
          'healthcare_made_easy_desc',
    );

Map<String, dynamic> _$HomeModelToJson(HomeModel instance) =>
    <String, dynamic>{
      'userNameKey': instance.userNameKey,
      'bannerTitleKey': instance.bannerTitleKey,
      'bannerDescriptionKey': instance.bannerDescriptionKey,
    };
