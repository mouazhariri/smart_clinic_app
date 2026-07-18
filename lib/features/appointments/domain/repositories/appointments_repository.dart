import '../entities/appointment.dart';

abstract class AppointmentsRepository {
  Future<List<Appointment>> getAppointments();
  Future<void> bookAppointment(Appointment appointment);
  Future<void> cancelAppointment(String appointmentId);
}
