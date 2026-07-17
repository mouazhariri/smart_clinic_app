import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/booking_controller.dart';
import '../controller/booking_state.dart';
import '../../domain/model/patient_information.dart';

class PatientInformationSheet extends ConsumerStatefulWidget {
  const PatientInformationSheet({super.key});

  @override
  ConsumerState<PatientInformationSheet> createState() => _PatientInformationSheetState();
}

class _PatientInformationSheetState extends ConsumerState<PatientInformationSheet> {
  DateTime? birthDate;
  String? gender;
  String? city;

  @override
  void initState() {
    super.initState();
    final info = ref.read(bookingControllerProvider).patientInformation;
    if (info != null) {
      birthDate = info.birthDate;
      gender = info.gender;
      city = info.city;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          const Text('معلومات المريض', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'تاريخ الميلاد',
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.calendar_today),
            ),
            readOnly: true,
            controller: TextEditingController(text: birthDate != null ? '${birthDate!.day}/${birthDate!.month}/${birthDate!.year}' : ''),
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: birthDate ?? DateTime(1990, 1, 1),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (picked != null) {
                setState(() => birthDate = picked);
              }
            },
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: city,
            decoration: const InputDecoration(
              labelText: 'المدينة',
              border: OutlineInputBorder(),
            ),
            items: ['دمشق', 'حلب', 'حمص', 'اللاذقية', 'طرطوس']
                .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                .toList(),
            onChanged: (val) => setState(() => city = val),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: ['ذكر', 'أنثى']
                .map((g) => ChoiceChip(
                      label: Text(g),
                      selected: gender == g,
                      onSelected: (val) {
                        if (val) setState(() => gender = g);
                      },
                    ))
                .toList(),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (birthDate != null && city != null && gender != null) {
                  ref.read(bookingControllerProvider.notifier).updatePatientInfo(
                        PatientInformation(
                          birthDate: birthDate,
                          gender: gender,
                          city: city,
                        ),
                      );
                  Navigator.pop(context);
                }
              },
              child: const Text('حفظ'),
            ),
          ),
        ],
      ),
    );
  }
}
