import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter/constants/gaps.dart';
import 'package:twitter/constants/sizes.dart';
import 'package:twitter/utils.dart';
import 'package:twitter/view_models/sign_up_view_model.dart';
import 'package:twitter/view_models/social_auth_view_model.dart';
import 'package:twitter/views/authentication/widgets/auth_button.dart';
import 'package:twitter/views/authentication/widgets/form_button.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  static const routeURL = "/signUp";
  static const routeName = "signUp";
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";
  String _confirmPassword = "";
  bool _obscurePw1 = true;
  bool _obscurePw2 = true;

  // Keyboard 외의 영역 클릭시 Keyboard가 사라지도록 처리
  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  // email 유효성 체크
  bool _isEmailValid(String email) {
    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return regExp.hasMatch(email);
  }

  // password 유효성 체크(자리수)
  bool _isPasswordValid(String password) {
    return password.length >= 8;
  }

  // password 유효성 체크(일치)
  bool _isPasswordMatch() {
    return _password == _confirmPassword;
  }

  // password 비식별 처리 토글
  void _toggleObscurePw1() {
    _obscurePw1 = !_obscurePw1;
    setState(() {});
  }

  void _toggleObscurePw2() {
    _obscurePw2 = !_obscurePw2;
    setState(() {});
  }

  void _onSubmitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ref.read(signUpForm.notifier).state = {
        "email": _email,
        "password": _password
      };
      ref.read(signUpProvider.notifier).signUp(context);
    }
  }

  void _onLogInTap() {
    context.pop();
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
                      if (!_isEmailValid(value)) {
                        return 'Invalid email';
                      }
                      return null;
                    },
                    onChanged: (value) => setState(() => _email = value),
                    onSaved: (value) {
                      if (value != null) {
                        _email = value;
                      }
                    },
                  ),
                  Gaps.v16,
                  TextFormField(
                    obscureText: _obscurePw1,
                    decoration: InputDecoration(
                      suffix: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: _toggleObscurePw1,
                            child: FaIcon(
                              _obscurePw1
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
                      if (!_isPasswordValid(value)) {
                        return 'Password must be at least 8 characters';
                      }
                      if (!_isPasswordMatch()) {
                        return 'Password must be matched';
                      }
                      return null;
                    },
                    onChanged: (value) => setState(() => _password = value),
                    onSaved: (value) {
                      if (value != null) {
                        _password = value;
                      }
                    },
                  ),
                  Gaps.v16,
                  TextFormField(
                    obscureText: _obscurePw2,
                    decoration: InputDecoration(
                      suffix: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: _toggleObscurePw2,
                            child: FaIcon(
                              _obscurePw2
                                  ? FontAwesomeIcons.eye
                                  : FontAwesomeIcons.eyeSlash,
                              color: Colors.grey.shade500,
                              size: Sizes.size20,
                            ),
                          ),
                        ],
                      ),
                      border: const OutlineInputBorder(),
                      labelText: 'Confirm Password',
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
                      if (!_isPasswordValid(value)) {
                        return 'Password must be at least 8 characters';
                      }
                      if (!_isPasswordMatch()) {
                        return 'Password must be matched';
                      }
                      return null;
                    },
                    onChanged: (value) =>
                        setState(() => _confirmPassword = value),
                    onSaved: (value) {
                      if (value != null) {
                        _confirmPassword = value;
                      }
                    },
                  ),
                  Gaps.v20,
                  FormButton(
                    disabled: !(_isEmailValid(_email) &&
                        _isPasswordValid(_password) &&
                        _isPasswordMatch() &&
                        !ref.watch(signUpProvider).isLoading),
                    text: "Sign Up",
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
              text: "Log in",
              buttonSize: ButtonSize.large,
              buttonType: ButtonType.sub,
              onTap: _onLogInTap,
            ),
          ),
        ),
      ),
    );
  }
}
