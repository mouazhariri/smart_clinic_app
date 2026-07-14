import '../repositories/appointments_repository.dart';

class CancelAppointmentUseCase {
  const CancelAppointmentUseCase(this._repository);

  final AppointmentsRepository _repository;

  Future<void> call(String appointmentId) {
    return _repository.cancelAppointment(appointmentId);
  }
}
