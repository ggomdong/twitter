import 'package:flutter/material.dart';
import 'package:twitter/constants/sizes.dart';
import 'package:twitter/utils.dart';

class FormButton extends StatelessWidget {
  FormButton({
    super.key,
    required this.disabled,
    required this.text,
  });

  final bool disabled;
  String text;

  @override
  Widget build(BuildContext context) {
    final bool isDark = isDarkMode(context);
    return FractionallySizedBox(
      widthFactor: 1,
      child: AnimatedContainer(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size16,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizes.size32),
          color: disabled
              ? isDark
                  ? Colors.grey.shade800
                  : Colors.grey.shade600
              : isDark
                  ? Colors.white
                  : Colors.black,
        ),
        duration: const Duration(milliseconds: 500),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: Sizes.size18,
            fontWeight: FontWeight.w700,
            color: disabled
                ? isDark
                    ? Colors.grey.shade600
                    : Colors.grey.shade400
                : isDark
                    ? Colors.black
                    : Colors.white,
          ),
        ),
      ),
    );
  }
}
