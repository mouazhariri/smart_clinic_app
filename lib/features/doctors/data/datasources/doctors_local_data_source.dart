import '../models/doctor_model.dart';

abstract class DoctorsLocalDataSource {
  Future<List<DoctorModel>> getDoctors();
  Future<DoctorModel> getDoctorById(String id);
}

class DoctorsLocalDataSourceImpl implements DoctorsLocalDataSource {
  const DoctorsLocalDataSourceImpl();

  @override
  Future<List<DoctorModel>> getDoctors() async {
    final now = DateTime.now();
    final dates = List.generate(
      7,
      (index) => DateTime(now.year, now.month, now.day + index + 1),
    );

    return [
      DoctorModel(
        id: 'doctor-1',
        name: 'doctor_sarah_ahmed',
        specialty: 'specialty_cardiologist',
        about:
            'doctor_sarah_about',
        imageUrl: 'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?w=400',
        rating: 4.9,
        reviewsCount: 124,
        experienceYears: 12,
        patientsCount: 1800,
        availableDates: dates,
        availableTimes: const ['09:00 AM', '10:30 AM', '12:00 PM', '02:30 PM'],
        clinicAddress: 'address_al_sham_medical_center',
      ),
      DoctorModel(
        id: 'doctor-2',
        name: 'doctor_omar_khaled',
        specialty: 'specialty_dentist',
        about:
            'doctor_omar_about',
        imageUrl: 'https://images.unsplash.com/photo-1622253692010-333f2da6031d?w=400',
        rating: 4.8,
        reviewsCount: 96,
        experienceYears: 9,
        patientsCount: 1260,
        availableDates: dates,
        availableTimes: const ['08:30 AM', '11:00 AM', '01:00 PM', '04:00 PM'],
        clinicAddress: 'address_smile_clinic',
      ),
      DoctorModel(
        id: 'doctor-3',
        name: 'doctor_lina_mansour',
        specialty: 'specialty_pediatrician',
        about:
            'doctor_lina_about',
        imageUrl: 'https://images.unsplash.com/photo-1594824476967-48c8b964273f?w=400',
        rating: 4.7,
        reviewsCount: 88,
        experienceYears: 10,
        patientsCount: 1420,
        availableDates: dates,
        availableTimes: const ['09:30 AM', '11:30 AM', '03:00 PM', '05:00 PM'],
        clinicAddress: 'address_family_care_clinic',
      ),
    ];
  }

  @override
  Future<DoctorModel> getDoctorById(String id) async {
    final doctors = await getDoctors();
    return doctors.firstWhere((doctor) => doctor.id == id);
  }
}
