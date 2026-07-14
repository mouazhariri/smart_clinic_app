import 'package:equatable/equatable.dart';

class Appointment extends Equatable {
  const Appointment({
    required this.id,
    required this.doctorId,
    required this.doctorName,
    required this.specialty,
    required this.date,
    required this.time,
    required this.status,
    required this.clinicAddress,
  });

  final String id;
  final String doctorId;
  final String doctorName;
  final String specialty;
  final DateTime date;
  final String time;
  final AppointmentStatus status;
  final String clinicAddress;

  bool get isUpcoming =>
      status != AppointmentStatus.cancelled &&
      DateTime(date.year, date.month, date.day).isAfter(
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 1),
      );

  @override
  List<Object?> get props => [
        id,
        doctorId,
        doctorName,
        specialty,
        date,
        time,
        status,
        clinicAddress,
      ];
}

enum AppointmentStatus { confirmed, pending, completed, cancelled }
