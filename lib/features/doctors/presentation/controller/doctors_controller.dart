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
    Future<void>.microtask(() async { await getDoctors(); });
    return DoctorsState.init();
  }

  Future<List<Doctor>?> getDoctors() async {
    try {
      state = AsyncData(state.value!.copyWith(doctors: const AsyncLoading()));
      final repo = ref.read(doctorsRepositoryProvider);
      final response = await repo.getDoctors();

      if (response.hasFailed) {
        state = AsyncData(
          state.value!.copyWith(
            doctors: AsyncError(
              response.message ?? 'Something went wrong',
              StackTrace.fromString(response.message ?? ''),
            ),
          ),
        );
        return null;
      }

      final doctors = response.data?.map((model) => model.toEntity()).toList() ?? [];
      state = AsyncData(state.value!.copyWith(doctors: AsyncData(doctors)));
      return doctors;
    } catch (e, st) {
      state = AsyncData(state.value!.copyWith(doctors: AsyncError(e, st)));
      return null;
    }
  }

  void updateSearchQuery(String query) {
    final currentState = state.value;
    if (currentState == null) return;
    state = AsyncData(currentState.copyWith(searchQuery: query));
  }
}

final doctorDetailsProvider = FutureProvider.family<Doctor, String>((ref, id) async {
  final repo = ref.read(doctorsRepositoryProvider);
  final response = await repo.getDoctorById(id);
  if (response.hasFailed || response.data == null) {
    throw response.message ?? 'Something went wrong';
  }
  return response.data!.toEntity();
});
