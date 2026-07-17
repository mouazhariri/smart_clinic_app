import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../doctors/domain/entities/doctor.dart';
import '../controller/booking_controller.dart';
import '../controller/booking_state.dart';

class BookingScreen extends ConsumerStatefulWidget {
  final Doctor doctor;
  const BookingScreen({super.key, required this.doctor});

  @override
  ConsumerState<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends ConsumerState<BookingScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(bookingControllerProvider.notifier).loadDoctorInfo(
            doctorName: widget.doctor.name,
            doctorSpecialty: widget.doctor.specialty,
            clinicName: widget.doctor.clinicAddress,
            price: widget.doctor.consultationFee,
          );
      ref.read(bookingControllerProvider.notifier).loadSchedule(
            widget.doctor.availableDates,
            widget.doctor.availableTimes,
          );
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
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Doctor info banner
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(widget.doctor.imageUrl ?? ''),
                              radius: 28,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.doctor.name,
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                  Text(
                                    widget.doctor.specialty,
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                  Text(
                                    widget.doctor.clinicAddress,
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Date selector
                    Text('اختر التاريخ', style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 80,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.availableDates.length,
                        itemBuilder: (context, index) {
                          final date = state.availableDates[index];
                          final isDisabled = !_isDateAvailable(date, widget.doctor);
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: GestureDetector(
                              onTap: isDisabled
                                  ? null
                                  : () {
                                      ref.read(bookingControllerProvider.notifier).selectDate(date);
                                    },
                              child: Container(
                                width: 60,
                                decoration: BoxDecoration(
                                  color: isDisabled ? Colors.grey.shade300 : (state.selectedDate == date ? Colors.blue : Colors.white),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: isDisabled ? Colors.grey : Colors.blue),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${date.day}',
                                      style: TextStyle(
                                        color: isDisabled ? Colors.grey : (state.selectedDate == date ? Colors.white : Colors.black),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      _dayName(date),
                                      style: TextStyle(
                                        color: isDisabled ? Colors.grey : (state.selectedDate == date ? Colors.white : Colors.black),
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Time selector
                    Text('اختر الوقت', style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: state.availableSlots.map((slot) {
                        final isSelected = state.selectedTime == slot.time;
                        return ChoiceChip(
                          label: Text(slot.time),
                          selected: isSelected,
                          onSelected: slot.isAvailable
                              ? (val) {
                                  if (val) {
                                    ref.read(bookingControllerProvider.notifier).selectTime(slot.time);
                                  }
                                }
                              : null,
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                    // Notes
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'ملاحظات للطبيب (اختياري)',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                      onChanged: (val) => ref.read(bookingControllerProvider.notifier).updateNotes(val),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('السعر: ${widget.doctor.consultationFee} ريال'),
                    if (state.selectedTime != null) Text('الوقت: ${state.selectedTime}'),
                    if (state.selectedDate != null) Text('التاريخ: ${_formatDate(state.selectedDate!)}'),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: (state.selectedDate != null && state.selectedTime != null)
                    ? () {
                        Navigator.pushNamed(
                          context,
                          '/doctors/${widget.doctor.id}/confirm',
                          arguments: {
                            'doctor': widget.doctor,
                            'selectedDate': state.selectedDate,
                            'selectedTime': state.selectedTime,
                            'price': widget.doctor.consultationFee,
                          },
                        );
                      }
                    : null,
                child: const Text('متابعة الحجز'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isDateAvailable(DateTime date, Doctor doctor) {
    final workingHours = doctor.workingHours;
    if (workingHours == null || workingHours.isEmpty) return true;
    final weekday = _mapWeekday(date.weekday);
    return workingHours.any((wh) => wh.day.contains(weekday) && wh.time.isNotEmpty);
  }

  String _mapWeekday(int weekday) {
    switch (weekday) {
      case 1: return 'Monday';
      case 2: return 'Tuesday';
      case 3: return 'Wednesday';
      case 4: return 'Thursday';
      case 5: return 'Friday';
      case 6: return 'Saturday';
      case 7: return 'Sunday';
      default: return '';
    }
  }

  String _dayName(DateTime date) {
    const days = {
      1: 'Mon', 2: 'Tue', 3: 'Wed', 4: 'Thu', 5: 'Fri', 6: 'Sat', 7: 'Sun'
    };
    return days[date.weekday] ?? '';
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
