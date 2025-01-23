import 'package:flutter/material.dart';
import 'package:twitter/constants/gaps.dart';
import 'package:twitter/constants/sizes.dart';
import 'package:twitter/features/authentication/create_screen.dart';
import 'package:twitter/features/authentication/widgets/form_button.dart';
import 'package:twitter/features/common/common_app_bar.dart';
import 'package:twitter/utils.dart';

class CustomizeScreen extends StatefulWidget {
  const CustomizeScreen({
    super.key,
    required this.name,
    required this.email,
    required this.birthday,
  });

  final String name, email, birthday;

  @override
  State<CustomizeScreen> createState() => _CustomizeScreenState();
}

class _CustomizeScreenState extends State<CustomizeScreen> {
  bool _notifications = false;

  void _onNotificationsChanged(bool? newValue) {
    if (newValue == null) return;
    setState(() {
      _notifications = newValue;
    });
  }

  void _onConfirmTap() {
    if (!_notifications) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CreateScreen(
          name: widget.name,
          email: widget.email,
          birthday: widget.birthday,
          isSignup: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = isDarkMode(context);
    return Scaffold(
      appBar: CommonAppBar(type: LeadingType.arrow),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size32,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.v12,
            Text(
              "Customize your experience",
              style: TextStyle(
                fontSize: Sizes.size28,
                fontWeight: FontWeight.w900,
              ),
            ),
            Gaps.v20,
            Text(
              "Track where you see Twitter content across the web",
              style: TextStyle(
                fontSize: Sizes.size20,
                fontWeight: FontWeight.w800,
              ),
            ),
            Gaps.v12,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 8,
                  child: Text(
                    "Twitter uses this data to personalize your experience. This web browsing history will never be stored with your name, email, or phone number.",
                    style: TextStyle(
                      fontSize: Sizes.size16 + Sizes.size1,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Switch.adaptive(
                    value: _notifications,
                    onChanged: _onNotificationsChanged,
                  ),
                ),
              ],
            ),
            Gaps.v28,
            RichText(
              text: TextSpan(
                text: "By signing up, you agree to our",
                style: TextStyle(
                  color: isDark ? null : Colors.grey.shade800,
                  fontSize: Sizes.size14 + Sizes.size1,
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
                  TextSpan(
                    text:
                        " Twitter may use your contact information, including your email address and phone number for purposes outlined in our Privacy Policy.",
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
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          bottom: Sizes.size52,
          top: Sizes.size16,
          left: Sizes.size32,
          right: Sizes.size32,
        ),
        child: GestureDetector(
          onTap: _onConfirmTap,
          child: FormButton(
            disabled: !_notifications,
            text: "Next",
          ),
        ),
      ),
    );
  }
}
