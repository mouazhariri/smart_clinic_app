abstract class AppRoutes {
  //? init screen
  static const String initScreen = '/';
  static const String splashScreen = '/splash';
  static const String onBoarding = '/onBoarding';

  static const String authScreen = '/auth';
  static const String signInScreen = '/signIn';
  static const String signUpScreen = '/signUp';
  static const String verificationScreen = '/verification';

  static const String homeScreen = '/home';
  static const String doctorsScreen = '/doctors';
  static const String doctorDetailsScreen = '/doctors/:doctorId';
  static const String bookAppointmentScreen = '/doctors/:doctorId/book';
  static const String appointmentsScreen = '/appointments';
  static const String profileScreen = '/profile';

  static const String sessionScreen = '/session';
  static const String chatScreen = '/chat';

  static String doctorDetailsPath(String doctorId) => '/doctors/$doctorId';
  static String bookAppointmentPath(String doctorId) => '/doctors/$doctorId/book';
}
