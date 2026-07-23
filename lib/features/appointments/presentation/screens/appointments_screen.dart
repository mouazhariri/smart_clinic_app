// lib/features/appointments/presentation/screens/appointments_screen.dart
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:smart_clinic_app/features/appointments/presentation/controller/appointments/appointments_controller.dart';
import 'package:smart_clinic_app/src/core/shared_widgets/custom_button_widget.dart';

import '../../../../src/application/router/app_routes.dart';
import '../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../src/resourses/font_manager/app_text_style.dart';
import '../../domain/model/appointment.dart';
import '../controller/appointments/appointments_state.dart';

class AppointmentsScreen extends ConsumerStatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  ConsumerState<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends ConsumerState<AppointmentsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  static const _tabsOrder = [
    AppointmentsTab.all,
    AppointmentsTab.upcoming,
    AppointmentsTab.past,
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabsOrder.length, vsync: this);
    _tabController.addListener(_handleTabControllerChange);
  }

  void _handleTabControllerChange() {
    if (_tabController.indexIsChanging) return;
    final tab = _tabsOrder[_tabController.index];
    final current = ref.read(appointmentsControllerProvider).value?.activeTab;
    if (current != tab) {
      ref.read(appointmentsControllerProvider.notifier).setTab(tab);
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabControllerChange);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final asyncState = ref.watch(appointmentsControllerProvider);
    final state = asyncState.value ?? AppointmentsState.init();
    final controller = ref.read(appointmentsControllerProvider.notifier);

    ref.listen(appointmentsControllerProvider, (previous, next) {
      final tab = next.value?.activeTab;
      if (tab == null) return;
      final index = _tabsOrder.indexOf(tab);
      if (index != -1 &&
          index != _tabController.index &&
          !_tabController.indexIsChanging) {
        _tabController.animateTo(index);
      }
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const _AppointmentsAppBar(),
          _TabSelector(
            tabController: _tabController,
            allCount: state.allCount,
            upcomingCount: state.upcomingCount,
            pastCount: state.pastCount,
          ),
          Expanded(
            child: asyncState.isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  )
                : TabBarView(
                    controller: _tabController,
                    children: [
                      RefreshIndicator(
                        onRefresh: controller.refresh,
                        child: _AllTab(
                          state: state,
                          onCancel: controller.cancelAppointment,
                        ),
                      ),
                      RefreshIndicator(
                        onRefresh: controller.refresh,
                        child: _UpcomingTab(
                          state: state,
                          onCancel: controller.cancelAppointment,
                        ),
                      ),
                      RefreshIndicator(
                        onRefresh: controller.refresh,
                        child: _PastTab(state: state),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

class _AppointmentsAppBar extends StatelessWidget {
  const _AppointmentsAppBar();

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top;
    return Container(
      width: double.infinity,
      color: AppColors.white,
      padding: EdgeInsets.fromLTRB(20, top + 12, 20, 16),
      child: Text(
        context.tr('appointment_requests'),
        textAlign: TextAlign.center,
        style: AppTextStyle.tajawalBold18.copyWith(color: AppColors.authTitle),
      ),
    );
  }
}

class _TabSelector extends StatelessWidget {
  const _TabSelector({
    required this.tabController,
    required this.allCount,
    required this.upcomingCount,
    required this.pastCount,
  });

  final TabController tabController;
  final int allCount;
  final int upcomingCount;
  final int pastCount;

  String _label(BuildContext context, String key, int count) {
    return '${context.tr(key)} ($count)';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(bottom: BorderSide(color: AppColors.divider, width: 1)),
      ),
      child: TabBar(
        controller: tabController,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: AppColors.primary,
        indicatorWeight: 3,
        splashFactory: NoSplash.splashFactory,
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.authSubtitle,
        labelStyle: AppTextStyle.tajawalBold14,
        unselectedLabelStyle: AppTextStyle.tajawalSemiBold14,
        tabs: [
          Tab(text: _label(context, 'tab_all', allCount)),
          Tab(text: _label(context, 'tab_upcoming', upcomingCount)),
          Tab(text: _label(context, 'tab_past', pastCount)),
        ],
      ),
    );
  }
}

class _AllTab extends StatelessWidget {
  const _AllTab({required this.state, required this.onCancel});

  final AppointmentsState state;
  final ValueChanged<String> onCancel;

  @override
  Widget build(BuildContext context) {
    final today = state.todayAppointments;
    final upcoming = state.upcomingAppointments;
    final past = state.pastAppointments;

    if (today.isEmpty && upcoming.isEmpty && past.isEmpty) {
      return _EmptyState(message: context.tr('no_appointments'));
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      children: [
        if (today.isNotEmpty) ...[
          _SectionLabel(context.tr('section_today')),
          const SizedBox(height: 10),
          ...today.map((a) => _TodayCard(appointment: a)),
          const SizedBox(height: 22),
        ],
        if (upcoming.isNotEmpty) ...[
          _SectionLabel(context.tr('section_upcoming')),
          const SizedBox(height: 10),
          ...upcoming.map(
            (a) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _UpcomingCard(appointment: a, onCancel: onCancel),
            ),
          ),
          const SizedBox(height: 10),
        ],
        if (past.isNotEmpty) ...[
          _SectionLabel(context.tr('section_history')),
          const SizedBox(height: 10),
          ...past.map(
            (a) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: InkWell(
                // Add this wrapper
                borderRadius: BorderRadius.circular(18),
                onTap: () => context.push(
                  AppRoutes.sessionDetailsScreen, // Make sure this route exists
                  extra: a.id,
                ),
                child: _PastCard(appointment: a),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _UpcomingTab extends StatelessWidget {
  const _UpcomingTab({required this.state, required this.onCancel});

  final AppointmentsState state;
  final ValueChanged<String> onCancel;

  @override
  Widget build(BuildContext context) {
    final today = state.todayAppointments;
    final upcoming = state.upcomingAppointments;

    if (today.isEmpty && upcoming.isEmpty) {
      return _EmptyState(message: context.tr('no_upcoming_appointments'));
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      children: [
        if (today.isNotEmpty) ...[
          _SectionLabel(context.tr('section_today')),
          const SizedBox(height: 10),
          ...today.map((a) => _TodayCard(appointment: a)),
          const SizedBox(height: 22),
        ],
        if (upcoming.isNotEmpty) ...[
          _SectionLabel(context.tr('section_upcoming')),
          const SizedBox(height: 10),
          ...upcoming.map(
            (a) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _UpcomingCard(appointment: a, onCancel: onCancel),
            ),
          ),
        ],
      ],
    );
  }
}

class _PastTab extends StatelessWidget {
  const _PastTab({required this.state});

  final AppointmentsState state;

  @override
  Widget build(BuildContext context) {
    final past = state.pastAppointments;

    if (past.isEmpty) {
      return _EmptyState(message: context.tr('no_history_appointments'));
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      children: [
        _SectionLabel(context.tr('section_history')),
        const SizedBox(height: 10),
        ...past.map(
          (a) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: GestureDetector(
               onTap: () => context.push(
                  AppRoutes.sessionDetailsScreen, // Make sure this route exists
                  extra: a.id,
                ),
              child: _PastCard(appointment: a)),
          ),
        ),
      ],
    );
  }
}

class _TodayCard extends StatelessWidget {
  const _TodayCard({required this.appointment});

  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: AppColors.white.withOpacity(0.25),
                  backgroundImage: appointment.doctorImageUrl != null
                      ? NetworkImage(appointment.doctorImageUrl!)
                      : null,
                  child: appointment.doctorImageUrl == null
                      ? const Icon(Icons.person, color: AppColors.white)
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appointment.doctorName,
                        style: AppTextStyle.tajawalBold16.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                      Text(
                        appointment.doctorSpecialty,
                        style: AppTextStyle.tajawalRegular12.copyWith(
                          color: AppColors.white.withOpacity(0.85),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  appointment.time,
                  style: AppTextStyle.tajawalBold14.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.white.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.calendar_today_outlined,
                    color: AppColors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomButtonWidget(
                    text: 'track_live_queue',
                    isFiled: true,
                    backgroundColor: AppColors.white,
                    color: AppColors.primary,
                    height: 44,
                    width: double.infinity,
                    radius: 12,
                    onTap: () => context.push(
                      AppRoutes.appointmentTrackingScreen,
                      extra: appointment.id,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _UpcomingCard extends StatelessWidget {
  const _UpcomingCard({required this.appointment, required this.onCancel});

  final Appointment appointment;
  final ValueChanged<String> onCancel;

  @override
  Widget build(BuildContext context) {
    final locale = context.locale.languageCode;
    final formattedDate = DateFormat(
      'EEEE، d MMMM',
      locale,
    ).format(appointment.date);
    final isWaiting = appointment.status == AppointmentStatus.waiting;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.divider),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: AppColors.dashNeutralBg,
                backgroundImage: appointment.doctorImageUrl != null
                    ? NetworkImage(appointment.doctorImageUrl!)
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
                        color: AppColors.authTitle,
                      ),
                    ),
                    Text(
                      appointment.doctorSpecialty,
                      style: AppTextStyle.tajawalRegular12.copyWith(
                        color: AppColors.authSubtitle,
                      ),
                    ),
                  ],
                ),
              ),
              _StatusBadge(status: appointment.status),
            ],
          ),
          const SizedBox(height: 10),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 60),
              child: Text(
                '$formattedDate • ${appointment.time}',
                style: AppTextStyle.tajawalRegular12.copyWith(
                  color: AppColors.authSubtitle,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: AppColors.divider),
          const SizedBox(height: 12),
          if (isWaiting)
            CustomButtonWidget(
              text: 'cancel_request',
              isFiled: false,
              color: AppColors.errorRed,
              backgroundColor: AppColors.white,
              height: 42,
              width: double.infinity,
              radius: 12,
              onTap: () => _confirmCancel(context),
            )
          else
            Row(
              children: [
                Expanded(
                  child: CustomButtonWidget(
                    text: 'reschedule',
                    isFiled: false,
                    color: AppColors.authSubtitle,
                    backgroundColor: AppColors.white,
                    height: 42,
                    width: double.infinity,
                    radius: 12,
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomButtonWidget(
                    text: 'details',
                    isFiled: true,
                    backgroundColor: AppColors.primary,
                    color: AppColors.white,
                    height: 42,
                    width: double.infinity,
                    radius: 12,
                    onTap: () => context.push(
                      AppRoutes.sessionDetailsScreen,
                      extra: appointment.id,
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  void _confirmCancel(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(context.tr('cancel_appointment')),
        content: Text(context.tr('cancel_confirm_message')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(context.tr('no')),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onCancel(appointment.id);
            },
            child: Text(
              context.tr('yes_cancel'),
              style: const TextStyle(color: AppColors.errorRed),
            ),
          ),
        ],
      ),
    );
  }
}

class _PastCard extends StatelessWidget {
  const _PastCard({required this.appointment});

  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    final locale = context.locale.languageCode;
    final formattedDate = DateFormat(
      'd MMMM yyyy',
      locale,
    ).format(appointment.date);
    final isCompleted = appointment.status == AppointmentStatus.completed;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.divider),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Opacity(
                opacity: isCompleted ? 1.0 : 0.5,
                child: CircleAvatar(
                  radius: 24,
                  backgroundColor: AppColors.dashNeutralBg,
                  backgroundImage: appointment.doctorImageUrl != null
                      ? NetworkImage(appointment.doctorImageUrl!)
                      : null,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appointment.doctorName,
                      style: AppTextStyle.tajawalBold14.copyWith(
                        color: isCompleted
                            ? AppColors.authTitle
                            : AppColors.authSubtitle,
                      ),
                    ),
                    Text(
                      appointment.doctorSpecialty,
                      style: AppTextStyle.tajawalRegular12.copyWith(
                        color: AppColors.authSubtitle,
                      ),
                    ),
                  ],
                ),
              ),
              _StatusBadge(status: appointment.status),
            ],
          ),
          const SizedBox(height: 10),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 60),
              child: Text(
                formattedDate,
                style: AppTextStyle.tajawalRegular12.copyWith(
                  color: AppColors.authSubtitle,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: AppColors.divider),
          const SizedBox(height: 12),
          if (isCompleted)
            Row(
              children: [
                Expanded(
                  child: CustomButtonWidget(
                    text: 'rebook',
                    isFiled: false,
                    color: AppColors.authSubtitle,
                    backgroundColor: AppColors.white,
                    height: 42,
                    width: double.infinity,
                    radius: 12,
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomButtonWidget(
                    text: 'prescription',
                    isFiled: true,
                    backgroundColor: AppColors.metricGreen,
                    color: AppColors.metricGreenIcon,
                    height: 42,
                    width: double.infinity,
                    radius: 12,
                    onTap: () => context.push(
                      AppRoutes.sessionDetailsScreen,
                      extra: appointment.id,
                    ),
                  ),
                ),
              ],
            )
          else
            CustomButtonWidget(
              text: 'book_new_appointment',
              isFiled: false,
              color: AppColors.primary,
              backgroundColor: AppColors.white,
              height: 42,
              width: double.infinity,
              radius: 12,
              onTap: () => context.go(AppRoutes.doctorsScreen),
            ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final AppointmentStatus status;

  @override
  Widget build(BuildContext context) {
    final (label, color, bg) = switch (status) {
      AppointmentStatus.confirmed => (
        context.tr('badge_confirmed'),
        const Color(0xFF1565C0),
        const Color(0xFFE3F2FD),
      ),
      AppointmentStatus.waiting => (
        context.tr('badge_waiting'),
        const Color(0xFFE65100),
        const Color(0xFFFFF3E0),
      ),
      AppointmentStatus.inClinic => (
        context.tr('badge_in_clinic'),
        const Color(0xFF2E7D32),
        const Color(0xFFE8F5E9),
      ),
      AppointmentStatus.completed => (
        context.tr('badge_completed'),
        const Color(0xFF2E7D32),
        const Color(0xFFE8F5E9),
      ),
      AppointmentStatus.cancelled => (
        context.tr('badge_cancelled'),
        const Color(0xFFE53935),
        const Color(0xFFFFEBEE),
      ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: AppTextStyle.tajawalSemiBold14.copyWith(color: color),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyle.tajawalBold14.copyWith(color: AppColors.authSubtitle),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: 420,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.calendar_today_outlined,
                  size: 56,
                  color: AppColors.divider,
                ),
                const SizedBox(height: 16),
                Text(
                  message,
                  style: AppTextStyle.tajawalBold16.copyWith(
                    color: AppColors.authSubtitle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
