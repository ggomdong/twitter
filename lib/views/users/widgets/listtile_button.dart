import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter/constants/sizes.dart';
import 'package:twitter/utils.dart';

class ListTileButton extends ConsumerWidget {
  const ListTileButton({
    super.key,
    this.leadingIcon,
    required this.text,
    this.onPressed,
    this.trailingIcon,
  });

  final IconData? leadingIcon;
  final String text;
  final VoidCallback? onPressed;
  final IconData? trailingIcon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = isDarkMode(ref);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.size6),
      child: ListTile(
        tileColor: isDark ? Colors.black : Colors.white,
        onTap: onPressed,
        leading: Icon(
          leadingIcon,
          size: Sizes.size24,
          color: isDark ? Colors.white : Colors.black,
        ),
        title: Text(
          text,
          style: TextStyle(
            fontSize: Sizes.size18,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        trailing: Icon(
          trailingIcon,
          size: Sizes.size20,
          color: Colors.grey.shade400,
        ),
      ),
    );
  }
}
