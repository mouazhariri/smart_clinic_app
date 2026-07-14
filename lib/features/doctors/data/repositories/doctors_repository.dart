import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../src/infrastructure/api/response/api_response.dart';
import '../../../../src/infrastructure/network/services/dio_client.dart';
import '../../../../src/logger/failure/exceptions/app_exception.dart';
import '../datasources/doctors_local_data_source.dart';
import '../datasources/doctors_remote_data_source.dart';
import '../models/doctor_model.dart';

part 'doctors_repository.g.dart';

@Riverpod(keepAlive: true)
DoctorsRepository doctorsRepository(Ref ref) {
  final networkService = ref.watch(networkServiceProvider());
  return DoctorsRepository(
    remoteDataSource: DoctorsRemoteDataSource(networkService),
    localDataSource: const DoctorsLocalDataSourceImpl(),
  );
}

class DoctorsRepository {
  DoctorsRepository({
    required DoctorsRemoteDataSource remoteDataSource,
    required DoctorsLocalDataSource localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  final DoctorsRemoteDataSource _remoteDataSource;
  final DoctorsLocalDataSource _localDataSource;

  Future<ApiResponse<List<DoctorModel>>> getDoctors() async {
    try {
      final result = await _remoteDataSource.getDoctors();
      if (result.hasFailed) {
        throw AppException(message: result.message ?? 'Failed to fetch doctors');
      }
      return result;
    } catch (_) {
      final localDoctors = await _localDataSource.getDoctors();
      return ApiResponse<List<DoctorModel>>.success(data: localDoctors);
    }
  }

  Future<ApiResponse<DoctorModel>> getDoctorById(String id) async {
    try {
      final result = await _remoteDataSource.getDoctorById(id);
      if (result.hasFailed) {
        throw AppException(
          message: result.message ?? 'Failed to fetch doctor details',
        );
      }
      return result;
    } catch (_) {
      final localDoctor = await _localDataSource.getDoctorById(id);
      return ApiResponse<DoctorModel>.success(data: localDoctor);
    }
  }
}
