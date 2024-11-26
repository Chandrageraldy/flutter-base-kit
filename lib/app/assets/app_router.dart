import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_base_kit/app/assets/constants.dart';
import 'package:flutter_base_kit/app/view/splash_screen.dart';
import 'package:flutter_base_kit/app/view/home_page1.dart';
import 'package:flutter_base_kit/app/view/home_page2.dart';
import 'package:flutter_base_kit/app/view/navigation.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter routerConfiguration() {
    return GoRouter(
      initialLocation: NavigatePath.splashScreen,
      navigatorKey: _rootNavigatorKey,
      // NAVIGATION BAR ROUTE
      routes: [
        ShellRoute(
          navigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state, child) {
            return NoTransitionPage(
              child: Navigation(
                location: state.location,
                child: child,
              ),
            );
          },
          routes: [
            // CONFIGURE NAVIGATION BAR ROUTING
            GoRoute(
              name: NavigateName.homeScreen1,
              path: NavigatePath.homeScreen1,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: HomePage1(),
              ),
            ),
            GoRoute(
              name: NavigateName.homeScreen2,
              path: NavigatePath.homeScreen2,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: HomePage2(),
              ),
            ),
            // ADD MORE NAVIGATION BAR ROUTING BELOW
          ],
        ),
        GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          name: NavigateName.splashScreen,
          path: NavigatePath.splashScreen,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: SplashScreenPage(),
          ),
        ),
      ],
    );
  }
}
