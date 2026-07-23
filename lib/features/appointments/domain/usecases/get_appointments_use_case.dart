import '../model/appointment.dart';
import '../repositories/appointments_repository.dart';

class GetAppointmentsUseCase {
  const GetAppointmentsUseCase(this._repository);

  final AppointmentsRepository _repository;

  Future<List<Appointment>> call() => _repository.getAppointments();
}
