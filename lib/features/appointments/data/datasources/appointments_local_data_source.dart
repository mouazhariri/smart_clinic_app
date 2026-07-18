import 'package:hive/hive.dart';

import '../../../../src/infrastructure/storage/hive/hive_boxes.dart';
import '../../domain/entities/appointment.dart';
import '../models/appointment_model.dart';

abstract class AppointmentsLocalDataSource {
  Future<List<AppointmentModel>> getAppointments();
  Future<void> saveAppointment(AppointmentModel appointment);
  Future<void> updateAppointment(AppointmentModel appointment);
}

class AppointmentsLocalDataSourceImpl implements AppointmentsLocalDataSource {
  static const String _boxName = HiveBoxesName.appointmentsBox;

  Future<Box<AppointmentModel>> _box() async {
    if (Hive.isBoxOpen(_boxName)) {
      return Hive.box<AppointmentModel>(_boxName);
    }
    return Hive.openBox<AppointmentModel>(_boxName);
  }

  @override
  Future<List<AppointmentModel>> getAppointments() async {
    final box = await _box();
    final appointments = box.values.toList();
    if (appointments.isEmpty) {
      appointments.addAll(_sampleAppointments());
    }
    appointments.sort((a, b) => a.date.compareTo(b.date));
    return appointments;
  }

  List<AppointmentModel> _sampleAppointments() {
    final now = DateTime.now();
    return [
      AppointmentModel(
        id: 'sample-appointment-1',
        doctorId: 'doctor-1',
        doctorName: 'doctor_sarah_ahmed',
        specialty: 'specialty_cardiologist',
        date: DateTime(now.year, now.month, now.day + 2),
        time: '10:30 AM',
        status: AppointmentStatus.confirmed,
        clinicAddress: 'address_al_sham_medical_center',
      ),
      AppointmentModel(
        id: 'sample-appointment-2',
        doctorId: 'doctor-2',
        doctorName: 'doctor_omar_khaled',
        specialty: 'specialty_dentist',
        date: DateTime(now.year, now.month, now.day - 5),
        time: '01:00 PM',
        status: AppointmentStatus.completed,
        clinicAddress: 'address_smile_clinic',
      ),
    ];
  }

  @override
  Future<void> saveAppointment(AppointmentModel appointment) async {
    final box = await _box();
    await box.put(appointment.id, appointment);
  }

  @override
  Future<void> updateAppointment(AppointmentModel appointment) async {
    await saveAppointment(appointment);
  }
}
