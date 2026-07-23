// lib/features/appointments/presentation/controller/session_controller.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smart_clinic_app/features/appointments/presentation/controller/appointment_controller.dart';

import '../../domain/model/appointment.dart';


part 'session_controller.g.dart';

class SessionState {
  final Appointment? appointment;
  final bool isUploadingFile;
  final String? uploadedFilePath;
  final String? uploadError;

  const SessionState({
    this.appointment,
    this.isUploadingFile = false,
    this.uploadedFilePath,
    this.uploadError,
  });

  SessionState copyWith({
    Appointment? appointment,
    bool? isUploadingFile,
    String? uploadedFilePath,
    String? uploadError,
  }) {
    return SessionState(
      appointment: appointment ?? this.appointment,
      isUploadingFile: isUploadingFile ?? this.isUploadingFile,
      uploadedFilePath: uploadedFilePath ?? this.uploadedFilePath,
      uploadError: uploadError,
    );
  }
}

@riverpod
class SessionController extends _$SessionController {
  @override
  SessionState build(String appointmentId) {
    final apt = ref.watch(appointmentByIdProvider(appointmentId));
    return SessionState(appointment: apt);
  }

  Future<void> uploadTestResult(String testName) async {
    state = state.copyWith(isUploadingFile: true);
    // TODO: real file picker + upload
    await Future.delayed(const Duration(seconds: 1)); // fake
    state = state.copyWith(
      isUploadingFile: false,
      uploadedFilePath: '/uploaded/$testName.pdf',
    );
  }

  Future<void> bookFollowUp() async {
    // TODO: navigate to booking with same doctor pre-filled
  }
}