import 'package:go_router/go_router.dart';
import 'package:twitter/features/authentication/login_screen.dart';
import 'package:twitter/features/authentication/sign_up_screen.dart';
import 'package:twitter/features/common/main_navigation_screen.dart';
import 'package:twitter/features/onboarding/interests_screen.dart';
import 'package:twitter/features/views/privacy_screen.dart';
import 'package:twitter/features/views/settings_screen.dart';
import 'package:twitter/features/thread/thread_screen.dart';

final router = GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        final tab = state.location.split('/')[1]; // tab 값 추출
        return MainNavigationScreen(
            tab: tab,
            child: tab == 'settings' || tab == 'privacy' ? child : null);
      },
      routes: [
        GoRoute(
          path: "/settings",
          builder: (context, state) => const SettingsScreen(),
          routes: [
            GoRoute(
              path: "privacy",
              builder: (context, state) => const PrivacyScreen(),
            ),
          ],
        ),
        GoRoute(
          path: "/:tab(|search|activity|profile|settings)",
          builder: (context, state) {
            final tab = state.params["tab"] ?? "";
            return MainNavigationScreen(tab: tab);
          },
        ),
      ],
    ),
  ],
);
