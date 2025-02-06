import 'package:flutter/material.dart';
import 'package:twitter/constants/sizes.dart';

Widget buildButtonGroup(List<Widget> children) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(
      Sizes.size20,
    ),
    child: Column(children: children),
  );
}

Widget buildModalButton({
  required bool isDark,
  required String text,
  Color? color,
  VoidCallback? onPressed,
}) {
  return Material(
    color: Colors.grey.shade100,
    child: InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size20,
          vertical: Sizes.size16,
        ),
        color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
        width: double.infinity,
        child: Text(
          text,
          style: TextStyle(
            color: color ?? (isDark ? Colors.white : Colors.black),
            fontSize: Sizes.size16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
  );
}

Widget buildDivider() {
  return Container(
    height: 1,
    color: Colors.grey.shade300,
  );
}
