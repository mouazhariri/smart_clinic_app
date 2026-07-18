import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_clinic_app/features/booking/presentation/widgets/patient_information_sheet.dart';
import 'package:smart_clinic_app/features/booking/presentation/widgets/payment_method_sheet.dart';
import 'package:smart_clinic_app/src/resourses/color_manager/app_colors.dart';
import 'package:smart_clinic_app/src/resourses/font_manager/app_text_style.dart';

import '../../../../src/application/router/app_routes.dart';
import '../../../doctors/domain/entities/doctor.dart';
import '../controller/booking_controller.dart';
import '../controller/booking_state.dart';

// ── Shared constants ───────────────────────────────────────────────────────
const _kBg = Color(0xFFF5F6FA);
const _kCardBorder = Color(0xFFEEEEEE);
const _kSubtle = Color(0xFF9E9E9E);
const _kDivider = Color(0xFFEEEEEE);

class BookingConfirmationScreen extends ConsumerStatefulWidget {
  final Doctor doctor;
  final DateTime selectedDate;
  final String selectedTime;
  final double price;

  const BookingConfirmationScreen({
    super.key,
    required this.doctor,
    required this.selectedDate,
    required this.selectedTime,
    required this.price,
  });

  @override
  ConsumerState<BookingConfirmationScreen> createState() =>
      _BookingConfirmationScreenState();
}

class _BookingConfirmationScreenState
    extends ConsumerState<BookingConfirmationScreen> {
  late final TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _notesController = TextEditingController(
      text: ref.read(bookingControllerProvider).notes,
    );
    Future.microtask(() {
      if (!mounted) return;
      final n = ref.read(bookingControllerProvider.notifier);
      n.loadDoctorInfo(
        doctorName: widget.doctor.name,
        doctorSpecialty: widget.doctor.specialty,
        clinicName: widget.doctor.clinicAddress,
        price: widget.price,
      );
      n.selectDate(widget.selectedDate);
      n.selectTime(widget.selectedTime);
    });
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bookingControllerProvider);

    return Scaffold(
      backgroundColor: _kBg,
      appBar: _buildAppBar(context),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ① Doctor + date/time card
                  _DoctorDateCard(
                    doctor: widget.doctor,
                    selectedDate: widget.selectedDate,
                    selectedTime: widget.selectedTime,
                    onEdit: () => context.pop(),
                  ),
                  const SizedBox(height: 12),

                  // ② Patient + clinic card
                  _PatientClinicCard(
                    doctor: widget.doctor,
                    state: state,
                    onEditPatient: () => _showPatientSheet(context),
                  ),
                  const SizedBox(height: 12),

                  // ③ Payment card
                  _PaymentCard(
                    state: state,
                    onEdit: () => _showPaymentSheet(context),
                  ),
                  const SizedBox(height: 12),

                  // ④ Price breakdown
                  _PriceCard(price: widget.price),
                  const SizedBox(height: 12),

                  // ⑤ Policy
                  const _PolicyCard(),
                  const SizedBox(height: 12),


                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _ConfirmButton(onConfirm: _confirmBooking),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: _kBg,
      elevation: 0,
      scrolledUnderElevation: 0,
      // LTR: back arrow on the LEFT
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: AppColors.authTitle,
          size: 18,
        ),
        onPressed: () => context.pop(),
      ),
      title: Text(
        context.tr('confirm_booking'),
        style:
            AppTextStyle.tajawalBold18.copyWith(color: AppColors.authTitle),
      ),
      centerTitle: true,
    );
  }

  Future<void> _confirmBooking() async {
    context.pushReplacement(
      AppRoutes.bookAppointmentSuccessScreen,
      extra: {
        'doctor': widget.doctor,
        'selectedDate': widget.selectedDate,
        'selectedTime': widget.selectedTime,
        'appointmentNumber': '#9874',
      },
    );
  }

  void _showPatientSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const PatientInformationSheet(),
    );
  }

  void _showPaymentSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const PaymentMethodSheet(),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
// ① DOCTOR + DATE/TIME CARD
// ════════════════════════════════════════════════════════════════════════════
class _DoctorDateCard extends StatelessWidget {
  final Doctor doctor;
  final DateTime selectedDate;
  final String selectedTime;
  final VoidCallback onEdit;

  const _DoctorDateCard({
    required this.doctor,
    required this.selectedDate,
    required this.selectedTime,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final locale = context.locale.languageCode;
    final formattedDate =
        DateFormat('EEEE, d MMMM', locale).format(selectedDate);
    final dateTime = '$formattedDate • $selectedTime';

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Doctor row: avatar LEFT, text RIGHT ───────────────────
          Row(
            children: [
              // Circular avatar on the LEFT
              CircleAvatar(
                radius: 28,
                backgroundImage: doctor.imageUrl != null
                    ? NetworkImage(doctor.imageUrl!)
                    : null,
                backgroundColor: AppColors.dashNeutralBg,
                child: doctor.imageUrl == null
                    ? const Icon(
                        Icons.person,
                        color: AppColors.authHint,
                        size: 26,
                      )
                    : null,
              ),
              const SizedBox(width: 12),

              // Name + specialty on the RIGHT
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor.name,
                      style: AppTextStyle.tajawalBold18
                          .copyWith(color: AppColors.authTitle),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      doctor.specialty,
                      style: AppTextStyle.tajawalRegular14
                          .copyWith(color: _kSubtle),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),
          const Divider(height: 1, color: _kDivider),
          const SizedBox(height: 14),

          // ── Date/time row: icon LEFT, text MIDDLE, edit RIGHT ─────
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Calendar icon on the LEFT
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.calendar_today_outlined,
                  color: AppColors.primary,
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),

              // Label + value in the MIDDLE
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.tr('date_and_time'),
                      style: AppTextStyle.tajawalRegular12
                          .copyWith(color: _kSubtle),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      dateTime,
                      style: AppTextStyle.tajawalBold14
                          .copyWith(color: AppColors.primary),
                    ),
                  ],
                ),
              ),

              // Edit button on the RIGHT
              _EditButton(onTap: onEdit),
            ],
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
// ② PATIENT + CLINIC CARD
// ════════════════════════════════════════════════════════════════════════════
class _PatientClinicCard extends StatelessWidget {
  final Doctor doctor;
  final BookingState state;
  final VoidCallback onEditPatient;

  const _PatientClinicCard({
    required this.doctor,
    required this.state,
    required this.onEditPatient,
  });

  @override
  Widget build(BuildContext context) {
    final info = state.patientInformation;

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Patient row: avatar LEFT, text MIDDLE ─────────────────
          Row(
            children: [
              // Patient avatar on the LEFT
              CircleAvatar(
                radius: 26,
                backgroundColor: AppColors.dashNeutralBg,
                child: const Icon(
                  Icons.person,
                  color: AppColors.authHint,
                  size: 26,
                ),
              ),
              const SizedBox(width: 12),

              // Patient info in the MIDDLE
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.tr('patient'),
                      style: AppTextStyle.tajawalRegular12
                          .copyWith(color: _kSubtle),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      info?.city ?? 'Ahmed Al-Mohammad',
                      style: AppTextStyle.tajawalBold16
                          .copyWith(color: AppColors.authTitle),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),
          const Divider(height: 1, color: _kDivider),
          const SizedBox(height: 14),

          // ── Clinic row: icon LEFT, text MIDDLE ────────────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Location icon on the LEFT
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.location_on_outlined,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),

              // Clinic info on the RIGHT
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.tr('clinic'),
                      style: AppTextStyle.tajawalRegular12
                          .copyWith(color: _kSubtle),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      doctor.clinicAddress,
                      style: AppTextStyle.tajawalBold14
                          .copyWith(color: AppColors.authTitle),
                    ),
                    if ((doctor.location ?? '').isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        doctor.location!,
                        style: AppTextStyle.tajawalRegular12
                            .copyWith(color: _kSubtle),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
// ③ PAYMENT CARD
// ════════════════════════════════════════════════════════════════════════════
class _PaymentCard extends StatelessWidget {
  final BookingState state;
  final VoidCallback onEdit;

  const _PaymentCard({required this.state, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    final method = state.selectedPaymentMethod;

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header: title LEFT, edit RIGHT ────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.tr('payment_method'),
                style: AppTextStyle.tajawalBold16
                    .copyWith(color: AppColors.authTitle),
              ),
              _EditButton(
                onTap: onEdit,
                label: context.tr('change_method'),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Divider(height: 1, color: _kDivider),
          const SizedBox(height: 14),

          // ── Method row: icon LEFT, text RIGHT ─────────────────────
          Row(
            children: [
              // Payment icon on the LEFT
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.dashNeutralBg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.payment_outlined,
                  color: AppColors.authSubtitle,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),

              // Method name + description on the RIGHT
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      method?.name ?? context.tr('cash_in_clinic'),
                      style: AppTextStyle.tajawalBold14
                          .copyWith(color: AppColors.authTitle),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      (method?.description.isNotEmpty ?? false)
                          ? method!.description
                          : context.tr('cash_in_clinic_sub'),
                      style: AppTextStyle.tajawalRegular12
                          .copyWith(color: _kSubtle),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
// ④ PRICE CARD
// ════════════════════════════════════════════════════════════════════════════
class _PriceCard extends StatelessWidget {
  final double price;
  const _PriceCard({required this.price});

  @override
  Widget build(BuildContext context) {
    final sym = context.tr('syrian_pound_short');

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title LEFT
          Text(
            context.tr('payment_details'),
            style: AppTextStyle.tajawalBold16
                .copyWith(color: AppColors.authTitle),
          ),
          const SizedBox(height: 16),

          // Consultation fee: label LEFT, value RIGHT
          _PriceRow(
            label: context.tr('consultation_fee_label'),
            value: '${price.toStringAsFixed(0)} $sym',
          ),
          const SizedBox(height: 12),

          // Booking fee: label LEFT, value RIGHT
          _PriceRow(
            label: context.tr('booking_fee'),
            value: context.tr('free'),
            valueColor: AppColors.green,
          ),
          const SizedBox(height: 12),

          const _DashedDivider(),
          const SizedBox(height: 12),

          // Total: label LEFT, value RIGHT in blue + bold
          _PriceRow(
            label: context.tr('total'),
            value: '${price.toStringAsFixed(0)} $sym',
            labelStyle: AppTextStyle.tajawalRegular14
                .copyWith(color: AppColors.authTitle),
            valueStyle: AppTextStyle.tajawalBold16
                .copyWith(color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;

  const _PriceRow({
    required this.label,
    required this.value,
    this.valueColor,
    this.labelStyle,
    this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Label on the LEFT
        Text(
          label,
          style: labelStyle ??
              AppTextStyle.tajawalRegular14.copyWith(color: _kSubtle),
        ),
        // Value on the RIGHT
        Text(
          value,
          style: valueStyle ??
              AppTextStyle.tajawalRegular14.copyWith(
                color: valueColor ?? AppColors.authTitle,
              ),
        ),
      ],
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
// DASHED DIVIDER
// ════════════════════════════════════════════════════════════════════════════
class _DashedDivider extends StatelessWidget {
  const _DashedDivider();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      const dashW = 6.0;
      const gapW = 4.0;
      final count = (constraints.maxWidth / (dashW + gapW)).floor();
      return Row(
        children: List.generate(
          count,
          (_) => Padding(
            padding: const EdgeInsets.only(right: gapW),
            child: Container(
              width: dashW,
              height: 1,
              color: _kDivider,
            ),
          ),
        ),
      );
    });
  }
}

// ════════════════════════════════════════════════════════════════════════════
// ⑤ POLICY CARD
// ════════════════════════════════════════════════════════════════════════════
class _PolicyCard extends StatelessWidget {
  const _PolicyCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF4FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Info icon on the LEFT
          const Icon(
            Icons.info_outline_rounded,
            color: AppColors.primary,
            size: 18,
          ),
          const SizedBox(width: 10),
          // Policy text on the RIGHT
          Expanded(
            child: Text(
              context.tr('policy_body'),
              style: AppTextStyle.tajawalRegular14.copyWith(
                color: AppColors.primary,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// ════════════════════════════════════════════════════════════════════════════
// BOTTOM CONFIRM BUTTON
// ════════════════════════════════════════════════════════════════════════════
class _ConfirmButton extends StatelessWidget {
  final VoidCallback onConfirm;
  const _ConfirmButton({required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(
        16,
        12,
        16,
        MediaQuery.of(context).padding.bottom + 12,
      ),
      child: SizedBox(
        width: double.infinity,
        height: 54,
        child: ElevatedButton(
          onPressed: onConfirm,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: Text(
            context.tr('confirm_booking_btn'),
            style:
                AppTextStyle.tajawalBold18.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
// SHARED CARD CONTAINER
// ════════════════════════════════════════════════════════════════════════════
class _Card extends StatelessWidget {
  final Widget child;
  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kCardBorder),
      ),
      child: child,
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
// EDIT BUTTON
// ════════════════════════════════════════════════════════════════════════════
class _EditButton extends StatelessWidget {
  final VoidCallback onTap;
  final String? label;
  const _EditButton({required this.onTap, this.label});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        label ?? context.tr('edit'),
        style: AppTextStyle.tajawalSemiBold14
            .copyWith(color: AppColors.primary),
      ),
    );
  }
}