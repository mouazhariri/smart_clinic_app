import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_clinic_app/features/appointments/presentation/screens/appointments_screen.dart';
import 'package:smart_clinic_app/features/appointments/presentation/screens/book_appointment_screen.dart';
import 'package:smart_clinic_app/features/auth/presentation/screens/auth_screen.dart';
import 'package:smart_clinic_app/features/auth/signIn/presentation/screens/sign_in_screen.dart';
import 'package:smart_clinic_app/features/auth/signUp/presentation/screens/signup_screen.dart';
import 'package:smart_clinic_app/features/auth/verification/presentation/screens/verification_account_screen.dart';
import 'package:smart_clinic_app/features/chat/presentation/screen/chat_screen.dart';
import 'package:smart_clinic_app/features/chat/presentation/screen/sessions_screen.dart';
import 'package:smart_clinic_app/features/doctors/presentation/screens/doctor_details_screen.dart';
import 'package:smart_clinic_app/features/doctors/presentation/screens/doctors_screen.dart';
import 'package:smart_clinic_app/features/home/presentation/screens/home_screen.dart';
import 'package:smart_clinic_app/features/home/presentation/screens/main_scaffold.dart';
import 'package:smart_clinic_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:smart_clinic_app/features/splash/presentation/pages/on_boarding.dart';
import 'package:smart_clinic_app/features/splash/presentation/pages/splash.dart';

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
        _fadeRoute(
          path: AppRoutes.splashScreen,
          builder: (context, state) => const SplashScreen(),
        ),
        _fadeRoute(
          path: AppRoutes.onBoarding,
          builder: (context, state) => const OnBoardingScreen(),
        ),
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
          builder: (context, state) => SignupScreen(
            phoneNumber: state.extra is String ? state.extra as String : '',
          ),
        ),
        _fadeRoute(
          path: AppRoutes.verificationScreen,
          builder: (context, state) => VerificationAccountScreen(
            phone: state.extra is String ? state.extra as String : '',
          ),
        ),
        _fadeRoute(
          path: AppRoutes.homeScreen,
          builder: (context, state) => const MainScaffold(
            currentIndex: 0,
            child: HomeScreen(),
          ),
        ),
        _fadeRoute(
          path: AppRoutes.doctorsScreen,
          builder: (context, state) => const MainScaffold(
            currentIndex: 1,
            child: DoctorsScreen(),
          ),
        ),
        _fadeRoute(
          path: AppRoutes.doctorDetailsScreen,
          builder: (context, state) => DoctorDetailsScreen(
            doctorId: state.pathParameters['doctorId']!,
          ),
        ),
        _fadeRoute(
          path: AppRoutes.bookAppointmentScreen,
          builder: (context, state) => BookAppointmentScreen(
            doctorId: state.pathParameters['doctorId']!,
          ),
        ),
        _fadeRoute(
          path: AppRoutes.appointmentsScreen,
          builder: (context, state) => const MainScaffold(
            currentIndex: 2,
            child: AppointmentsScreen(),
          ),
        ),
        _fadeRoute(
          path: AppRoutes.profileScreen,
          builder: (context, state) => const MainScaffold(
            currentIndex: 3,
            child: ProfileScreen(),
          ),
        ),
        _fadeRoute(
          path: AppRoutes.sessionScreen,
          builder: (context, state) => const SessionsScreen(),
        ),
        _fadeRoute(
          path: AppRoutes.chatScreen,
          builder: (context, state) => const ChatScreen(),
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
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        );
      },
    );
  }
}
