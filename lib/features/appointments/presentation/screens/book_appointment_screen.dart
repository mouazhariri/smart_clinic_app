import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../src/application/router/app_routes.dart';
import '../../../../src/core/shared_widgets/app_loader.dart';
import '../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../src/resourses/font_manager/app_text_style.dart';
import '../../../doctors/presentation/controller/doctors_controller.dart';
import '../../../doctors/presentation/widgets/smart_clinic_app_bar.dart';
import '../controller/appointments_controller.dart';
import '../controller/appointments_state.dart';
import '../widgets/appointment_date_selector.dart';
import '../widgets/appointment_summary.dart';
import '../widgets/available_time_widget.dart';

class BookAppointmentScreen extends ConsumerWidget {
  const BookAppointmentScreen({super.key, required this.doctorId});

  final String doctorId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doctorAsync = ref.watch(doctorDetailsProvider(doctorId));
    final appointmentState =
        ref.watch(appointmentsControllerProvider).valueOrNull ?? AppointmentsState.init();
    final appointmentController = ref.read(appointmentsControllerProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: doctorAsync.when(
        loading: () => const Center(child: AppLoader()),
        error: (_, __) => Center(child: Text(context.tr('no_doctors_found'))),
        data: (doctor) => Column(
          children: [
            SmartClinicAppBar(
              title: context.tr('book_appointment'),
              subtitle: context.tr(doctor.name),
              showBackButton: true,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(context.tr('select_date'), style: AppTextStyle.interBold18),
                    const SizedBox(height: 12),
                    AppointmentDateSelector(
                      dates: doctor.availableDates,
                      selectedDate: appointmentState.selectedDate,
                      onSelected: appointmentController.selectDate,
                    ),
                    const SizedBox(height: 24),
                    Text(context.tr('available_time'), style: AppTextStyle.interBold18),
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
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: FilledButton(
                        onPressed: appointmentState.canConfirm(doctor) && !appointmentState.bookingState.isLoading
                            ? () async {
                                final booked = await appointmentController.bookAppointment(doctor);
                                if (context.mounted && booked) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(context.tr('appointment_booked_successfully'))),
                                  );
                                  context.go(AppRoutes.appointmentsScreen);
                                }
                              }
                            : null,
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          disabledBackgroundColor: AppColors.disabledButton,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        child: appointmentState.bookingState.isLoading
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.white,
                                ),
                              )
                            : Text(context.tr('confirm_booking')),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
