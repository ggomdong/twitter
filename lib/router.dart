import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter/repos/authentication_repo.dart';
import 'package:twitter/views/authentication/login_screen.dart';
import 'package:twitter/views/authentication/sign_up_screen.dart';
import 'package:twitter/views/common/main_navigation_screen.dart';
import 'package:twitter/views/users/privacy_screen.dart';
import 'package:twitter/views/users/settings_screen.dart';

final routerProvider = Provider(
  (ref) {
    return GoRouter(
      initialLocation: "/home",
      redirect: (context, state) {
        final isLoggedIn = ref.read(authRepo).isLoggedIn;
        if (!isLoggedIn) {
          if (state.subloc != SignUpScreen.routeURL &&
              state.subloc != LoginScreen.routeURL) {
            return LoginScreen.routeURL;
          }
        }
        return null;
      },
      routes: [
        GoRoute(
          name: SignUpScreen.routeName,
          path: SignUpScreen.routeURL,
          builder: (context, state) => const SignUpScreen(),
        ),
        GoRoute(
          name: LoginScreen.routeName,
          path: LoginScreen.routeURL,
          builder: (context, state) => const LoginScreen(),
        ),
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
              path: "/:tab(home|search|activity|profile|settings)",
              builder: (context, state) {
                final tab = state.params["tab"] ?? "";
                return MainNavigationScreen(tab: tab);
              },
            ),
          ],
        ),
      ],
    );
  },
);
