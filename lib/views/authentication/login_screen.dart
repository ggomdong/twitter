import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter/constants/gaps.dart';
import 'package:twitter/constants/sizes.dart';
import 'package:twitter/utils.dart';
import 'package:twitter/view_models/login_view_model.dart';
import 'package:twitter/view_models/social_auth_view_model.dart';
import 'package:twitter/views/authentication/sign_up_screen.dart';
import 'package:twitter/views/authentication/widgets/auth_button.dart';
import 'package:twitter/views/authentication/widgets/form_button.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const routeURL = "/";
  static const routeName = "login";
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  Map<String, String> formData = {};

  // Keyboard 외의 영역 클릭시 Keyboard가 사라지도록 처리
  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  // password 비식별 처리 토글
  void _toggleObscureText() {
    _obscureText = !_obscureText;
    setState(() {});
  }

  void _onSubmitForm() {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        ref.read(loginProvider.notifier).login(
              formData["email"]!,
              formData["password"]!,
              context,
            );
      }
    }
  }

  void _onSignUpTap() {
    context.pushNamed(SignUpScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: Sizes.size96 + Sizes.size60,
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FaIcon(
                FontAwesomeIcons.squareThreads,
                size: Sizes.size96,
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Sizes.size16,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Gaps.v96,
                  Gaps.v32,
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Email',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter an email';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      if (value != null) {
                        formData['email'] = value;
                      }
                    },
                  ),
                  Gaps.v16,
                  TextFormField(
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      suffix: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: _toggleObscureText,
                            child: FaIcon(
                              _obscureText
                                  ? FontAwesomeIcons.eye
                                  : FontAwesomeIcons.eyeSlash,
                              color: Colors.grey.shade500,
                              size: Sizes.size20,
                            ),
                          ),
                        ],
                      ),
                      border: const OutlineInputBorder(),
                      labelText: 'Password',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: Sizes.size2,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a password';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      if (value != null) {
                        formData['password'] = value;
                      }
                    },
                  ),
                  Gaps.v20,
                  FormButton(
                    disabled: ref.watch(loginProvider).isLoading,
                    text: "Log in",
                    buttonSize: ButtonSize.large,
                    buttonType: ButtonType.main,
                    onTap: _onSubmitForm,
                  ),
                  Gaps.v32,
                  GestureDetector(
                    onTap: () => ref
                        .read(socialAuthProvider.notifier)
                        .githubSignIn(context),
                    child: AuthButton(
                      icon: FaIcon(
                        FontAwesomeIcons.github,
                        size: Sizes.size24,
                      ),
                      text: "Continue with Github",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size48,
          ),
          child: Container(
            padding: EdgeInsets.all(
              Sizes.size20,
            ),
            child: FormButton(
              disabled: false,
              text: "Create new account",
              buttonSize: ButtonSize.large,
              buttonType: ButtonType.sub,
              onTap: _onSignUpTap,
            ),
          ),
        ),
      ),
    );
  }
}
