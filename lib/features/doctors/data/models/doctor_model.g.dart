// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DoctorModel _$DoctorModelFromJson(Map<String, dynamic> json) => _DoctorModel(
  id: json['id'] as String,
  name: json['name'] as String,
  gender: json['gender'] as String,
  specialty: json['specialty'] as String,
  about: json['about'] as String,
  imageUrl: json['imageUrl'] as String,
  rating: (json['rating'] as num).toDouble(),
  reviewsCount: (json['reviewsCount'] as num).toInt(),
  experienceYears: (json['experienceYears'] as num).toInt(),
  patientsCount: (json['patientsCount'] as num).toInt(),
  availableDates: (json['availableDates'] as List<dynamic>)
      .map((e) => DateTime.parse(e as String))
      .toList(),
  availableTimes: (json['availableTimes'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  clinicAddress: json['clinicAddress'] as String,
  consultationFee: (json['consultationFee'] as num?)?.toDouble() ?? 0,
);

Map<String, dynamic> _$DoctorModelToJson(_DoctorModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'gender': instance.gender,
      'specialty': instance.specialty,
      'about': instance.about,
      'imageUrl': instance.imageUrl,
      'rating': instance.rating,
      'reviewsCount': instance.reviewsCount,
      'experienceYears': instance.experienceYears,
      'patientsCount': instance.patientsCount,
      'availableDates': instance.availableDates
          .map((e) => e.toIso8601String())
          .toList(),
      'availableTimes': instance.availableTimes,
      'clinicAddress': instance.clinicAddress,
      'consultationFee': instance.consultationFee,
    };
