import 'package:equatable/equatable.dart';

class PatientInformation extends Equatable {
  const PatientInformation({
    this.birthDate,
    this.gender,
    this.city,
  });

  final DateTime? birthDate;
  final String? gender;
  final String? city;

  PatientInformation copyWith({
    DateTime? birthDate,
    String? gender,
    String? city,
  }) {
    return PatientInformation(
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      city: city ?? this.city,
    );
  }

  @override
  List<Object?> get props => [birthDate, gender, city];
}
