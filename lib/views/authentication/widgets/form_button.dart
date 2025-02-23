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
    required this.buttonType,
    required this.onTap,
  });

  final bool disabled;
  final String text;
  final ButtonSize buttonSize;
  final ButtonType buttonType;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDark = isDarkMode(ref);
    return GestureDetector(
      onTap: onTap,
      child: FractionallySizedBox(
        widthFactor: buttonSize == ButtonSize.large ? 1 : null,
        child: AnimatedContainer(
          padding: buttonSize == ButtonSize.large
              ? EdgeInsets.symmetric(
                  vertical: buttonType == ButtonType.main
                      ? Sizes.size16
                      : Sizes.size8,
                )
              : const EdgeInsets.symmetric(
                  horizontal: Sizes.size20,
                  vertical: Sizes.size8,
                ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              buttonSize == ButtonSize.large ? Sizes.size5 : Sizes.size5,
            ),
            color: buttonType == ButtonType.main
                ? disabled
                    ? isDark
                        ? Colors.grey.shade800
                        : Colors.grey.shade600
                    : isDark
                        ? Colors.white
                        : Theme.of(context).primaryColor
                : Colors.white,
            border: buttonType == ButtonType.sub
                ? Border.all(
                    width: 1,
                    color: Colors.grey.shade400,
                  )
                : null,
          ),
          duration: const Duration(milliseconds: 500),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize:
                  buttonSize == ButtonSize.large ? Sizes.size18 : Sizes.size16,
              fontWeight: buttonType == ButtonType.main
                  ? FontWeight.w700
                  : FontWeight.w400,
              color: buttonType == ButtonType.main
                  ? disabled
                      ? isDark
                          ? Colors.grey.shade600
                          : Colors.grey.shade400
                      : isDark
                          ? Colors.black
                          : Colors.white
                  : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
