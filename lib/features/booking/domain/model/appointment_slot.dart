import 'package:equatable/equatable.dart';

class AppointmentSlot extends Equatable {
  const AppointmentSlot({
    required this.time,
    required this.isAvailable,
    this.isSelected = false,
  });

  final String time;
  final bool isAvailable;
  final bool isSelected;

  AppointmentSlot copyWith({String? time, bool? isAvailable, bool? isSelected}) {
    return AppointmentSlot(
      time: time ?? this.time,
      isAvailable: isAvailable ?? this.isAvailable,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  List<Object?> get props => [time, isAvailable, isSelected];
}
