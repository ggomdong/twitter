import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter/constants/sizes.dart';
import 'package:twitter/utils.dart';

class FormButton extends ConsumerWidget {
  const FormButton({
    super.key,
    required this.disabled,
    required this.text,
    required this.buttonSize,
  });

  final bool disabled;
  final String text;
  final ButtonSize buttonSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDark = isDarkMode(ref);
    return FractionallySizedBox(
      widthFactor: buttonSize == ButtonSize.large ? 1 : null,
      child: AnimatedContainer(
        padding: buttonSize == ButtonSize.large
            ? const EdgeInsets.symmetric(
                vertical: Sizes.size16,
              )
            : const EdgeInsets.symmetric(
                horizontal: Sizes.size20,
                vertical: Sizes.size8,
              ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            buttonSize == ButtonSize.large ? Sizes.size32 : Sizes.size20,
          ),
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
            fontSize:
                buttonSize == ButtonSize.large ? Sizes.size18 : Sizes.size16,
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
