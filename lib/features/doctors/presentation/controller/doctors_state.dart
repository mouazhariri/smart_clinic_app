import 'package:equatable/equatable.dart';

import '../../domain/entities/doctor.dart';

class DoctorsState extends Equatable {
  const DoctorsState({
    this.doctors = const [],
    this.isLoading = false,
    this.searchQuery = '',
    this.errorMessage,
  });

  final List<Doctor> doctors;
  final bool isLoading;
  final String searchQuery;
  final String? errorMessage;

  List<Doctor> get filteredDoctors {
    if (searchQuery.trim().isEmpty) return doctors;
    final query = searchQuery.toLowerCase();
    return doctors
        .where(
          (doctor) =>
              doctor.name.toLowerCase().contains(query) ||
              doctor.specialty.toLowerCase().contains(query),
        )
        .toList();
  }

  DoctorsState copyWith({
    List<Doctor>? doctors,
    bool? isLoading,
    String? searchQuery,
    String? errorMessage,
  }) {
    return DoctorsState(
      doctors: doctors ?? this.doctors,
      isLoading: isLoading ?? this.isLoading,
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [doctors, isLoading, searchQuery, errorMessage];
}
