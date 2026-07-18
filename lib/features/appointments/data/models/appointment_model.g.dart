// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppointmentModel _$AppointmentModelFromJson(Map<String, dynamic> json) =>
    _AppointmentModel(
      id: json['id'] as String,
      doctorId: json['doctorId'] as String,
      doctorName: json['doctorName'] as String,
      specialty: json['specialty'] as String,
      date: DateTime.parse(json['date'] as String),
      time: json['time'] as String,
      status: $enumDecode(_$AppointmentStatusEnumMap, json['status']),
      clinicAddress: json['clinicAddress'] as String,
    );

Map<String, dynamic> _$AppointmentModelToJson(_AppointmentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'doctorId': instance.doctorId,
      'doctorName': instance.doctorName,
      'specialty': instance.specialty,
      'date': instance.date.toIso8601String(),
      'time': instance.time,
      'status': _$AppointmentStatusEnumMap[instance.status]!,
      'clinicAddress': instance.clinicAddress,
    };

const _$AppointmentStatusEnumMap = {
  AppointmentStatus.confirmed: 'confirmed',
  AppointmentStatus.pending: 'pending',
  AppointmentStatus.completed: 'completed',
  AppointmentStatus.cancelled: 'cancelled',
};
