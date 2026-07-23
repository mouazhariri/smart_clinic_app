
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:smart_clinic_app/features/appointments/domain/model/appointment.dart';
import 'package:smart_clinic_app/features/appointments/presentation/controller/appointment_controller.dart';
import 'package:smart_clinic_app/src/core/shared_widgets/custom_button_widget.dart';

import '../../../../src/application/router/app_routes.dart';
import '../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../src/resourses/font_manager/app_text_style.dart';
import '../controller/session_controller.dart';

class SessionDetailsScreen extends ConsumerWidget {
  final String appointmentId;
  const SessionDetailsScreen({super.key, required this.appointmentId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appointment = ref.watch(appointmentByIdProvider(appointmentId));
    final sessionState = ref.watch(sessionControllerProvider(appointmentId));

    if (appointment == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator(color: AppColors.primary)));
    }

   final session = appointment.sessionDetails;

final isCompleted = appointment.status == AppointmentStatus.completed;
final isCancelled = appointment.status == AppointmentStatus.cancelled;

/// A completed appointment might not have session data because it was removed,
/// unavailable, or has not been loaded from API yet.
final isSessionUnavailable = isCompleted && session == null;

/// User can book again when appointment was cancelled or session is unavailable.
final canBookAgain = isCancelled || isSessionUnavailable;

/// Follow-up is shown only when session exists and doctor requested it.
final shouldShowFollowUp =
    session != null && session.requestedFollowUp && !canBookAgain;

final locale = context.locale.languageCode;
final formattedDate = DateFormat(
  'EEEE، d MMMM yyyy',
  locale,
).format(appointment.date);

return Scaffold(
  backgroundColor: AppColors.background,
  appBar: AppBar(
    backgroundColor: AppColors.background,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    leading: IconButton(
      icon: const Icon(
        Icons.arrow_back_ios_new_rounded,
        // matchTextDirection: true,
        color: AppColors.authTitle,
        size: 20,
      ),
      onPressed: () => context.pop(),
    ),
    title: Text(
      context.tr('session_details'),
      style: AppTextStyle.tajawalBold18.copyWith(
        color: AppColors.authTitle,
      ),
    ),
    centerTitle: true,
  ),
  body: SingleChildScrollView(
    padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SessionSummaryCard(
          appointment: appointment,
          formattedDate: formattedDate,
        ),
        const SizedBox(height: 16),

        /// Cancelled appointment.
        if (isCancelled) ...[
          _SessionUnavailableCard(
            icon: Icons.event_busy_outlined,
            title: context.tr('appointment_cancelled_title'),
            message: context.tr('appointment_cancelled_message'),
            color: AppColors.errorRed,
            backgroundColor: const Color(0xFFFFEEEE),
          ),
        ]

        /// Completed appointment but its session details are unavailable.
        else if (isSessionUnavailable) ...[
          _SessionUnavailableCard(
            icon: Icons.description_outlined,
            title: context.tr('session_not_available_title'),
            message: context.tr('session_not_available_message'),
            color: AppColors.metricOrangeIcon,
            backgroundColor: AppColors.metricOrange,
          ),
        ]

        /// Normal completed appointment session details.
        else if (session != null) ...[
          _DiagnosisCard(diagnosis: session.diagnosis),
          const SizedBox(height: 16),

          _MedicationsCard(medications: session.medications),
          const SizedBox(height: 16),

          _RequiredTestsCard(
            tests: session.requiredTests,
            onUpload: (testName) {
              _showUploadSheet(context, ref, testName);
            },
          ),

          if (shouldShowFollowUp) ...[
            const SizedBox(height: 16),
            _FollowUpBanner(
              onBook: () => context.go(AppRoutes.doctorsScreen),
            ),
          ],
        ]

        /// For an appointment that reaches this screen without a session.
        else ...[
          _SessionUnavailableCard(
            icon: Icons.info_outline_rounded,
            title: context.tr('session_not_ready_title'),
            message: context.tr('session_not_ready_message'),
            color: AppColors.primary,
            backgroundColor: AppColors.primaryBg,
          ),
        ],
      ],
    ),
  ),

  /// Fixed button under the screen.
  bottomNavigationBar: canBookAgain
      ? _BookAgainBottomBar(
          isCancelled: isCancelled,
          onBookAgain: () {
            context.go(AppRoutes.doctorsScreen);
          },
        )
      : shouldShowFollowUp
          ? _SessionBottomBar(
              onBookFollowUp: () {
                context.go(AppRoutes.doctorsScreen);
              },
            )
          : null,
);
  }

  void _showUploadSheet(BuildContext context, WidgetRef ref, String testName) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _UploadResultSheet(
        testName: testName,
        onConfirm: () {
          ref.read(sessionControllerProvider(appointmentId).notifier).uploadTestResult(testName);
          Navigator.pop(context);
        },
      ),
    );
  }
}

class _SessionSummaryCard extends StatelessWidget {
  final Appointment appointment;
  final String formattedDate;

  const _SessionSummaryCard({required this.appointment, required this.formattedDate});

  @override
  Widget build(BuildContext context) {
    final isCompleted = appointment.status == AppointmentStatus.completed;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.divider),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundImage: appointment.doctorImageUrl != null
                    ? NetworkImage(appointment.doctorImageUrl!)
                    : null,
                backgroundColor: AppColors.dashNeutralBg,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appointment.doctorName,
                      style: AppTextStyle.tajawalBold16.copyWith(color: AppColors.authTitle),
                    ),
                    Text(
                      appointment.doctorSpecialty,
                      style: AppTextStyle.tajawalRegular12.copyWith(color: AppColors.authSubtitle),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isCompleted ? const Color(0xFFE8F5E9) : AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  isCompleted ? context.tr('status_completed') : context.tr('status_confirmed'),
                  style: AppTextStyle.tajawalSemiBold14.copyWith(
                    color: isCompleted ? const Color(0xFF2E7D32) : AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Divider(height: 1, color: AppColors.divider),
          const SizedBox(height: 14),
          Row(
            children: [
              const Icon(Icons.calendar_today_outlined, size: 16, color: AppColors.authSubtitle),
              const SizedBox(width: 8),
              Text(
                formattedDate,
                style: AppTextStyle.tajawalRegular14.copyWith(color: AppColors.authSubtitle),
              ),
              const Spacer(),
              const Icon(Icons.access_time_outlined, size: 16, color: AppColors.authSubtitle),
              const SizedBox(width: 6),
              Text(
                appointment.time,
                style: AppTextStyle.tajawalRegular14.copyWith(color: AppColors.authSubtitle),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DiagnosisCard extends StatelessWidget {
  final String diagnosis;
  const _DiagnosisCard({required this.diagnosis});

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: context.tr('diagnosis_and_notes'),
      child: Text(
        diagnosis,
        style: AppTextStyle.tajawalRegular14.copyWith(
          color: AppColors.authSubtitle,
          height: 1.6,
        ),
      ),
    );
  }
}

class _MedicationsCard extends StatelessWidget {
  final List<Medication> medications;
  const _MedicationsCard({required this.medications});

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: context.tr('medical_prescription'),
      child: Column(
        children: medications.map((med) => _MedRow(med: med)).toList(),
      ),
    );
  }
}

class _MedRow extends StatelessWidget {
  final Medication med;
  const _MedRow({required this.med});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.medication_outlined, color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  med.name,
                  style: AppTextStyle.tajawalBold14.copyWith(color: AppColors.authTitle),
                ),
                const SizedBox(height: 2),
                Text(
                  '${med.dosage} • ${med.frequency}',
                  style: AppTextStyle.tajawalRegular12.copyWith(color: AppColors.authSubtitle),
                ),
                if (med.note != null)
                  Text(
                    med.note!,
                    style: AppTextStyle.tajawalRegular12.copyWith(color: const Color(0xFF9E9E9E)),
                  ),
              ],
            ),
          ),
          const Icon(Icons.content_copy_outlined, size: 18, color: Color(0xFFCCCCCC)),
        ],
      ),
    );
  }
}

class _RequiredTestsCard extends StatelessWidget {
  final List<RequiredTest> tests;
  final ValueChanged<String> onUpload;

  const _RequiredTestsCard({required this.tests, required this.onUpload});

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: context.tr('required_tests'),
      child: Column(
        children: tests.map((t) => _TestRow(test: t, onUpload: onUpload)).toList(),
      ),
    );
  }
}

class _TestRow extends StatelessWidget {
  final RequiredTest test;
  final ValueChanged<String> onUpload;

  const _TestRow({required this.test, required this.onUpload});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.science_outlined, size: 18, color: AppColors.authSubtitle),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  test.name,
                  style: AppTextStyle.tajawalBold14.copyWith(color: AppColors.authTitle),
                ),
              ),
            ],
          ),
          if (test.description != null) ...[
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 26),
              child: Text(
                test.description!,
                style: AppTextStyle.tajawalRegular12.copyWith(color: AppColors.authSubtitle),
              ),
            ),
          ],
          const SizedBox(height: 10),
          // Dashed border upload button
          GestureDetector(
            onTap: () => onUpload(test.name),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.primary.withOpacity(0.4), width: 1.5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.cloud_upload_outlined, color: AppColors.primary, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    test.attachedFileUrl != null ? context.tr('view_result') : context.tr('upload_result'),
                    style: AppTextStyle.tajawalSemiBold14.copyWith(color: AppColors.primary),
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

class _FollowUpBanner extends StatelessWidget {
  final VoidCallback onBook;
  const _FollowUpBanner({required this.onBook});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF4FF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline_rounded, color: AppColors.primary, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              context.tr('follow_up_requested'),
              style: AppTextStyle.tajawalRegular12.copyWith(color: AppColors.primary, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}

class _SessionBottomBar extends StatelessWidget {
  final VoidCallback onBookFollowUp;
  const _SessionBottomBar({required this.onBookFollowUp});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: EdgeInsets.fromLTRB(16, 12, 16, MediaQuery.of(context).padding.bottom + 12),
      child: CustomButtonWidget(
        text: 'book_follow_up',
        isFiled: true,
        backgroundColor: AppColors.primary,
        color: AppColors.white,
        height: 52,
        width: double.infinity,
        radius: 14,
        onTap: onBookFollowUp,
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;
  const _SectionCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.divider),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyle.tajawalBold16.copyWith(color: AppColors.authTitle)),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

class _UploadResultSheet extends StatelessWidget {
  final String testName;
  final VoidCallback onConfirm;

  const _UploadResultSheet({required this.testName, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.fromLTRB(20, 20, 20, MediaQuery.of(context).padding.bottom + 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(color: const Color(0xFFEEEEEE), borderRadius: BorderRadius.circular(2)),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.close_rounded, color: AppColors.authTitle),
              ),
              const Spacer(),
              Text(context.tr('attach_result'), style: AppTextStyle.tajawalBold18.copyWith(color: AppColors.authTitle)),
              const Spacer(),
              const SizedBox(width: 24),
            ],
          ),
          const SizedBox(height: 6),
          Text(testName, style: AppTextStyle.tajawalRegular14.copyWith(color: AppColors.authSubtitle)),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: onConfirm,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 32),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F6FA),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFDDDDDD)),
              ),
              child: Column(
                children: [
                  const Icon(Icons.cloud_upload_outlined, color: AppColors.primary, size: 40),
                  const SizedBox(height: 12),
                  Text(context.tr('tap_to_upload'), style: AppTextStyle.tajawalBold14.copyWith(color: AppColors.authTitle)),
                  const SizedBox(height: 4),
                  Text(context.tr('upload_formats'), style: AppTextStyle.tajawalRegular12.copyWith(color: AppColors.authSubtitle)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          CustomButtonWidget(
            text: 'confirm_and_send',
            isFiled: true,
            backgroundColor: AppColors.primary,
            color: AppColors.white,
            height: 52,
            width: double.infinity,
            radius: 14,
            onTap: onConfirm,
          ),
        ],
      ),
    );
  }
}

class _SessionUnavailableCard extends StatelessWidget {
  const _SessionUnavailableCard({
    required this.icon,
    required this.title,
    required this.message,
    required this.color,
    required this.backgroundColor,
  });

  final IconData icon;
  final String title;
  final String message;
  final Color color;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 27,
              color: color,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyle.tajawalBold16.copyWith(
              color: AppColors.authTitle,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppTextStyle.tajawalRegular14.copyWith(
              color: AppColors.authSubtitle,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _BookAgainBottomBar extends StatelessWidget {
  const _BookAgainBottomBar({
    required this.isCancelled,
    required this.onBookAgain,
  });

  final bool isCancelled;
  final VoidCallback onBookAgain;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(
            color: AppColors.divider,
          ),
        ),
      ),
      padding: EdgeInsets.fromLTRB(
        16,
        14,
        16,
        MediaQuery.of(context).padding.bottom + 14,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            isCancelled
                ? context.tr('appointment_cancelled_book_again_hint')
                : context.tr('session_unavailable_book_again_hint'),
            textAlign: TextAlign.center,
            style: AppTextStyle.tajawalRegular12.copyWith(
              color: AppColors.authSubtitle,
            ),
          ),
          const SizedBox(height: 12),
          CustomButtonWidget(
            text: isCancelled
                ? 'book_new_appointment'
                : 'book_again',
            isFiled: true,
            backgroundColor: AppColors.primary,
            color: AppColors.primary,
            height: 52,
            width: double.infinity,
            radius: 14,
            elevation: 0,
            style: AppTextStyle.tajawalBold16.copyWith(
              color: AppColors.white,
            ),
            onTap: onBookAgain,
          ),
        ],
      ),
    );
  }
}