import '../model/appointment.dart';
import '../repositories/appointments_repository.dart';

class BookAppointmentUseCase {
  const BookAppointmentUseCase(this._repository);

  final AppointmentsRepository _repository;

  Future<void> call(Appointment appointment) {
    return _repository.bookAppointment(appointment);
  }
}
