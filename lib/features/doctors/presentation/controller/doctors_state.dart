import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/doctor.dart';

// ── Filter model ──────────────────────────────────────────────────────────
enum AvailabilityFilter { all, today, tomorrow, thisWeek }
enum GenderFilter { all, male, female }

class DoctorFilter {
  final AvailabilityFilter availability;
  final GenderFilter gender;
  final Set<int> minRatings; // e.g. {5} means "5 stars", {4} means "4+"
  final double? minPrice;
  final double? maxPrice;

  const DoctorFilter({
    this.availability = AvailabilityFilter.all,
    this.gender = GenderFilter.all,
    this.minRatings = const {},
    this.minPrice,
    this.maxPrice,
  });

  DoctorFilter copyWith({
    AvailabilityFilter? availability,
    GenderFilter? gender,
    Set<int>? minRatings,
    double? minPrice,
    double? maxPrice,
    bool clearMinPrice = false,
    bool clearMaxPrice = false,
  }) {
    return DoctorFilter(
      availability: availability ?? this.availability,
      gender: gender ?? this.gender,
      minRatings: minRatings ?? this.minRatings,
      minPrice: clearMinPrice ? null : (minPrice ?? this.minPrice),
      maxPrice: clearMaxPrice ? null : (maxPrice ?? this.maxPrice),
    );
  }

  bool get hasActiveFilters =>
      availability != AvailabilityFilter.all ||
      gender != GenderFilter.all ||
      minRatings.isNotEmpty ||
      minPrice != null ||
      maxPrice != null;

  /// Returns human-readable chip labels for active filters
  List<String> activeChipLabels({
    required String allAvailLabel,
    required String todayLabel,
    required String tomorrowLabel,
    required String thisWeekLabel,
    required String maleLabel,
    required String femaleLabel,
  }) {
    final chips = <String>[];
    if (availability == AvailabilityFilter.today) chips.add(todayLabel);
    if (availability == AvailabilityFilter.tomorrow) chips.add(tomorrowLabel);
    if (availability == AvailabilityFilter.thisWeek) chips.add(thisWeekLabel);
    if (gender == GenderFilter.male) chips.add(maleLabel);
    if (gender == GenderFilter.female) chips.add(femaleLabel);
    return chips;
  }
}

class DoctorsState {
  final AsyncValue<List<Doctor>> doctors;
  final String searchQuery;
  final DoctorFilter filter;

  const DoctorsState({
    required this.doctors,
    this.searchQuery = '',
    this.filter = const DoctorFilter(),
  });

  factory DoctorsState.init() => const DoctorsState(
        doctors: AsyncData([]),
      );

  List<Doctor> get filteredDoctors {
    final allDoctors = doctors.value ?? [];
    var result = allDoctors;

    // Search
    if (searchQuery.trim().isNotEmpty) {
      final q = searchQuery.trim().toLowerCase();
      result = result
          .where((d) =>
              d.name.toLowerCase().contains(q) ||
              d.specialty.toLowerCase().contains(q))
          .toList();
    }

    // Gender
    if (filter.gender == GenderFilter.male) {
      result = result.where((d) => d.gender == 'male').toList();
    } else if (filter.gender == GenderFilter.female) {
      result = result.where((d) => d.gender == 'female').toList();
    }

    // Rating
    if (filter.minRatings.isNotEmpty) {
      final minStar = filter.minRatings.reduce((a, b) => a > b ? a : b);
      result =
          result.where((d) => (d.rating ?? 0) >= minStar).toList();
    }

    // Price
    if (filter.minPrice != null) {
      result =
          result.where((d) => (d.price ?? 0) >= filter.minPrice!).toList();
    }
    if (filter.maxPrice != null) {
      result =
          result.where((d) => (d.price ?? 0) <= filter.maxPrice!).toList();
    }

    // Availability
    if (filter.availability != AvailabilityFilter.all) {
      final now = DateTime.now();
      result = result.where((d) {
        if (d.availableDates.isEmpty) return false;
        return d.availableDates.any((date) {
          switch (filter.availability) {
            case AvailabilityFilter.today:
              return date.year == now.year &&
                  date.month == now.month &&
                  date.day == now.day;
            case AvailabilityFilter.tomorrow:
              final tomorrow = now.add(const Duration(days: 1));
              return date.year == tomorrow.year &&
                  date.month == tomorrow.month &&
                  date.day == tomorrow.day;
            case AvailabilityFilter.thisWeek:
              final weekEnd = now.add(const Duration(days: 7));
              return date.isAfter(now) && date.isBefore(weekEnd);
            case AvailabilityFilter.all:
              return true;
          }
        });
      }).toList();
    }

    return result;
  }

  DoctorsState copyWith({
    AsyncValue<List<Doctor>>? doctors,
    String? searchQuery,
    DoctorFilter? filter,
  }) {
    return DoctorsState(
      doctors: doctors ?? this.doctors,
      searchQuery: searchQuery ?? this.searchQuery,
      filter: filter ?? this.filter,
    );
  }
}