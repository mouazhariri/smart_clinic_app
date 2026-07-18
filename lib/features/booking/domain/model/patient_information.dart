class PatientInformation {
  final DateTime? birthDate;
  final String? city;
  final String? gender;

  const PatientInformation({
    this.birthDate,
    this.city,
    this.gender,
  });

  PatientInformation copyWith({
    DateTime? birthDate,
    String? city,
    String? gender,
  }) {
    return PatientInformation(
      birthDate: birthDate ?? this.birthDate,
      city: city ?? this.city,
      gender: gender ?? this.gender,
    );
  }
}