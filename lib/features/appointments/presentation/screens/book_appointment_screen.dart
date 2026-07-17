import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../src/application/router/app_routes.dart';
import '../../../../src/core/shared_widgets/app_loader.dart';
import '../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../src/resourses/font_manager/app_text_style.dart';
import '../../../doctors/domain/entities/doctor.dart';
import '../../../doctors/presentation/controller/doctors_controller.dart';
import '../../../doctors/presentation/widgets/smart_clinic_app_bar.dart';
import '../controller/appointments_controller.dart';
import '../controller/appointments_state.dart';
import '../widgets/appointment_date_selector.dart';
import '../widgets/appointment_summary.dart';
import '../widgets/available_time_widget.dart';
import '../widgets/booking_confirm_button.dart';
import '../widgets/booking_section_header.dart';

/// Clean, structured booking appointment screen.
/// Follows clean architecture by separating:
/// - UI layout (this screen)
/// - State management (Riverpod controller)
/// - Widget components (separate files)
class BookAppointmentScreen extends ConsumerWidget {
  const BookAppointmentScreen({
    super.key,
    required this.doctorId,
  });

  final String doctorId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doctorAsync = ref.watch(doctorDetailsProvider(doctorId));
    final appointmentState =
        ref.watch(appointmentsControllerProvider).value ?? AppointmentsState.init();
    final appointmentController = ref.read(appointmentsControllerProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: doctorAsync.when(
        loading: () => const Center(child: AppLoader()),
        error: (_, stackTrace) => _ErrorState(doctorId: doctorId),
        data: (doctor) => _BookingContent(
              doctor: doctor,
              appointmentState: appointmentState,
              appointmentController: appointmentController,
            ),
      ),
    );
  }
}

/// Separate error widget to keep screen clean.
class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.doctorId});
  final String doctorId;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(context.tr('no_doctors_found')),
    );
  }
}

/// Main content for booking, separated for readability.
class _BookingContent extends StatelessWidget {
  const _BookingContent({
    required this.doctor,
    required this.appointmentState,
    required this.appointmentController,
  });

  final Doctor doctor;
  final AppointmentsState appointmentState;
  final AppointmentsController appointmentController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SmartClinicAppBar(
          title: context.tr('book_appointment'),
          subtitle: doctor.name,
          showBackButton: true,
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BookingSectionHeader(title: context.tr('select_date')),
                const SizedBox(height: 12),
                AppointmentDateSelector(
                  dates: doctor.availableDates,
                  selectedDate: appointmentState.selectedDate,
                  onSelected: appointmentController.selectDate,
                ),
                const SizedBox(height: 24),
                BookingSectionHeader(title: context.tr('available_time')),
                const SizedBox(height: 12),
                AvailableTimeWidget(
                  times: doctor.availableTimes,
                  selectedTime: appointmentState.selectedTime,
                  onSelected: appointmentController.selectTime,
                ),
                const SizedBox(height: 24),
                AppointmentSummary(
                  doctor: doctor,
                  selectedDate: appointmentState.selectedDate,
                  selectedTime: appointmentState.selectedTime,
                ),
                const SizedBox(height: 24),
                BookingConfirmButton(
                  isEnabled: appointmentState.canConfirm(doctor) &&
                      !appointmentState.bookingState.isLoading,
                  isLoading: appointmentState.bookingState.isLoading,
                  onPressed: () => _handleConfirm(context, doctor, appointmentController, appointmentState),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _handleConfirm(
    BuildContext context,
    Doctor doctor,
    AppointmentsController controller,
    AppointmentsState state,
  ) async {
    final booked = await controller.bookAppointment(doctor);
    if (context.mounted && booked) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.tr('appointment_booked_successfully')),
        ),
      );
      context.go(AppRoutes.appointmentsScreen);
    }
  }
}
