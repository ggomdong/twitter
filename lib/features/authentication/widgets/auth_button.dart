import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter/constants/gaps.dart';
import 'package:twitter/constants/sizes.dart';
import 'package:twitter/utils.dart';

class AuthButton extends StatelessWidget {
  final FaIcon? icon;
  final String text;
  final bool isInverted;

  const AuthButton({
    super.key,
    this.icon,
    required this.text,
    this.isInverted = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        padding: const EdgeInsets.all(Sizes.size16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: Colors.grey.shade400,
            width: 1,
          ),
          color: isInverted
              ? isDark
                  ? Colors.white
                  : Colors.black
              : isDark
                  ? Colors.black
                  : Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon ?? Text(""),
            Gaps.h14,
            Text(
              text,
              style: TextStyle(
                fontSize: Sizes.size18,
                fontWeight: FontWeight.w800,
                color: isInverted
                    ? isDark
                        ? Colors.black
                        : Colors.white
                    : isDark
                        ? Colors.white
                        : Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
