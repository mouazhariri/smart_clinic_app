// lib/features/appointments/domain/models/appointment.dart
import 'package:equatable/equatable.dart';

enum AppointmentStatus {
  confirmed,   // مؤكد
  waiting,     // قيد الانتظار
  inClinic,    // في العيادة الآن
  completed,   // مكتملة
  cancelled,   // ملغاة
}

class Appointment extends Equatable {
  final String id;
  final String doctorId;
  final String doctorName;
  final String doctorSpecialty;
  final String? doctorImageUrl;
  final DateTime date;
  final String time;
  final AppointmentStatus status;
  final int? queueNumber;
  final int? currentTurn;
  final int? estimatedWaitMinutes;
  final int? patientsAhead;
  final String? clinicAddress;
  final String? phoneNumber;
  final SessionDetails? sessionDetails;

  const Appointment({
    required this.id,
    required this.doctorId,
    required this.doctorName,
    required this.doctorSpecialty,
    this.doctorImageUrl,
    required this.date,
    required this.time,
    required this.status,
    this.queueNumber,
    this.currentTurn,
    this.estimatedWaitMinutes,
    this.patientsAhead,
    this.clinicAddress,
    this.phoneNumber,
    this.sessionDetails,
  });

  bool get isToday {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  bool get isUpcoming {
    return status == AppointmentStatus.confirmed ||
        status == AppointmentStatus.waiting ||
        status == AppointmentStatus.inClinic;
  }

  bool get isPast {
    return status == AppointmentStatus.completed ||
        status == AppointmentStatus.cancelled;
  }

  @override
  List<Object?> get props => [id, doctorId, date, time, status];
}

class SessionDetails extends Equatable {
  final String diagnosis;
  final List<Medication> medications;
  final List<RequiredTest> requiredTests;
  final bool requestedFollowUp;

  const SessionDetails({
    required this.diagnosis,
    this.medications = const [],
    this.requiredTests = const [],
    this.requestedFollowUp = false,
  });

  @override
  List<Object?> get props =>
      [diagnosis, medications, requiredTests, requestedFollowUp];
}

class Medication extends Equatable {
  final String name;
  final String dosage;
  final String frequency;
  final String? note;

  const Medication({
    required this.name,
    required this.dosage,
    required this.frequency,
    this.note,
  });

  @override
  List<Object?> get props => [name, dosage, frequency];
}

class RequiredTest extends Equatable {
  final String name;
  final String? description;
  final String? attachedFileUrl;

  const RequiredTest({
    required this.name,
    this.description,
    this.attachedFileUrl,
  });

  @override
  List<Object?> get props => [name, description];
}