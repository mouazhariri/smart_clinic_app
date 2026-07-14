import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/doctor.dart';

part 'doctor_model.freezed.dart';
part 'doctor_model.g.dart';

@freezed
abstract class DoctorModel with _$DoctorModel {
  const DoctorModel._();

  const factory DoctorModel({
    required String id,
    required String name,
    required String specialty,
    required String about,
    required String imageUrl,
    required double rating,
    required int reviewsCount,
    required int experienceYears,
    required int patientsCount,
    required List<DateTime> availableDates,
    required List<String> availableTimes,
    required String clinicAddress,
  }) = _DoctorModel;

  factory DoctorModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorModelFromJson(json);

  Doctor toEntity() {
    return Doctor(
      id: id,
      name: name,
      specialty: specialty,
      about: about,
      imageUrl: imageUrl,
      rating: rating,
      reviewsCount: reviewsCount,
      experienceYears: experienceYears,
      patientsCount: patientsCount,
      availableDates: availableDates,
      availableTimes: availableTimes,
      clinicAddress: clinicAddress,
    );
  }
}
