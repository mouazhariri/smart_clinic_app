import 'package:equatable/equatable.dart';

class Doctor extends Equatable {
  const Doctor({
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
  });

  final String id;
  final String name;
  final String specialty;
  final String about;
  final String imageUrl;
  final double rating;
  final int reviewsCount;
  final int experienceYears;
  final int patientsCount;
  final List<DateTime> availableDates;
  final List<String> availableTimes;
  final String clinicAddress;

  @override
  List<Object?> get props => [
        id,
        name,
        specialty,
        about,
        imageUrl,
        rating,
        reviewsCount,
        experienceYears,
        patientsCount,
        availableDates,
        availableTimes,
        clinicAddress,
      ];
}
