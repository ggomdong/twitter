import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter/constants/gaps.dart';
import 'package:twitter/constants/sizes.dart';
import 'package:twitter/views/authentication/otp_screen.dart';
import 'package:twitter/views/authentication/customize_screen.dart';
import 'package:twitter/views/authentication/widgets/form_button.dart';
import 'package:twitter/views/common/common_app_bar.dart';
import 'package:twitter/utils.dart';

class CreateScreen extends ConsumerStatefulWidget {
  const CreateScreen({
    super.key,
    required this.name,
    required this.email,
    required this.birthday,
    required this.isSignup,
  });

  final String name, email, birthday;
  final bool isSignup;

  @override
  CreateScreenState createState() => CreateScreenState();
}

class CreateScreenState extends ConsumerState<CreateScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();

  String _name = "";
  String _email = "";
  final DateTime _selectedDate = DateTime.now();

  bool _isEmailFocused = false;
  bool _isBirthdayFocused = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.name;
    _emailController.text = widget.email;
    _birthdayController.text = widget.birthday;

    _nameController.addListener(() {
      setState(() {
        _name = _nameController.text;
      });
    });

    _emailController.addListener(() {
      setState(() {
        _email = _emailController.text;
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _birthdayController.dispose();
    super.dispose();
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  bool _isEmailValid() {
    if (_email.isEmpty) return true;
    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!regExp.hasMatch(_email)) {
      return false;
    }
    return true;
  }

  void _onEmailFocusChanged(hasFocus) {
    setState(() {
      _isEmailFocused = hasFocus;
    });
  }

  void _onBirthdayFocusChanged(hasFocus) {
    setState(() {
      _isBirthdayFocused = hasFocus;
    });
  }

  void _setTextFieldDate(DateTime date) {
    final textDate = date.toString().split(" ").first;
    _birthdayController.value = TextEditingValue(text: textDate);
  }

  void _onCustomizeTap() {
    if (_name.isEmpty || _email.isEmpty || !_isEmailValid()) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CustomizeScreen(
          name: _name,
          email: _email,
          birthday: _birthdayController.text,
        ),
      ),
    );
  }

  void _onOtpTab() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OtpScreen(
          name: widget.name,
          email: widget.email,
          birthday: widget.birthday,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isDark = isDarkMode(ref);
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: CommonAppBar(
          type: widget.isSignup ? LeadingType.arrow : LeadingType.cancel,
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size32,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gaps.v12,
                    Text(
                      "Create your account",
                      style: TextStyle(
                        fontSize: Sizes.size28 + Sizes.size2,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Gaps.v28,
                    TextFormField(
                      controller: _nameController,
                      readOnly: widget.isSignup ? true : false,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                      decoration: InputDecoration(
                        labelText: "Name",
                        suffix: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.solidCircleCheck,
                              color: _nameController.text.isNotEmpty
                                  ? Colors.green
                                  : Colors.grey.shade400,
                              size: Sizes.size20,
                            ),
                          ],
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ),
                      cursorColor: Theme.of(context).primaryColor,
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "Plase write your name";
                        }
                        return null;
                      },
                    ),
                    Gaps.v28,
                    Focus(
                      onFocusChange: _onEmailFocusChanged,
                      child: TextFormField(
                        controller: _emailController,
                        readOnly: widget.isSignup ? true : false,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        decoration: InputDecoration(
                          labelText: _isEmailFocused ||
                                  _emailController.text.isNotEmpty
                              ? "Email" // 포커스되었거나 입력값이 있으면 레이블 표시
                              : null,
                          hintText: !_isEmailFocused &&
                                  _emailController.text.isEmpty
                              ? "Phone number or email address" // 포커스되지 않았으면 힌트 표시
                              : null,
                          suffix: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.solidCircleCheck,
                                color: _isEmailValid() &&
                                        _emailController.text.isNotEmpty
                                    ? Colors.green
                                    : Colors.grey.shade400,
                                size: Sizes.size20,
                              ),
                            ],
                          ),
                          errorText: _isEmailValid() ? null : "Email not valid",
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade400,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ),
                        cursorColor: Theme.of(context).primaryColor,
                      ),
                    ),
                    Gaps.v36,
                    Focus(
                      onFocusChange: _onBirthdayFocusChanged,
                      child: TextFormField(
                        controller: _birthdayController,
                        readOnly: widget.isSignup ? true : false,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                        decoration: InputDecoration(
                          labelText: "Date of birth",
                          helperText: _isBirthdayFocused && !widget.isSignup
                              ? "This will not be shown publicly. Confirm your own age, even if this account is for a business, a pet, or something else."
                              : null,
                          helperMaxLines: 5,
                          helperStyle: TextStyle(
                            fontSize: Sizes.size16,
                          ),
                          suffix: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.solidCircleCheck,
                                color: _birthdayController.text.isNotEmpty
                                    ? Colors.green
                                    : Colors.grey.shade400,
                                size: Sizes.size20,
                              ),
                            ],
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade400,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ),
                        cursorColor: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (widget.isSignup) showSignupPolicy(size, isDark, context),
            if (!widget.isSignup)
              Positioned(
                bottom: _isBirthdayFocused ? 300 : 48,
                right: 24,
                width: Sizes.size80,
                child: GestureDetector(
                  onTap: _onCustomizeTap,
                  child: FormButton(
                    disabled: !(_name.isNotEmpty &&
                        _isEmailValid() &&
                        _birthdayController.text.isNotEmpty),
                    text: "Next",
                    buttonSize: ButtonSize.small,
                  ),
                ),
              ),
            if (_isBirthdayFocused && !widget.isSignup)
              Positioned(
                bottom: 0,
                width: size.width,
                child: SizedBox(
                  height: 300,
                  child: CupertinoDatePicker(
                    maximumDate: _selectedDate,
                    initialDateTime: _selectedDate,
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: _setTextFieldDate,
                  ),
                ),
              ),
          ],
        ),
        bottomNavigationBar: widget.isSignup
            ? Padding(
                padding: const EdgeInsets.only(
                  bottom: Sizes.size44,
                  top: Sizes.size1,
                  left: Sizes.size32,
                  right: Sizes.size32,
                ),
                child: GestureDetector(
                  onTap: _onOtpTab,
                  child: FractionallySizedBox(
                    widthFactor: 1,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: Sizes.size16,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Sizes.size32),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Text(
                        "Sign up",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: Sizes.size18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : null,
      ),
    );
  }

  Positioned showSignupPolicy(Size size, bool isDark, BuildContext context) {
    return Positioned(
      top: 500,
      width: size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size32,
        ),
        child: RichText(
          text: TextSpan(
            text: "By signing up, you agree to our",
            style: TextStyle(
                color: isDark ? null : Colors.grey.shade800,
                fontSize: Sizes.size14 + Sizes.size1,
                height: 1.45,
                letterSpacing: -0.1),
            children: [
              TextSpan(
                text: " Terms of Service",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              TextSpan(
                text: " and",
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
                text: ", including",
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
              TextSpan(
                text:
                    " Twitter may use your contact information, including your email address and phone number for purposes outlined in our Privacy Policy, like keeping your account secure and personalizing our services, including ads.",
                style: TextStyle(
                  color: isDark ? null : Colors.grey.shade800,
                ),
              ),
              TextSpan(
                text: " Learn more",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              TextSpan(
                text:
                    ". Others will be able to find you by email or phone number, when provided, unless you choose otherwise",
                style: TextStyle(
                  color: isDark ? null : Colors.grey.shade800,
                ),
              ),
              TextSpan(
                text: " here",
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
      ),
    );
  }
}
