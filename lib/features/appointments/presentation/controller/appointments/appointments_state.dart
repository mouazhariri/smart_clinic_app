// lib/features/appointments/presentation/controller/appointments_state.dart
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/model/appointment.dart';


enum AppointmentsTab { all, upcoming, past }

class AppointmentsState extends Equatable {
  final AsyncValue<List<Appointment>> appointments;
  final AppointmentsTab activeTab;

  const AppointmentsState({
    this.appointments = const AsyncData([]),
    this.activeTab = AppointmentsTab.all,
  });

  factory AppointmentsState.init() => const AppointmentsState();

  List<Appointment> get allList => appointments.value ?? [];

  /// TODAY appointments (in-clinic or confirmed today)
  List<Appointment> get todayAppointments => allList
      .where((a) => a.isToday && a.isUpcoming)
      .toList()
    ..sort((a, b) => a.date.compareTo(b.date));

  /// UPCOMING — confirmed or waiting, NOT today
  List<Appointment> get upcomingAppointments => allList
      .where((a) => a.isUpcoming && !a.isToday)
      .toList()
    ..sort((a, b) => a.date.compareTo(b.date));

  /// PAST — completed or cancelled
  List<Appointment> get pastAppointments => allList
      .where((a) => a.isPast)
      .toList()
    ..sort((a, b) => b.date.compareTo(a.date)); // most recent first

  int get upcomingCount =>
      allList.where((a) => a.isUpcoming).length;

  int get pastCount => allList.where((a) => a.isPast).length;

  int get allCount => allList.length;

  AppointmentsState copyWith({
    AsyncValue<List<Appointment>>? appointments,
    AppointmentsTab? activeTab,
  }) {
    return AppointmentsState(
      appointments: appointments ?? this.appointments,
      activeTab: activeTab ?? this.activeTab,
    );
  }

  @override
  List<Object?> get props => [appointments, activeTab];
}