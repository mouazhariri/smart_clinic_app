import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../src/resourses/font_manager/app_text_style.dart';
import '../../../doctors/presentation/widgets/smart_clinic_app_bar.dart';
import '../controller/appointments_controller.dart';
import '../controller/appointments_state.dart';
import '../widgets/appointment_card_widget.dart';

class AppointmentsScreen extends ConsumerWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state =
        ref.watch(appointmentsControllerProvider).value ?? AppointmentsState.init();
    final controller = ref.read(appointmentsControllerProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            SmartClinicAppBar(
              title: context.tr('appointments'),
              subtitle: context.tr('manage_appointments'),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: AppColors.transparent,
                indicator: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(14),
                ),
                labelColor: AppColors.white,
                unselectedLabelColor: AppColors.textSecondary,
                tabs: [
                  Tab(text: context.tr('upcoming')),
                  Tab(text: context.tr('history')),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _AppointmentList(
                    emptyMessage: context.tr('no_upcoming_appointments'),
                    itemCount: state.upcomingAppointments.length,
                    itemBuilder: (context, index) {
                      final appointment = state.upcomingAppointments[index];
                      return AppointmentCardWidget(
                        appointment: appointment,
                        onCancel: () => controller.cancelAppointment(appointment.id),
                      );
                    },
                  ),
                  _AppointmentList(
                    emptyMessage: context.tr('no_history_appointments'),
                    itemCount: state.historyAppointments.length,
                    itemBuilder: (context, index) => AppointmentCardWidget(
                      appointment: state.historyAppointments[index],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppointmentList extends StatelessWidget {
  const _AppointmentList({
    required this.emptyMessage,
    required this.itemCount,
    required this.itemBuilder,
  });

  final String emptyMessage;
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;

  @override
  Widget build(BuildContext context) {
    if (itemCount == 0) {
      return Center(
        child: Text(
          emptyMessage,
          textAlign: TextAlign.center,
          style: AppTextStyle.interMedium16.copyWith(color: AppColors.textSecondary),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      itemCount: itemCount,
      separatorBuilder: (_, __) => const SizedBox(height: 14),
      itemBuilder: itemBuilder,
    );
  }
}
