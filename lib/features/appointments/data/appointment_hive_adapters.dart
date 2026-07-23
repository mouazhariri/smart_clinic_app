import 'package:hive/hive.dart';

import '../../../src/infrastructure/storage/hive/hive_type_ids.dart';
import '../domain/model/appointment.dart';
import 'models/appointment_model.dart';

class AppointmentModelHiveAdapter extends TypeAdapter<AppointmentModel> {
  @override
  final int typeId = HiveTypeIds.appointmentId;

  @override
  AppointmentModel read(BinaryReader reader) {
    final numberOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (var i = 0; i < numberOfFields; i++) reader.readByte(): reader.read(),
    };

    return AppointmentModel(
      id: fields[0] as String,
      doctorId: fields[1] as String,
      doctorName: fields[2] as String,
      specialty: fields[3] as String,
      date: fields[4] as DateTime,
      time: fields[5] as String,
      status: AppointmentStatus.values[fields[6] as int],
      clinicAddress: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AppointmentModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.doctorId)
      ..writeByte(2)
      ..write(obj.doctorName)
      ..writeByte(3)
      ..write(obj.specialty)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.time)
      ..writeByte(6)
      ..write(obj.status.index)
      ..writeByte(7)
      ..write(obj.clinicAddress);
  }
}
