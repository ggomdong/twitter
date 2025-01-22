import 'package:flutter/material.dart';
import 'package:twitter/constants/sizes.dart';
import 'package:twitter/utils.dart';

class FormButtonSmall extends StatelessWidget {
  const FormButtonSmall({
    super.key,
    required this.disabled,
  });

  final bool disabled;

  @override
  Widget build(BuildContext context) {
    final bool isDark = isDarkMode(context);
    return AnimatedContainer(
      padding: EdgeInsets.symmetric(
        horizontal: Sizes.size20,
        vertical: Sizes.size8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.size20),
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
        "Next",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: Sizes.size16,
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
    );
  }
}
