import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter/constants/gaps.dart';
import 'package:twitter/constants/sizes.dart';
import 'package:twitter/views/authentication_twitter/create_screen.dart';
import 'package:twitter/views/authentication_twitter/login_screen.dart';
import 'package:twitter/views/authentication_twitter/widgets/auth_button.dart';
import 'package:twitter/views/common/common_app_bar.dart';
import 'package:twitter/utils.dart';

class SignUpScreen extends ConsumerWidget {
  static const routeURL = "/";
  static const routeName = "signUp";
  const SignUpScreen({super.key});

  void _onCreateTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateScreen(
          name: "",
          email: "",
          birthday: "",
          isSignup: false,
        ),
      ),
    );
  }

  void _onLoginTap(BuildContext context) {
    context.pushNamed(LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDark = isDarkMode(ref);
    return Scaffold(
      appBar: CommonAppBar(type: LeadingType.none),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size32,
        ),
        child: Column(
          children: [
            Gaps.v96,
            Gaps.v48,
            Text(
              "See what's happening in the world right now.",
              style: TextStyle(
                fontSize: Sizes.size28 + Sizes.size2,
                fontWeight: FontWeight.w900,
              ),
            ),
            Gaps.v96,
            Gaps.v64,
            AuthButton(
              icon: FaIcon(
                FontAwesomeIcons.google,
                size: Sizes.size24,
              ),
              text: "Continue with Google",
            ),
            Gaps.v14,
            AuthButton(
              icon: FaIcon(
                FontAwesomeIcons.apple,
                size: Sizes.size24,
              ),
              text: "Continue with Apple",
            ),
            Gaps.v20,
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey.shade400,
                ),
                Container(
                  color: isDark
                      ? Colors.black
                      : Colors.white, // 배경색 추가로 선 위에 텍스트가 읽기 쉽게 설정
                  padding: EdgeInsets.symmetric(
                    horizontal: Sizes.size10,
                  ),
                  child: Text(
                    "or",
                    style: TextStyle(
                      fontSize: Sizes.size12,
                    ),
                  ),
                ),
              ],
            ),
            Gaps.v3,
            GestureDetector(
              onTap: () => _onCreateTap(context),
              child: AuthButton(
                isInverted: true,
                text: "Create account",
              ),
            ),
            Gaps.v28,
            RichText(
              text: TextSpan(
                text: "By signing up, you agree to our",
                style: TextStyle(
                  color: isDark ? null : Colors.grey.shade800,
                  fontSize: Sizes.size16 + Sizes.size1,
                ),
                children: [
                  TextSpan(
                    text: " Terms",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  TextSpan(
                    text: ",",
                    style: TextStyle(
                      color: isDark ? null : Colors.grey.shade800,
                    ),
                  ),
                  TextSpan(
                    text: " Privacy Policy",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  TextSpan(
                    text: ", and",
                    style: TextStyle(
                      color: isDark ? null : Colors.grey.shade800,
                    ),
                  ),
                  TextSpan(
                    text: " Cookie Use",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  TextSpan(
                    text: ".",
                    style: TextStyle(
                      color: isDark ? null : Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size32,
          vertical: Sizes.size48,
        ),
        child: Row(
          children: [
            const Text(
              'Have an account already?',
              style: TextStyle(
                fontSize: Sizes.size14,
              ),
            ),
            Gaps.h5,
            GestureDetector(
              onTap: () => _onLoginTap(context),
              child: Text(
                'Log in',
                style: TextStyle(
                  fontSize: Sizes.size14,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
