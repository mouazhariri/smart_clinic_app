// lib/features/appointments/presentation/screens/appointment_tracking_screen.dart
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'package:smart_clinic_app/features/appointments/domain/model/appointment.dart';
import 'package:smart_clinic_app/features/appointments/presentation/controller/appointment_controller.dart';
import 'package:smart_clinic_app/src/core/shared_widgets/custom_button_widget.dart';
import 'package:smart_clinic_app/src/resourses/color_manager/app_colors.dart';
import 'package:smart_clinic_app/src/resourses/font_manager/app_text_style.dart';

class AppointmentTrackingScreen extends ConsumerWidget {
  const AppointmentTrackingScreen({
    super.key,
    required this.appointmentId,
  });

  final String appointmentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appointment = ref.watch(appointmentByIdProvider(appointmentId));

    if (appointment == null) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: const _TrackingAppBar(),
        body: const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),

      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const _TrackingAppBar(),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Green banner
            if (appointment.status == AppointmentStatus.waiting ||
                appointment.status == AppointmentStatus.inClinic) ...[
              const _ClinicOpenBanner(),
              const SizedBox(height: 24),
            ],

            // Blue queue card
            if (appointment.queueNumber != null) ...[
              _QueueCard(appointment: appointment),
              const SizedBox(height: 18),
            ],

            // Doctor row
            _TrackingDoctorCard(appointment: appointment),
            const SizedBox(height: 18),

            // Timeline
            _TrackingTimeline(status: appointment.status),
            const SizedBox(height: 24),

            // Arrival buttons section (bottom)
            _ArrivalActions(
              appointmentId: appointment.id,
              status: appointment.status,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
     bottomNavigationBar: _TrackingActionsBottomBar(
    appointmentId: appointment.id,
    status: appointment.status,
  ),
    );
  }
}

class _TrackingAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _TrackingAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        onPressed: context.pop,
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          // matchTextDirection: true,
          size: 20,
          color: AppColors.textPrimary,
        ),
      ),
      title: Text(
        context.tr('track_appointment'),
        style: AppTextStyle.tajawalBold16.copyWith(
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}

class _ClinicOpenBanner extends StatelessWidget {
  const _ClinicOpenBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.metricGreen,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.circle,
            size: 8,
            color: AppColors.metricGreenIcon,
          ),
          const SizedBox(width: 8),
          Text(
            context.tr('clinic_open_now'),
            style: AppTextStyle.tajawalMedium12.copyWith(
              color: AppColors.metricGreenIcon,
            ),
          ),
        ],
      ),
    );
  }
}

class _QueueCard extends StatelessWidget {
  const _QueueCard({required this.appointment});

  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    final currentTurn = appointment.currentTurn ?? 0;
    final queueNumber = appointment.queueNumber ?? 0;
    final patientsAhead = appointment.patientsAhead ?? 0;
    final waitMinutes = appointment.estimatedWaitMinutes ?? 0;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _QueueItem(
                  label: context.tr('current_turn'),
                  value: '$currentTurn',
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _QueueItem(
                  label: context.tr('your_queue_number'),
                  value: '$queueNumber',
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _QueueItem(
                  label: context.tr('patients_ahead'),
                  value: '$patientsAhead ${context.tr('patients')}',
                  icon: Icons.people_outline_rounded,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _QueueItem(
                  label: context.tr('estimated_wait'),
                  value: '$waitMinutes ${context.tr('minutes')}',
                  icon: Icons.hourglass_bottom_rounded,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QueueItem extends StatelessWidget {
  const _QueueItem({
    required this.label,
    required this.value,
    this.icon,
  });

  final String label;
  final String value;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 66,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(.12),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 13,
                  color: AppColors.white70,
                ),
                const SizedBox(width: 4),
              ],
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.tajawalRegular10.copyWith(
                    color: AppColors.white70,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 3),
          Text(
            value,
            style: AppTextStyle.tajawalBold14.copyWith(
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _TrackingDoctorCard extends StatelessWidget {
  const _TrackingDoctorCard({required this.appointment});

  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: AppColors.dashNeutralBg,
            backgroundImage: appointment.doctorImageUrl != null
                ? NetworkImage(appointment.doctorImageUrl!)
                : null,
            child: appointment.doctorImageUrl == null
                ? const Icon(
                    Icons.person_outline_rounded,
                    color: AppColors.primary,
                  )
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appointment.doctorName,
                  style: AppTextStyle.tajawalBold14.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  appointment.doctorSpecialty,
                  style: AppTextStyle.tajawalRegular12.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          if (appointment.phoneNumber != null)
            InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: () {
                // TODO: Add url_launcher phone call here.
              },
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.phone_outlined,
                  size: 25,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _TrackingTimeline extends StatelessWidget {
  const _TrackingTimeline({required this.status});

  final AppointmentStatus status;

  int get _activeStep {
    switch (status) {
      case AppointmentStatus.confirmed:
        return 0;
      case AppointmentStatus.waiting:
        return 1;
      case AppointmentStatus.inClinic:
        return 2;
      case AppointmentStatus.completed:
        return 3;
      case AppointmentStatus.cancelled:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final activeStep = _activeStep;

    final steps = [
      context.tr('step_booking_confirmed'),
      context.tr('step_waiting_turn'),
      context.tr('step_in_clinic'),
      context.tr('step_session_done'),
    ];

    final subtitles = [
      context.tr('booking_confirmed_subtitle'),
      context.tr('waiting_turn_subtitle'),
      context.tr('in_clinic_subtitle'),
      context.tr('session_done_subtitle'),
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.tr('appointment_status'),
            style: AppTextStyle.tajawalBold14.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 18),
          for (var index = 0; index < steps.length; index++)
            _TimelineItem(
              title: steps[index],
              subtitle: subtitles[index],
              isCompleted: index <= activeStep,
              isActive: index == activeStep,
              isLast: index == steps.length - 1,
            ),
        ],
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  const _TimelineItem({
    required this.title,
    required this.subtitle,
    required this.isCompleted,
    required this.isActive,
    required this.isLast,
  });

  final String title;
  final String subtitle;
  final bool isCompleted;
  final bool isActive;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final color = isCompleted ? AppColors.primary : AppColors.border;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 24,
            child: Column(
              children: [
                Container(
                  width: 11,
                  height: 11,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isCompleted ? AppColors.primary : AppColors.border,
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 1.5,
                      color: color,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyle.tajawalSemiBold14.copyWith(
                      color: isActive ? AppColors.primary : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: AppTextStyle.tajawalRegular10.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class _TrackingActionsBottomBar extends ConsumerWidget {
  const _TrackingActionsBottomBar({
    required this.appointmentId,
    required this.status,
  });

  final String appointmentId;
  final AppointmentStatus status;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canConfirmArrival = status == AppointmentStatus.confirmed ||
        status == AppointmentStatus.waiting;

    // Do not show bottom actions after appointment is completed/cancelled.
    // if (!canConfirmArrival) {
    //   return const SizedBox.shrink();
    // }

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(
            color: AppColors.divider,
            width: 1,
          ),
        ),
      ),
      padding: EdgeInsetsDirectional.fromSTEB(
        20,
        20,
        20,
        MediaQuery.of(context).padding.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.tr('arrived_at_clinic'),
            style: AppTextStyle.tajawalBold18.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            context.tr('arrived_hint'),
            style: AppTextStyle.tajawalRegular12.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 18),

          CustomButtonWidget(
            text: 'i_am_in_clinic',
            isFiled: true,
            width: double.infinity,
            height: 52,
            radius: 10,
            backgroundColor: AppColors.primary,
            color: AppColors.primary,
            elevation: 0,
            style: AppTextStyle.tajawalBold16.copyWith(
              color: AppColors.white,
            ),
            onTap: () {
              ref
                  .read(appointmentControllerProvider.notifier)
                  .confirmArrival(appointmentId);
            },
          ),

          const SizedBox(height: 14),

          CustomButtonWidget(
            text: 'report_clinic_late',
            isFiled: false,
            width: double.infinity,
            height: 52,
            radius: 10,
            backgroundColor: AppColors.homeIconBackground,
            color: AppColors.homeIconBackground,
            elevation: 0,
            style: AppTextStyle.tajawalBold16.copyWith(
              color: AppColors.textSecondary,
            ),
            onTap: () {
              ref
                  .read(appointmentControllerProvider.notifier)
                  .reportLate(appointmentId);
            },
          ),
        ],
      ),
    );
  }
}
class _ArrivalActions extends ConsumerWidget {
  const _ArrivalActions({
    required this.appointmentId,
    required this.status,
  });

  final String appointmentId;
  final AppointmentStatus status;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canConfirmArrival = status == AppointmentStatus.confirmed ||
        status == AppointmentStatus.waiting;

    if (!canConfirmArrival) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.tr('arrived_at_clinic'),
          style: AppTextStyle.tajawalBold14.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          context.tr('arrived_hint'),
          style: AppTextStyle.tajawalRegular12.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 16),
        
        // Primary button: "I am in clinic now"
        CustomButtonWidget(
          text: 'i_am_in_clinic',
          isFiled: true,
          width: double.infinity,
          height: 52,
          radius: 12,
          backgroundColor: AppColors.primary,
          color: AppColors.white,
          elevation: 0,
          style: AppTextStyle.tajawalBold16.copyWith(
            color: AppColors.white,
          ),
          onTap: () {
            ref.read(appointmentControllerProvider.notifier).confirmArrival(appointmentId);
          },
        ),
        const SizedBox(height: 12),
        
        // Secondary button: "Report late arrival"
        CustomButtonWidget(
          text: 'report_clinic_late',
          isFiled: false,
          width: double.infinity,
          height: 52,
          radius: 12,
          backgroundColor: AppColors.white,
          color: AppColors.textSecondary,
          elevation: 0,
          style: AppTextStyle.tajawalBold16.copyWith(
            color: AppColors.textSecondary,
          ),
          onTap: () {
            ref.read(appointmentControllerProvider.notifier).reportLate(appointmentId);
          },
        ),
      ],
    );
  }
}