import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter/constants/gaps.dart';
import 'package:twitter/constants/sizes.dart';
import 'package:twitter/features/authentication/confirm_screen.dart';
import 'package:twitter/utils.dart';

class CustomizeScreen extends StatelessWidget {
  const CustomizeScreen({super.key});

  void _onConfirmTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ConfirmScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: FaIcon(
          FontAwesomeIcons.twitter,
          size: Sizes.size32,
          color: Theme.of(context).primaryColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size32,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.v20,
            FractionallySizedBox(
              widthFactor: 0.7,
              child: Text(
                "Customize your experience",
                style: TextStyle(
                  fontSize: Sizes.size28 + Sizes.size2,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Gaps.v20,
            FractionallySizedBox(
              widthFactor: 0.7,
              child: Text(
                "Track where you see Twitter content across the web",
                style: TextStyle(
                  fontSize: Sizes.size20,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Gaps.v20,
            Row(
              children: [
                Flexible(
                  child: Text(
                    "Twitter uses this data to personalize your experience. This web browsing history will never be stored with your name, email, or, phone number.",
                    style: TextStyle(
                      fontSize: Sizes.size16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Text("switch"),
              ],
            ),
            Gaps.v20,
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
                  TextSpan(
                    text:
                        " Twitter may use your contact information, including your email address and phone number for purchase outlined in our Privacy Policy.",
                    style: TextStyle(
                      color: isDark ? null : Colors.grey.shade800,
                    ),
                  ),
                  TextSpan(
                    text: " Learn more",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: Sizes.size14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: Sizes.size40,
            top: Sizes.size16,
            left: Sizes.size32,
            right: Sizes.size32,
          ),
          child: GestureDetector(
            onTap: () => _onConfirmTap(context),
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.size20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: isDark ? Colors.white : Colors.black,
              ),
              child: const Text(
                'Next',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: Sizes.size16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
