import 'package:flutter/material.dart';
import 'package:twitter/constants/sizes.dart';
import 'package:twitter/utils.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.size40 + Sizes.size3,
        vertical: Sizes.size5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey.shade400,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: Sizes.size18,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.01,
          color: isDark ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
