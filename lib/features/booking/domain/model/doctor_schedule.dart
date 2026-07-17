import 'package:equatable/equatable.dart';

class DoctorSchedule extends Equatable {
  const DoctorSchedule({
    required this.doctorId,
    required this.availableDates,
    required this.availableSlots,
  });

  final String doctorId;
  final List<DateTime> availableDates;
  final List<String> availableSlots;

  @override
  List<Object?> get props => [doctorId, availableDates, availableSlots];
}
