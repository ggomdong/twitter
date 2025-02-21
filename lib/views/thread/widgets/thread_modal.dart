import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter/constants/gaps.dart';
import 'package:twitter/constants/sizes.dart';
import 'package:twitter/views/thread/widgets/thread_report.dart';
import 'package:twitter/views/thread/widgets/thread_button.dart';
import 'package:twitter/utils.dart';

class ThreadModal extends ConsumerStatefulWidget {
  const ThreadModal({super.key});

  @override
  ThreadModalState createState() => ThreadModalState();
}

class ThreadModalState extends ConsumerState<ThreadModal> {
  void _onReportTap() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(Sizes.size16)),
      ),
      showDragHandle: true,
      backgroundColor: isDarkMode(ref) ? Colors.grey.shade900 : Colors.white,
      builder: (context) => ThreadReport(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(ref);
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.32,
      child: Scaffold(
        backgroundColor: isDark ? Colors.grey.shade900 : Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size24,
          ),
          child: Column(
            children: [
              buildButtonGroup([
                buildModalButton(isDark: isDark, text: "Unfollow"),
                buildDivider(),
                buildModalButton(isDark: isDark, text: "Mute"),
              ]),
              Gaps.v16,
              buildButtonGroup([
                buildModalButton(isDark: isDark, text: "Hide"),
                buildDivider(),
                buildModalButton(
                  isDark: isDark,
                  text: "Report",
                  color: Colors.red,
                  onPressed: _onReportTap,
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
