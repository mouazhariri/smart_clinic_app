import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/appointment.dart';

part 'appointment_model.freezed.dart';
part 'appointment_model.g.dart';

@freezed
abstract class AppointmentModel with _$AppointmentModel {
  const AppointmentModel._();

  const factory AppointmentModel({
    required String id,
    required String doctorId,
    required String doctorName,
    required String specialty,
    required DateTime date,
    required String time,
    required AppointmentStatus status,
    required String clinicAddress,
  }) = _AppointmentModel;

  factory AppointmentModel.fromJson(Map<String, dynamic> json) =>
      _$AppointmentModelFromJson(json);

  factory AppointmentModel.fromEntity(Appointment appointment) {
    return AppointmentModel(
      id: appointment.id,
      doctorId: appointment.doctorId,
      doctorName: appointment.doctorName,
      specialty: appointment.specialty,
      date: appointment.date,
      time: appointment.time,
      status: appointment.status,
      clinicAddress: appointment.clinicAddress,
    );
  }

  Appointment toEntity() {
    return Appointment(
      id: id,
      doctorId: doctorId,
      doctorName: doctorName,
      specialty: specialty,
      date: date,
      time: time,
      status: status,
      clinicAddress: clinicAddress,
    );
  }

  AppointmentModel copyWith({AppointmentStatus? status}) {
    return AppointmentModel(
      id: id,
      doctorId: doctorId,
      doctorName: doctorName,
      specialty: specialty,
      date: date,
      time: time,
      status: status ?? this.status,
      clinicAddress: clinicAddress,
    );
  }
}
