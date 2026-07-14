// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

part of 'appointment_model.dart';

mixin _$AppointmentModel {
  String get id;
  String get doctorId;
  String get doctorName;
  String get specialty;
  DateTime get date;
  String get time;
  AppointmentStatus get status;
  String get clinicAddress;

  Map<String, dynamic> toJson();
}

class _AppointmentModel extends AppointmentModel {
  const _AppointmentModel({
    required this.id,
    required this.doctorId,
    required this.doctorName,
    required this.specialty,
    required this.date,
    required this.time,
    required this.status,
    required this.clinicAddress,
  }) : super._();

  @override
  final String id;
  @override
  final String doctorId;
  @override
  final String doctorName;
  @override
  final String specialty;
  @override
  final DateTime date;
  @override
  final String time;
  @override
  final AppointmentStatus status;
  @override
  final String clinicAddress;

  @override
  Map<String, dynamic> toJson() => _$AppointmentModelToJson(this);

  @override
  String toString() {
    return 'AppointmentModel(id: $id, doctorId: $doctorId, doctorName: $doctorName, specialty: $specialty, date: $date, time: $time, status: $status, clinicAddress: $clinicAddress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is _AppointmentModel &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            doctorId == other.doctorId &&
            doctorName == other.doctorName &&
            specialty == other.specialty &&
            date == other.date &&
            time == other.time &&
            status == other.status &&
            clinicAddress == other.clinicAddress;
  }

  @override
  int get hashCode => Object.hash(
        runtimeType,
        id,
        doctorId,
        doctorName,
        specialty,
        date,
        time,
        status,
        clinicAddress,
      );
}
