import '../entities/doctor.dart';
import '../repositories/doctors_repository.dart';

class GetDoctorByIdUseCase {
  const GetDoctorByIdUseCase(this._repository);

  final DoctorsRepository _repository;

  Future<Doctor> call(String id) => _repository.getDoctorById(id);
}
