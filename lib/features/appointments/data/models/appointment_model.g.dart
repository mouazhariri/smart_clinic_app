// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_model.dart';

AppointmentModel _$AppointmentModelFromJson(Map<String, dynamic> json) =>
    AppointmentModel(
      id: json['id'] as String,
      doctorId: json['doctorId'] as String,
      doctorName: json['doctorName'] as String,
      specialty: json['specialty'] as String,
      date: DateTime.parse(json['date'] as String),
      time: json['time'] as String,
      status: AppointmentStatus.values.firstWhere(
        (status) => status.name == json['status'],
        orElse: () => AppointmentStatus.pending,
      ),
      clinicAddress: json['clinicAddress'] as String,
    );

Map<String, dynamic> _$AppointmentModelToJson(AppointmentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'doctorId': instance.doctorId,
      'doctorName': instance.doctorName,
      'specialty': instance.specialty,
      'date': instance.date.toIso8601String(),
      'time': instance.time,
      'status': instance.status.name,
      'clinicAddress': instance.clinicAddress,
    };
