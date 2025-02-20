import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter/constants/sizes.dart';
import 'package:twitter/utils.dart';

class ThreadsList extends StatelessWidget {
  const ThreadsList({
    required this.text,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    return ListTile(
      // ListTile 크기 변경
      contentPadding: EdgeInsets.only(
        left: Sizes.size16,
        right: Sizes.size24,
        top: Sizes.size7,
        bottom: Sizes.size7,
      ),
      title: Text(
        text,
        style: TextStyle(
          fontSize: Sizes.size18,
          fontWeight: FontWeight.w400,
          color: isDark ? Colors.white : Colors.black,
        ),
      ),
      trailing: FaIcon(
        FontAwesomeIcons.chevronRight,
        size: Sizes.size16,
        color: Colors.grey.shade500,
      ),
      shape: Border(
        bottom: BorderSide(
          color: Colors.grey.shade300,
        ),
      ),
    );
  }
}
