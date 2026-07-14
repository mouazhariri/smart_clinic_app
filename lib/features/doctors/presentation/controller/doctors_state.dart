import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/doctor.dart';

class DoctorsState {
  const DoctorsState({
    required this.doctors,
    this.searchQuery = '',
  });

  factory DoctorsState.init() {
    return const DoctorsState(doctors: AsyncData([]));
  }

  final AsyncValue<List<Doctor>> doctors;
  final String searchQuery;

  List<Doctor> get filteredDoctors {
    final items = doctors.valueOrNull ?? [];
    if (searchQuery.trim().isEmpty) return items;
    final query = searchQuery.toLowerCase();
    return items
        .where(
          (doctor) =>
              doctor.name.toLowerCase().contains(query) ||
              doctor.specialty.toLowerCase().contains(query),
        )
        .toList();
  }

  DoctorsState copyWith({
    AsyncValue<List<Doctor>>? doctors,
    String? searchQuery,
  }) {
    return DoctorsState(
      doctors: doctors ?? this.doctors,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}
