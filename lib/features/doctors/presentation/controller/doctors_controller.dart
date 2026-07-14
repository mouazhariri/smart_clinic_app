import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../src/infrastructure/network/services/dio_client.dart';
import '../../data/datasources/doctors_local_data_source.dart';
import '../../data/datasources/doctors_remote_data_source.dart';
import '../../data/repositories/doctors_repository_impl.dart';
import '../../domain/entities/doctor.dart';
import '../../domain/repositories/doctors_repository.dart';
import '../../domain/usecases/get_doctor_by_id_use_case.dart';
import '../../domain/usecases/get_doctors_use_case.dart';
import 'doctors_state.dart';

final doctorsLocalDataSourceProvider = Provider<DoctorsLocalDataSource>(
  (ref) => const DoctorsLocalDataSourceImpl(),
);

final doctorsRemoteDataSourceProvider = Provider<DoctorsRemoteDataSource>(
  (ref) => DoctorsRemoteDataSourceImpl(ref.watch(networkServiceProvider())),
);

final doctorsRepositoryProvider = Provider<DoctorsRepository>(
  (ref) => DoctorsRepositoryImpl(
    localDataSource: ref.watch(doctorsLocalDataSourceProvider),
    remoteDataSource: ref.watch(doctorsRemoteDataSourceProvider),
  ),
);

final getDoctorsUseCaseProvider = Provider<GetDoctorsUseCase>(
  (ref) => GetDoctorsUseCase(ref.watch(doctorsRepositoryProvider)),
);

final getDoctorByIdUseCaseProvider = Provider<GetDoctorByIdUseCase>(
  (ref) => GetDoctorByIdUseCase(ref.watch(doctorsRepositoryProvider)),
);

final doctorsControllerProvider =
    StateNotifierProvider<DoctorsController, DoctorsState>(
  (ref) => DoctorsController(ref.watch(getDoctorsUseCaseProvider))..loadDoctors(),
);

final doctorDetailsProvider = FutureProvider.family<Doctor, String>((ref, id) {
  return ref.watch(getDoctorByIdUseCaseProvider).call(id);
});

class DoctorsController extends StateNotifier<DoctorsState> {
  DoctorsController(this._getDoctorsUseCase) : super(const DoctorsState());

  final GetDoctorsUseCase _getDoctorsUseCase;

  Future<void> loadDoctors() async {
    state = state.copyWith(isLoading: true);
    try {
      final doctors = await _getDoctorsUseCase();
      state = state.copyWith(doctors: doctors, isLoading: false);
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'something_went_wrong_please_try_again_later',
      );
    }
  }

  void updateSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }
}
