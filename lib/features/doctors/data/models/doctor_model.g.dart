// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_model.dart';

DoctorModel _$DoctorModelFromJson(Map<String, dynamic> json) => DoctorModel(
      id: json['id'] as String,
      name: json['name'] as String,
      specialty: json['specialty'] as String,
      about: json['about'] as String,
      imageUrl: json['imageUrl'] as String,
      rating: (json['rating'] as num).toDouble(),
      reviewsCount: (json['reviewsCount'] as num).toInt(),
      experienceYears: (json['experienceYears'] as num).toInt(),
      patientsCount: (json['patientsCount'] as num).toInt(),
      availableDates: (json['availableDates'] as List<dynamic>)
          .map((date) => DateTime.parse(date as String))
          .toList(),
      availableTimes: (json['availableTimes'] as List<dynamic>)
          .map((time) => time as String)
          .toList(),
      clinicAddress: json['clinicAddress'] as String,
    );

Map<String, dynamic> _$DoctorModelToJson(DoctorModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'specialty': instance.specialty,
      'about': instance.about,
      'imageUrl': instance.imageUrl,
      'rating': instance.rating,
      'reviewsCount': instance.reviewsCount,
      'experienceYears': instance.experienceYears,
      'patientsCount': instance.patientsCount,
      'availableDates': instance.availableDates
          .map((date) => date.toIso8601String())
          .toList(),
      'availableTimes': instance.availableTimes,
      'clinicAddress': instance.clinicAddress,
    };
