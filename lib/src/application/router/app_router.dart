import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_clinic_app/features/appointments/presentation/screens/appointment_tracking_screen.dart';

import 'package:smart_clinic_app/features/appointments/presentation/screens/appointments_screen.dart';
import 'package:smart_clinic_app/features/appointments/presentation/screens/session_details_screen.dart';
import 'package:smart_clinic_app/features/auth/presentation/screens/auth_screen.dart';
import 'package:smart_clinic_app/features/auth/signIn/presentation/screens/sign_in_screen.dart';
import 'package:smart_clinic_app/features/auth/signUp/presentation/screens/signup_screen.dart';
import 'package:smart_clinic_app/features/auth/verification/presentation/screens/verification_account_screen.dart';
import 'package:smart_clinic_app/features/booking/presentation/screens/booking_confirmation_screen.dart';
import 'package:smart_clinic_app/features/booking/presentation/screens/booking_screen.dart';
import 'package:smart_clinic_app/features/booking/presentation/screens/booking_success_screen.dart';
import 'package:smart_clinic_app/features/chat/presentation/screen/chat_screen.dart';
import 'package:smart_clinic_app/features/chat/presentation/screen/sessions_screen.dart';
import 'package:smart_clinic_app/features/doctors/domain/entities/doctor.dart';
import 'package:smart_clinic_app/features/doctors/presentation/screens/doctor_details_screen.dart';
import 'package:smart_clinic_app/features/doctors/presentation/screens/doctors_screen.dart';
import 'package:smart_clinic_app/features/home/presentation/screens/home_screen.dart';
import 'package:smart_clinic_app/features/home/presentation/screens/main_scaffold.dart';
import 'package:smart_clinic_app/features/profile/presentation/screens/change_language_screen.dart';
import 'package:smart_clinic_app/features/profile/presentation/screens/privacy_policy_screen.dart';
import 'package:smart_clinic_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:smart_clinic_app/features/splash/presentation/pages/on_boarding.dart';
import 'package:smart_clinic_app/features/splash/presentation/pages/splash.dart';

import '../../../features/profile/presentation/screens/terms_privacy_screen.dart';
import 'app_routes.dart';
import 'custom_navigation_observer.dart';
import 'fallback_screen.dart';

final GlobalKey<NavigatorState> rootKey = GlobalKey<NavigatorState>();

class AppRouter {
  final GoRouter goRouter;

  AppRouter(Ref ref) : goRouter = _createRouter(ref);

  static GoRouter _createRouter(Ref ref) {
    return GoRouter(
      navigatorKey: rootKey,
      initialLocation: AppRoutes.splashScreen,
      observers: [CustomNavigationObserver()],
      errorBuilder: (context, state) => const FallbackScreen(),
      routes: <RouteBase>[
        // ── Splash & onboarding ─────────────────────────────────────────────
        _fadeRoute(
          path: AppRoutes.splashScreen,
          builder: (context, state) => const SplashScreen(),
        ),
        _fadeRoute(
          path: AppRoutes.onBoarding,
          builder: (context, state) => const OnBoardingScreen(),
        ),

        // ── Auth ────────────────────────────────────────────────────────────
        _fadeRoute(
          path: AppRoutes.authScreen,
          builder: (context, state) => const AuthLandingScreen(),
        ),
        _fadeRoute(
          path: AppRoutes.signInScreen,
          builder: (context, state) => const SignInScreen(),
        ),
        _fadeRoute(
          path: AppRoutes.signUpScreen,
          builder: (context, state) => const SignupScreen(),
        ),
        _fadeRoute(
          path: AppRoutes.verificationScreen,
          builder: (context, state) => VerificationAccountScreen(
            phone: state.extra is String ? state.extra as String : '',
          ),
        ),

        // ── Main tabs ───────────────────────────────────────────────────────
        _fadeRoute(
          path: AppRoutes.homeScreen,
          builder: (context, state) =>
              const MainScaffold(currentIndex: 0, child: HomeScreen()),
        ),
        _fadeRoute(
          path: AppRoutes.doctorsScreen,
          builder: (context, state) =>
              const MainScaffold(currentIndex: 1, child: DoctorsScreen()),
        ),
        _fadeRoute(
          path: AppRoutes.appointmentsScreen,
          builder: (context, state) =>
              const MainScaffold(currentIndex: 2, child: AppointmentsScreen()),
        ),
        _fadeRoute(
          path: AppRoutes.profileScreen,
          builder: (context, state) =>
              const MainScaffold(currentIndex: 3, child: ProfileScreen()),
        ),

        // ── Doctor details ──────────────────────────────────────────────────
        _fadeRoute(
          path: AppRoutes.doctorDetailsScreen,
          builder: (context, state) {
            final doctor = state.extra;
            if (doctor is! Doctor) return const FallbackScreen();
            return DoctorDetailsScreen(doctor: doctor);
          },
        ),

        // ── Booking ─────────────────────────────────────────────────────────
        _fadeRoute(
          path: AppRoutes.bookAppointmentScreen,
          builder: (context, state) {
            final extra = state.extra;
            if (extra is! Map) return const FallbackScreen();
            final doctor = extra['doctor'];
            if (doctor is! Doctor) return const FallbackScreen();
            return BookingScreen(doctor: doctor);
          },
        ),

        // ── Booking confirmation ─────────────────────────────────────────────
        _fadeRoute(
          path: AppRoutes.bookAppointmentConfirmScreen,
          builder: (context, state) {
            final extra = state.extra;
            if (extra is! Map) return const FallbackScreen();

            final doctor = extra['doctor'];
            final selectedDate = extra['selectedDate'];
            final selectedTime = extra['selectedTime'];
            final price = extra['price'];

            if (doctor is! Doctor ||
                selectedDate is! DateTime ||
                selectedTime is! String) {
              return const FallbackScreen();
            }

            return BookingConfirmationScreen(
              doctor: doctor,
              selectedDate: selectedDate,
              selectedTime: selectedTime,
              price: price is double ? price : 0.0,
            );
          },
        ),

        // ── Booking success ──────────────────────────────────────────────────
        _fadeRoute(
          path: AppRoutes.bookAppointmentSuccessScreen,
          builder: (context, state) {
            final extra = state.extra;
            if (extra is! Map) return const FallbackScreen();

            final doctor = extra['doctor'];
            final selectedDate = extra['selectedDate'];
            final selectedTime = extra['selectedTime'];
            final appointmentNumber =
                extra['appointmentNumber'] as String? ?? '#9874';

            if (doctor is! Doctor ||
                selectedDate is! DateTime ||
                selectedTime is! String) {
              return const FallbackScreen();
            }

            return BookingSuccessScreen(
              doctor: doctor,
              selectedDate: selectedDate,
              selectedTime: selectedTime,
              appointmentNumber: appointmentNumber,
            );
          },
        ),

        // ── Chat ────────────────────────────────────────────────────────────
        _fadeRoute(
          path: AppRoutes.sessionScreen,
          builder: (context, state) => const SessionsScreen(),
        ),
        _fadeRoute(
          path: AppRoutes.chatScreen,
          builder: (context, state) => const ChatScreen(),
        ),
        _fadeRoute(
          path: AppRoutes.appointmentTrackingScreen,
          builder: (context, state) {
            final id = state.extra as String?;
            if (id == null) return const FallbackScreen();
            return AppointmentTrackingScreen(appointmentId: id);
          },
        ),
        _fadeRoute(
          path: AppRoutes.sessionDetailsScreen,
          builder: (context, state) {
            final id = state.extra as String?;
            if (id == null) return const FallbackScreen();
            return SessionDetailsScreen(appointmentId: id);
          },
        ),
        _fadeRoute(
          path: AppRoutes.privacyPolicyScreen,
          builder: (context, state) {
            return PrivacyPolicyScreen();
          },
        ),
        _fadeRoute(
          path: AppRoutes.changeLanguageScreen,
          builder: (context, state) {
            return ChangeLanguageScreen();
          },
        ),
        _fadeRoute(
          path: AppRoutes.termsPrivacyScreen,
          builder: (context, state) {
            return TermsPrivacyScreen();
          },
        ),
      ],
    );
  }

  static GoRoute _fadeRoute({
    required String path,
    required Widget Function(BuildContext context, GoRouterState state) builder,
  }) {
    return GoRoute(
      path: path,
      parentNavigatorKey: rootKey,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: builder(context, state),
          transitionDuration: const Duration(milliseconds: 250),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        );
      },
    );
  }
}
