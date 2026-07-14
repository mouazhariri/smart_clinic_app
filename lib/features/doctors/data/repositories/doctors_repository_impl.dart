import '../../domain/entities/doctor.dart';
import '../../domain/repositories/doctors_repository.dart';
import '../datasources/doctors_local_data_source.dart';
import '../datasources/doctors_remote_data_source.dart';

class DoctorsRepositoryImpl implements DoctorsRepository {
  const DoctorsRepositoryImpl({
    required DoctorsLocalDataSource localDataSource,
    required DoctorsRemoteDataSource remoteDataSource,
  })  : _localDataSource = localDataSource,
        _remoteDataSource = remoteDataSource;

  final DoctorsLocalDataSource _localDataSource;
  final DoctorsRemoteDataSource _remoteDataSource;

  static const bool _useRemoteDataSource = false;

  @override
  Future<List<Doctor>> getDoctors() async {
    final models = _useRemoteDataSource
        ? await _remoteDataSource.getDoctors()
        : await _localDataSource.getDoctors();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<Doctor> getDoctorById(String id) async {
    final model = _useRemoteDataSource
        ? await _remoteDataSource.getDoctorById(id)
        : await _localDataSource.getDoctorById(id);
    return model.toEntity();
  }
}
