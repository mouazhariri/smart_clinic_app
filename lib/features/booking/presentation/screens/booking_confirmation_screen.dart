import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../doctors/domain/entities/doctor.dart';
import '../controller/booking_controller.dart';
import '../controller/booking_state.dart';

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
  ConsumerState<BookingConfirmationScreen> createState() => _BookingConfirmationScreenState();
}

class _BookingConfirmationScreenState extends ConsumerState<BookingConfirmationScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(bookingControllerProvider.notifier).loadDoctorInfo(
            doctorName: widget.doctor.name,
            doctorSpecialty: widget.doctor.specialty,
            clinicName: widget.doctor.clinicAddress,
            price: widget.price,
          );
      ref.read(bookingControllerProvider.notifier).selectDate(widget.selectedDate);
      ref.read(bookingControllerProvider.notifier).selectTime(widget.selectedTime);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bookingControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('تأكيد الحجز'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // Booking Summary Card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.doctor.name,
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('تعديل'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.calendar_today, size: 16, color: Colors.blue),
                              const SizedBox(width: 4),
                              Text('${_formatDate(widget.selectedDate)}'),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.access_time, size: 16, color: Colors.blue),
                              const SizedBox(width: 4),
                              Text(widget.selectedTime),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text('عيادة ${widget.doctor.clinicAddress}'),
                          Text('تخصص ${widget.doctor.specialty}'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Patient Information Card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'معلومات المريض',
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  _showPatientInfoSheet(context);
                                },
                                child: const Text('تعديل'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          if (state.patientInformation?.birthDate != null)
                            Text('تاريخ الميلاد: ${_formatShortDate(state.patientInformation!.birthDate!)}'),
                          if (state.patientInformation?.city != null)
                            Text('المدينة: ${state.patientInformation!.city}'),
                          if (state.patientInformation?.gender != null)
                            Text('الجنس: ${state.patientInformation!.gender}'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Payment Card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text('طريقة الدفع', style: Theme.of(context).textTheme.titleSmall),
                              ),
                              TextButton(
                                onPressed: () {
                                  _showPaymentMethodSheet(context);
                                },
                                child: const Text('تعديل'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          if (state.selectedPaymentMethod != null)
                            Row(
                              children: [
                                Text(state.selectedPaymentMethod!.name),
                                const SizedBox(width: 8),
                                Text(state.selectedPaymentMethod!.description, style: Theme.of(context).textTheme.bodySmall),
                              ],
                            )
                          else
                            const Text('الدفع نقداً في العيادة'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Price Card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          _priceRow('سعر الكشفية', widget.price.toString()),
                          const Divider(),
                          _priceRow('رسوم الحجز', '0'),
                          const Divider(),
                          _priceRow('الإجمالي', '${widget.price}', isBold: true),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Policy Card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('سياسة الإلغاء وإعادة الجدولة'),
                          SizedBox(height: 4),
                          Text('يرجى الحضور قبل الموعد بـ 15 دقيقة. في حال الإلغاء يرجى إبلاغنا قبل 24 ساعة.', style: TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Confirm Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        final success = await ref.read(bookingControllerProvider.notifier).createBooking(widget.doctor.id);
                        if (success && mounted) {
                          Navigator.pushNamed(context, '/doctors/${widget.doctor.id}/success');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('حفظ ومتابعة الحجز'),
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _priceRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: isBold ? const TextStyle(fontWeight: FontWeight.bold) : null),
        Text(value, style: isBold ? const TextStyle(fontWeight: FontWeight.bold) : null),
      ],
    );
  }

  String _formatDate(DateTime date) => '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

  String _formatShortDate(DateTime date) => '${date.day}/${date.month}/${date.year}';

  void _showPatientInfoSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const PatientInformationSheet(),
    );
  }

  void _showPaymentMethodSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const PaymentMethodSheet(),
    );
  }
}
