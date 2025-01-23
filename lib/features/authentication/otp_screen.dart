import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter/constants/gaps.dart';
import 'package:twitter/constants/sizes.dart';
import 'package:twitter/features/authentication/password_screen.dart';
import 'package:twitter/features/authentication/widgets/form_button.dart';
import 'package:twitter/features/common/common_app_bar.dart';
import 'package:twitter/utils.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({
    super.key,
    required this.name,
    required this.email,
    required this.birthday,
  });

  final String name, email, birthday;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<String?> _otpValues =
      List.generate(6, (_) => null); // 각 필드의 값을 저장할 리스트

  String _otpCode = "";
  bool _isOtpCompleted = false;

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); // 각 TextFormField의 onSaved 호출
      _otpCode = _otpValues.join(); // 리스트를 문자열로 합치기
      _isOtpCompleted = true;
      setState(() {});
    }
  }

  Widget _buildOtpField(int index) {
    return SizedBox(
      width: Sizes.size44,
      child: TextFormField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        showCursor: false,
        style: TextStyle(
          fontSize: Sizes.size28,
          fontWeight: FontWeight.w800,
        ),
        decoration: InputDecoration(
          counterText: "", // 하단의 글자 수 표시 제거
          contentPadding: EdgeInsets.only(bottom: Sizes.size18),
          border: UnderlineInputBorder(),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 3,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade300,
              width: 3,
            ),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty || value.length != 1) {
            return ''; // 에러 메시지 대신 아무것도 표시하지 않음
          }
          return null;
        },
        onSaved: (value) {
          _otpValues[index] = value; // 입력값 저장
        },
        onChanged: (value) {
          if (value.isNotEmpty && index == 5) {
            FocusScope.of(context).unfocus();
            _handleSubmit();
          } else if (value.isNotEmpty && index < 5) {
            FocusScope.of(context).nextFocus(); // 다음 필드로 이동
          } else if (value.isEmpty && index > 0) {
            FocusScope.of(context).previousFocus(); // 이전 필드로 이동
            _isOtpCompleted = false;
            setState(() {});
          }
        },
      ),
    );
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onPasswordTap() {
    if (!_isOtpCompleted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => PasswordScreen(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: CommonAppBar(type: LeadingType.arrow),
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
                      "We sent you a code",
                      style: TextStyle(
                        fontSize: Sizes.size28,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Gaps.v20,
                    Text(
                      "Enter it below to verify",
                      style: TextStyle(
                        fontSize: Sizes.size16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    Text(
                      "${widget.email}.",
                      style: TextStyle(
                        fontSize: Sizes.size16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    Gaps.v28,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        6,
                        (index) => _buildOtpField(index),
                      ),
                    ),
                    Gaps.v20,
                    if (_isOtpCompleted)
                      Align(
                        alignment: Alignment.center,
                        child: FaIcon(
                          FontAwesomeIcons.solidCircleCheck,
                          color: Colors.green,
                          size: Sizes.size32,
                        ),
                      ),
                    Gaps.v80,
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              width: size.width,
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: Sizes.size52,
                  top: Sizes.size16,
                  left: Sizes.size32,
                  right: Sizes.size32,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Didn't receive email?",
                      style: TextStyle(
                        fontSize: Sizes.size16,
                        fontWeight: FontWeight.normal,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Gaps.v14,
                    GestureDetector(
                      onTap: _onPasswordTap,
                      child: FormButton(
                        disabled: !_isOtpCompleted,
                        text: "Next",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
