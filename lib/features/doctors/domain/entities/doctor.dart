// import 'package:equatable/equatable.dart';
// class WorkingHour {
//   final String day;   // ✅ Now String (e.g., "الأحد")
//   final String time;  // ✅ Now String (e.g., "09:00 - 04:00")

//   WorkingHour({required this.day, required this.time});
// }
// class Doctor extends Equatable {
//   const Doctor({
//     required this.id,
//     required this.name,
//     required this.specialty,
//     required this.about,
//     required this.imageUrl,
//     required this.rating,
//     required this.reviewsCount,
//     required this.experienceYears,
//     required this.patientsCount,
//     required this.availableDates,
//     required this.availableTimes,
//     required this.clinicAddress,
//     this.consultationFee = 0,
//     this.location,
//     this.price,
//         this.workingHours,

//   });

//   final String id;
//   final String name;
//   final String specialty;
//   final String? imageUrl;
//   final String? about;
//   final String? location;
//   final int? experienceYears;
//   final double? rating;
//   final int? price;

//   final int reviewsCount;
//   final int patientsCount;
//   final List<DateTime> availableDates;
//   final List<String> availableTimes;
//   final String clinicAddress;
//   final double consultationFee;
//   final List<WorkingHour>? workingHours; // ✅ Fixed: Now properly typed

//   @override
//   List<Object?> get props => [
//     id,
//     name,
//     specialty,
//     about,
//     imageUrl,
//     rating,
//     reviewsCount,
//     experienceYears,
//     patientsCount,
//     availableDates,
//     availableTimes,
//     clinicAddress,
//     consultationFee,
//     location,
//     price,
//   ];
// }

// class FakeDoctors {
//   FakeDoctors._();

//   static final List<Doctor> doctors = [
//     Doctor(
//       id: '1',
//       name: 'Dr. Sarah Johnson',
//       specialty: 'cardiology',
//       about:
//           'Experienced cardiologist specializing in heart disease prevention and treatment.',
//       imageUrl: 'https://images.unsplash.com/photo-1559839734-2b71ea197ec2',
//       rating: 4.9,
//       reviewsCount: 312,
//       experienceYears: 12,
//       patientsCount: 2400,
//       price: 500,
//       location: 'Downtown Medical Center',
//       clinicAddress: 'Downtown Medical Center',
//       consultationFee: 120,
//       availableDates: _dates,
//       availableTimes: _times,
//     ),
//     Doctor(
//       id: '2',
//       name: 'Dr. Michael Brown',
//       specialty: 'dentist',
//       about: 'Expert dentist providing cosmetic and restorative dental care.',
//       imageUrl: 'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d',
//       rating: 4.8,
//       reviewsCount: 189,
//       experienceYears: 9,
//       patientsCount: 1700,
//       price: 800,
//       location: 'Alshaalan - hamraa street',
//       clinicAddress: 'Smile Dental Clinic',
//       consultationFee: 90,
//       availableDates: _dates,
//       availableTimes: _times,
//     ),
//     Doctor(
//       id: '3',
//       name: 'Dr. Emily Wilson',
//       specialty: 'neurology',
//       about: 'Neurologist focused on brain and nervous system disorders.',
//       imageUrl: 'https://images.unsplash.com/photo-1594824476967-48c8b964273f',
//       rating: 4.7,
//       reviewsCount: 275,
//       experienceYears: 15,
//       patientsCount: 3200,
//             price: 1000,
//       location: 'Al malki',
//       clinicAddress: 'City Hospital',
//       consultationFee: 150,
//       availableDates: _dates,
//       availableTimes: _times,
//     ),
//     Doctor(
//       id: '4',
//       name: 'Dr. Olivia Martinez',
//       specialty: 'dermatology',
//       about:
//           'Treating skin, hair and nail diseases using the latest technology.',
//       imageUrl: 'https://images.unsplash.com/photo-1595152772835-219674b2a8a6',
//       rating: 4.9,
//       reviewsCount: 410,
//       experienceYears: 11,
//       patientsCount: 2900,
//             price: 400,
//       location: 'Rukin Al Din',
//       clinicAddress: 'Skin Care Clinic',
//       consultationFee: 110,
//       availableDates: _dates,
//       availableTimes: _times,
//     ),
//     Doctor(
//       id: '5',
//       name: 'Dr. David Miller',
//       specialty: 'orthopedic',
//       about:
//           'Orthopedic surgeon specializing in sports injuries and joint replacement.',
//       imageUrl: 'https://images.unsplash.com/photo-1622253692010-333f2da6031d',
//       rating: 4.8,
//       reviewsCount: 356,
//       experienceYears: 18,
//       patientsCount: 4100,
//             price: 600,
//       location: 'Dumar',
//       clinicAddress: 'Orthopedic Center',
//       consultationFee: 140,
//       availableDates: _dates,
//       availableTimes: _times,
//     ),
//     Doctor(
//       id: '6',
//       name: 'Dr. Sophia Lee',
//       specialty: 'pediatrics',
//       about:
//           'Providing compassionate healthcare for infants, children and adolescents.',
//       imageUrl: 'https://images.unsplash.com/photo-1651008376811-b90baee60c1',
//       rating: 5.0,
//       reviewsCount: 520,
//       experienceYears: 13,
//       patientsCount: 5000,
//             price: 500,
//       location: 'Qasun',
//       clinicAddress: 'Children Medical Center',
//       consultationFee: 100,
//       availableDates: _dates,
//       availableTimes: _times,
//     ),
//   ];

//   static final List<DateTime> _dates = List.generate(
//     7,
//     (i) => DateTime.now().add(Duration(days: i)),
//   );

//   static const List<String> _times = [
//     '09:00 AM',
//     '10:00 AM',
//     '11:00 AM',
//     '12:00 PM',
//     '02:00 PM',
//     '03:00 PM',
//     '04:00 PM',
//   ];
// }

import 'package:equatable/equatable.dart';

class WorkingHour {
  final String day;
  final String time; // empty string '' => closed

  const WorkingHour({required this.day, required this.time});
}

class Doctor extends Equatable {
  const Doctor({
    required this.id,
    required this.name,
    required this.gender,
    required this.specialty,
    required this.about,
    required this.imageUrl,
    required this.rating,
    required this.reviewsCount,
    required this.experienceYears,
    required this.patientsCount,
    required this.availableDates,
    required this.availableTimes,
    required this.clinicAddress,
    this.consultationFee = 0,
    this.location,
    this.price,
    this.workingHours,
  });

  final String id;
  final String name;
  final String gender;
  final String specialty;
  final String? imageUrl;
  final String? about;
  final String? location;
  final int? experienceYears;
  final double? rating;
  final int? price;
  final int reviewsCount;
  final int patientsCount;
  final List<DateTime> availableDates;
  final List<String> availableTimes;
  final String clinicAddress;
  final double consultationFee;
  final List<WorkingHour>? workingHours;

  @override
  List<Object?> get props => [
    id,
    name,
    specialty,
    about,
    imageUrl,
    rating,
    reviewsCount,
    experienceYears,
    patientsCount,
    availableDates,
    availableTimes,
    clinicAddress,
    consultationFee,
    location,
    price,
    workingHours,
  ];
}

class FakeDoctors {
  FakeDoctors._();

  static final List<Doctor> doctors = [
    Doctor(
      id: '1',
      name: 'Dr. Sarah Johnson',
      gender: 'female',
      specialty: 'cardiology',
      about:
          'Experienced cardiologist specializing in heart disease prevention and treatment.',
      imageUrl: 'https://images.unsplash.com/photo-1559839734-2b71ea197ec2',
      rating: 4.9,
      reviewsCount: 312,
      experienceYears: 12,
      patientsCount: 2400,
      price: 500,
      location: 'Downtown Medical Center',
      clinicAddress: 'Downtown Medical Center',
      consultationFee: 120,
      availableDates: _dates,
      availableTimes: _times,
      workingHours: _workingHours,
    ),
    Doctor(
      id: '2',
      name: 'Dr. Michael Brown',
      gender: "male",
      specialty: 'dentist',
      about: 'Expert dentist providing cosmetic and restorative dental care.',
      imageUrl: 'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d',
      rating: 4.8,
      reviewsCount: 189,
      experienceYears: 9,
      patientsCount: 1700,
      price: 800,
      location: 'Alshaalan - hamraa street',
      clinicAddress: 'Smile Dental Clinic',
      consultationFee: 90,
      availableDates: _dates,
      availableTimes: _times,
      workingHours: _workingHours,
    ),
    Doctor(
      id: '3',
      name: 'Dr. Emily Wilson',
      gender: 'female',

      specialty: 'neurology',
      about: 'Neurologist focused on brain and nervous system disorders.',
      imageUrl: 'https://images.unsplash.com/photo-1594824476967-48c8b964273f',
      rating: 4.7,
      reviewsCount: 275,
      experienceYears: 15,
      patientsCount: 3200,
      price: 1000,
      location: 'Al malki',
      clinicAddress: 'City Hospital',
      consultationFee: 150,
      availableDates: _dates,
      availableTimes: _times,
      workingHours: _workingHours,
    ),
    Doctor(
      id: '4',
      name: 'Dr. Olivia Martinez',
      gender: 'female',

      specialty: 'dermatology',
      about:
          'Treating skin, hair and nail diseases using the latest technology.',
      imageUrl: 'https://images.unsplash.com/photo-1595152772835-219674b2a8a6',
      rating: 4.9,
      reviewsCount: 410,
      experienceYears: 11,
      patientsCount: 2900,
      price: 400,
      location: 'Rukin Al Din',
      clinicAddress: 'Skin Care Clinic',
      consultationFee: 110,
      availableDates: _dates,
      availableTimes: _times,
      workingHours: _workingHours,
    ),
    Doctor(
      id: '5',
      name: 'Dr. David Miller',
      gender: "male",

      specialty: 'orthopedic',
      about:
          'Orthopedic surgeon specializing in sports injuries and joint replacement.',
      imageUrl: 'https://images.unsplash.com/photo-1622253692010-333f2da6031d',
      rating: 4.8,
      reviewsCount: 356,
      experienceYears: 18,
      patientsCount: 4100,
      price: 600,
      location: 'Dumar',
      clinicAddress: 'Orthopedic Center',
      consultationFee: 140,
      availableDates: _dates,
      availableTimes: _times,
      workingHours: _workingHours,
    ),
    Doctor(
      id: '6',
      name: 'Dr. Sophia Lee',
      gender: 'female',

      specialty: 'pediatrics',
      about:
          'Providing compassionate healthcare for infants, children and adolescents.',
      imageUrl: 'https://images.unsplash.com/photo-1651008376811-b90baee60c1f',
      rating: 5.0,
      reviewsCount: 520,
      experienceYears: 13,
      patientsCount: 5000,
      price: 500,
      location: 'Qasun',
      clinicAddress: 'Children Medical Center',
      consultationFee: 100,
      availableDates: _dates,
      availableTimes: _times,
      workingHours: _workingHours,
    ),
  ];

  static final List<DateTime> _dates = List.generate(
    7,
    (i) => DateTime.now().add(Duration(days: i)),
  );

  static const List<String> _times = [
    '09:00 AM',
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '02:00 PM',
    '03:00 PM',
    '04:00 PM',
  ];

  // ✅ Test working hours. time == '' means the day is CLOSED.
  static const List<WorkingHour> _workingHours = [
    WorkingHour(day: 'Sunday - Wednesday', time: '09:00 AM - 04:00 PM'),
    WorkingHour(day: 'Thursday', time: '09:00 AM - 04:00 PM'),
    WorkingHour(day: 'Friday & Saturday', time: ''), // closed
  ];
}
