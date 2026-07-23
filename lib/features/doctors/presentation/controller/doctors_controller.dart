import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/doctors_repository.dart';
import '../../domain/entities/doctor.dart';
import 'doctors_state.dart';

part 'doctors_controller.g.dart';

@Riverpod(keepAlive: true)
class DoctorsController extends _$DoctorsController {
  @override
  FutureOr<DoctorsState> build() async {
    final repo = ref.read(doctorsRepositoryProvider);
    final response = await repo.getDoctors();
    return DoctorsState(
      doctors: AsyncData(response.data ?? []),
      searchQuery: '',
      filter: const DoctorFilter(),
    );
  }

  Future<void> getDoctors() async {
    final current = state.value;
    if (current == null) return;
    state = AsyncData(current.copyWith(doctors: const AsyncLoading()));
    try {
      final repo = ref.read(doctorsRepositoryProvider);
      final response = await repo.getDoctors();
      if (response.hasFailed) {
        state = AsyncData(current.copyWith(
          doctors: AsyncError(
            response.message ?? 'Something went wrong',
            StackTrace.empty,
          ),
        ));
        return;
      }
      state = AsyncData(current.copyWith(
        doctors: AsyncData(response.data ?? []),
      ));
    } catch (e, st) {
      state = AsyncData(
          current.copyWith(doctors: AsyncError(e, st)));
    }
  }

  void updateSearchQuery(String query) {
    final current = state.value;
    if (current == null) return;
    state = AsyncData(current.copyWith(searchQuery: query));
  }

  void applyFilter(DoctorFilter filter) {
    final current = state.value;
    if (current == null) return;
    state = AsyncData(current.copyWith(filter: filter));
  }

  void clearFilter() {
    final current = state.value;
    if (current == null) return;
    state = AsyncData(current.copyWith(filter: const DoctorFilter()));
  }

  void removeAvailabilityFilter() {
    final current = state.value;
    if (current == null) return;
    state = AsyncData(current.copyWith(
      filter: current.filter
          .copyWith(availability: AvailabilityFilter.all),
    ));
  }

  void removeGenderFilter() {
    final current = state.value;
    if (current == null) return;
    state = AsyncData(current.copyWith(
      filter: current.filter.copyWith(gender: GenderFilter.all),
    ));
  }
}

final doctorDetailsProvider =
    FutureProvider.family<Doctor, String>((ref, id) async {
  final repo = ref.read(doctorsRepositoryProvider);
  final response = await repo.getDoctorById(id);
  if (response.hasFailed || response.data == null) {
    throw response.message ?? 'Something went wrong';
  }
  return response.data!;
});