import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_clinic_app/features/chat/presentation/screen/sessions_screen.dart';
import 'package:smart_clinic_app/features/splash/presentation/pages/on_boarding.dart';
import 'package:smart_clinic_app/features/splash/presentation/pages/splash.dart';

import '../../../features/chat/presentation/screen/chat_screen.dart';
import 'app_routes.dart';
import 'custom_navigation_observer.dart';
import 'fallback_screen.dart';

final GlobalKey<NavigatorState> rootKey = GlobalKey<NavigatorState>();

class AppRouter {
  final GoRouter goRouter;

  AppRouter(Ref ref) : goRouter = _createRouter(ref);

  static GoRouter _createRouter(Ref ref) {
    String initialRoute = AppRoutes.splashScreen;
    return GoRouter(
      navigatorKey: rootKey,
      initialLocation: initialRoute,
      observers: [CustomNavigationObserver()],
      errorBuilder: (context, state) => const FallbackScreen(),

      //   redirect: (context, state) async {
      //     // Consumer(
      //     //   builder: (context, ref, child) {
      //     //     // return ;
      //     //   },
      //     // );
      //   //  final storage = ref.read(localStorageServiceProvider);
      //   //   final isFirstTime = await storage.isFirstTimeOpen();
      //   //   final isAuth = await ref.read(isAuthenticatedProvider.future);
      //   //   final currentLocation = state.matchedLocation;

      //   //   Dev.logLine('Current location: $currentLocation');
      //   //   Dev.logLine('isFirstTime: $isFirstTime, isAuth: $isAuth');

      //   //   // ===== First-time onboarding =====
      //   //   if (isFirstTime ) {
      //   //     Dev.logLine(AppRoutes.onBoarding);
      //   //     return AppRoutes.onBoarding;
      //   //   }

      //   //   // ===== Not authenticated =====
      //   //   if (!isAuth ) {
      //   //     Dev.logLine(AppRoutes.signInScreen);

      //   //     return AppRoutes.signInScreen;
      //   //   }

      //   //   // ===== Authenticated users trying to access non-home pages =====
      //   //   // if (isAuth) {
      //   //     return AppRoutes.homeScreen;
      //     // }

      //     // No redirection needed
      //     // return null;
      // },
      routes: <RouteBase>[
        GoRoute(
          path: AppRoutes.splashScreen,
          parentNavigatorKey: rootKey,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return CustomTransitionPage(
              child: SplashScreen(),
              key: state.pageKey,
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            );
          },
        ),
        GoRoute(
          path: AppRoutes.sessionScreen,
          parentNavigatorKey: rootKey,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return CustomTransitionPage(
              child: SessionsScreen(),
              key: state.pageKey,
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            );
          },
        ),
        GoRoute(
          path: AppRoutes.chatScreen,
          parentNavigatorKey: rootKey,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return CustomTransitionPage(
              child: ChatScreen(),
              key: state.pageKey,
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            );
          },
        ),
        GoRoute(
          path: AppRoutes.onBoarding,
          parentNavigatorKey: rootKey,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return CustomTransitionPage(
              child: OnBoardingScreen(),
              key: state.pageKey,
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            );
          },
        ),
        // GoRoute(
        //   path: AppRoutes.signInScreen,
        //   name: AppRoutes.signInScreen,
        //   parentNavigatorKey: rootKey,
        //   pageBuilder: (BuildContext context, GoRouterState state) {
        //     return CustomTransitionPage(
        //       child: SignInScreen(),
        //       key: state.pageKey,
        //       transitionsBuilder:
        //           (context, animation, secondaryAnimation, child) {
        //         return FadeTransition(opacity: animation, child: child);
        //       },
        //     );
        //   },
        // ),

      ],
    );
  }
}
