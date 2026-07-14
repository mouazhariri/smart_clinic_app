import 'package:hive/hive.dart';

import '../../../../src/infrastructure/storage/hive/hive_boxes.dart';
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
    final appointments = box.values.toList()
      ..sort((a, b) => a.date.compareTo(b.date));
    return appointments;
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
