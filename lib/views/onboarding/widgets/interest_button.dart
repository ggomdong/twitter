import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter/constants/sizes.dart';
import 'package:twitter/utils.dart';

class InterestButton extends ConsumerWidget {
  const InterestButton({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  final String item;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final isDark = isDarkMode(ref);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        width: size.width / 2 - 20,
        height: Sizes.size80 + Sizes.size2,
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).primaryColor
              : isDark
                  ? Colors.black
                  : Colors.white,
          borderRadius: BorderRadius.circular(
            Sizes.size10,
          ),
          border: Border.all(
            color: isDark ? Colors.white : Colors.black.withValues(alpha: 0.2),
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: Sizes.size5,
              left: Sizes.size10,
              child: Text(
                item,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: Sizes.size16,
                    fontWeight: FontWeight.bold,
                    color: isSelected
                        ? Colors.white
                        : isDark
                            ? Colors.white
                            : Colors.black87),
              ),
            ),
            Positioned(
              top: Sizes.size10,
              right: Sizes.size10,
              child: FaIcon(
                FontAwesomeIcons.solidCircleCheck,
                size: Sizes.size18,
                color: isSelected ? Colors.white : Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
