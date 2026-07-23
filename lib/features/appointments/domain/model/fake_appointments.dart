// lib/features/appointments/data/fake_appointments.dart

import 'appointment.dart';

class FakeAppointments {
  FakeAppointments._();

  static final now = DateTime.now();

  static final List<Appointment> all = [
    // ── TODAY — in clinic (blue card) ────────────────────────────
    Appointment(
      id: 'apt-today-1',
      doctorId: 'd1',
      doctorName: 'Dr. Rami Dimashqi',
      doctorSpecialty: 'Cardiovascular Surgery',
      doctorImageUrl:
          'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d',
      date: DateTime(now.year, now.month, now.day, 16, 30),
      time: 'Today, 04:30 PM',
      status: AppointmentStatus.inClinic,
      queueNumber: 15,
      currentTurn: 12,
      estimatedWaitMinutes: 30,
      patientsAhead: 3,
      clinicAddress: 'Al-Mazza Specialized Clinic',
    ),

    // ── UPCOMING — confirmed ──────────────────────────────────────
    Appointment(
      id: 'apt-upcoming-1',
      doctorId: 'd1',
      doctorName: 'Dr. Rami Dimashqi',
      doctorSpecialty: 'Cardiovascular Surgery',
      doctorImageUrl:
          'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d',
      date: DateTime(now.year, now.month, 15, 10, 0),
      time: '10:00 AM',
      status: AppointmentStatus.confirmed,
      clinicAddress: 'Al-Mazza Specialized Clinic',
    ),

    // ── UPCOMING — waiting ────────────────────────────────────────
    Appointment(
      id: 'apt-upcoming-2',
      doctorId: 'd3',
      doctorName: 'Dr. Sara Al-Halabi',
      doctorSpecialty: 'Cardiovascular Surgery',
      doctorImageUrl:
          'https://images.unsplash.com/photo-1594824476967-48c8b964273f',
      date: DateTime(now.year, now.month, 18, 13, 0),
      time: '01:00 PM',
      status: AppointmentStatus.waiting,
      clinicAddress: 'City Hospital',
    ),

    // ── PAST — completed (has prescription) ──────────────────────
    Appointment(
      id: 'apt-past-1',
      doctorId: 'd2',
      doctorName: 'Dr. Khaled Al-Masri',
      doctorSpecialty: 'Cardiovascular Surgery',
      doctorImageUrl:
          'https://images.unsplash.com/photo-1559839734-2b71ea197ec2',
      date: DateTime(2026, 5, 10, 11, 0),
      time: '11:00 AM',
      status: AppointmentStatus.completed,
      clinicAddress: 'Smile Dental Clinic',
      sessionDetails: const SessionDetails(
        diagnosis:
            'Patient has mild high blood pressure (140/90) with rapid '
            'heartbeat due to anxiety. Recommendations: reduce caffeine, '
            'drink enough water, avoid stress, take medications.',
        medications: [
          Medication(
            name: 'Concor 5mg',
            dosage: 'Once daily',
            frequency: 'After breakfast',
            note: '30 days (1 unit)',
          ),
          Medication(
            name: 'Panadol Advance',
            dosage: 'As needed',
            frequency: 'For headache only',
          ),
        ],
        requiredTests: [
          RequiredTest(
            name: 'Complete Blood Count (CBC)',
            description: 'Fasting blood draw',
          ),
        ],
        requestedFollowUp: true,
      ),
    ),

    // ── PAST — cancelled ─────────────────────────────────────────
    Appointment(
      id: 'apt-past-2',
      doctorId: 'd4',
      doctorName: 'Dr. Nour Al-Shami',
      doctorSpecialty: 'Cardiovascular Surgery',
      doctorImageUrl:
          'https://images.unsplash.com/photo-1651008376811-b90baee60c1f',
      date: DateTime(now.year, now.month, 18, 13, 0),
      time: '01:00 PM',
      status: AppointmentStatus.cancelled,
    ),
  ];

  static Appointment? get nearest {
    final upcoming = all
        .where((a) => a.isUpcoming)
        .toList()
      ..sort((a, b) => a.date.compareTo(b.date));
    return upcoming.isEmpty ? null : upcoming.first;
  }
}