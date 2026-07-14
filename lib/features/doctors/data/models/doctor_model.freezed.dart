// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

part of 'doctor_model.dart';

mixin _$DoctorModel {
  String get id;
  String get name;
  String get specialty;
  String get about;
  String get imageUrl;
  double get rating;
  int get reviewsCount;
  int get experienceYears;
  int get patientsCount;
  List<DateTime> get availableDates;
  List<String> get availableTimes;
  String get clinicAddress;

  Map<String, dynamic> toJson();
}

class _DoctorModel extends DoctorModel {
  const _DoctorModel({
    required this.id,
    required this.name,
    required this.specialty,
    required this.about,
    required this.imageUrl,
    required this.rating,
    required this.reviewsCount,
    required this.experienceYears,
    required this.patientsCount,
    required this.availableDates,
    required this.availableTimes,
    required this.clinicAddress,
  }) : super._();

  @override
  final String id;
  @override
  final String name;
  @override
  final String specialty;
  @override
  final String about;
  @override
  final String imageUrl;
  @override
  final double rating;
  @override
  final int reviewsCount;
  @override
  final int experienceYears;
  @override
  final int patientsCount;
  @override
  final List<DateTime> availableDates;
  @override
  final List<String> availableTimes;
  @override
  final String clinicAddress;

  @override
  Map<String, dynamic> toJson() => _$DoctorModelToJson(this);

  @override
  String toString() {
    return 'DoctorModel(id: $id, name: $name, specialty: $specialty, about: $about, imageUrl: $imageUrl, rating: $rating, reviewsCount: $reviewsCount, experienceYears: $experienceYears, patientsCount: $patientsCount, availableDates: $availableDates, availableTimes: $availableTimes, clinicAddress: $clinicAddress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is _DoctorModel &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            name == other.name &&
            specialty == other.specialty &&
            about == other.about &&
            imageUrl == other.imageUrl &&
            rating == other.rating &&
            reviewsCount == other.reviewsCount &&
            experienceYears == other.experienceYears &&
            patientsCount == other.patientsCount &&
            _listEquals(availableDates, other.availableDates) &&
            _listEquals(availableTimes, other.availableTimes) &&
            clinicAddress == other.clinicAddress;
  }

  @override
  int get hashCode => Object.hash(
        runtimeType,
        id,
        name,
        specialty,
        about,
        imageUrl,
        rating,
        reviewsCount,
        experienceYears,
        patientsCount,
        Object.hashAll(availableDates),
        Object.hashAll(availableTimes),
        clinicAddress,
      );
}

bool _listEquals<T>(List<T> left, List<T> right) {
  if (identical(left, right)) return true;
  if (left.length != right.length) return false;
  for (var i = 0; i < left.length; i++) {
    if (left[i] != right[i]) return false;
  }
  return true;
}
