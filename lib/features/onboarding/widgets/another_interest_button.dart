import 'package:flutter/material.dart';
import 'package:twitter/constants/sizes.dart';

class AnotherInterestButton extends StatelessWidget {
  const AnotherInterestButton({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  final String item;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        padding: EdgeInsets.symmetric(
          horizontal: Sizes.size24,
          vertical: Sizes.size10,
        ),
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(
            Sizes.size32,
          ),
          border: Border.all(
            color: Colors.black.withValues(alpha: 0.2),
          ),
        ),
        child: Text(
          item,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: Sizes.size16,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : Colors.black87),
        ),
      ),
    );
  }
}
