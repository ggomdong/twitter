import 'package:flutter/material.dart';
import 'package:twitter/constants/sizes.dart';

class ListTileButton extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.size6),
      child: ListTile(
        onTap: onPressed,
        leading: Icon(
          leadingIcon,
          size: Sizes.size24,
        ),
        title: Text(
          text,
          style: TextStyle(
            fontSize: Sizes.size18,
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
