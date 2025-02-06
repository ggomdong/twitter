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
  required String text,
  Color? color,
  VoidCallback? onPressed,
}) {
  return Material(
    color: Colors.grey.shade100,
    child: InkWell(
      onTap: onPressed,
      // 클릭 시 iOS 스타일 효과
      highlightColor: Colors.grey.shade800,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size20,
          vertical: Sizes.size16,
        ),
        color: Colors.grey.shade100,
        width: double.infinity,
        child: Text(
          text,
          style: TextStyle(
            color: color ?? Colors.black,
            fontSize: Sizes.size16,
            fontWeight: FontWeight.w900,
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
