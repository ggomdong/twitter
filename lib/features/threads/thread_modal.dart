import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter/constants/sizes.dart';
import 'package:twitter/features/threads/thread_report.dart';
import 'package:twitter/utils.dart';

class ThreadModal extends StatefulWidget {
  const ThreadModal({super.key});

  @override
  State<ThreadModal> createState() => _ThreadModalState();
}

class _ThreadModalState extends State<ThreadModal> {
  void _onReportTap() async {
    Navigator.of(context).pop();
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(Sizes.size16)),
      ),
      showDragHandle: true,
      backgroundColor: Colors.white,
      builder: (context) => ThreadReport(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.32,
      child: Scaffold(
        backgroundColor: isDark ? Colors.grey.shade500 : Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: Sizes.size16),
          child: Column(
            children: [
              Text("Unfollow"),
              Text("Mute"),
              Text("Hide"),
              GestureDetector(
                onTap: _onReportTap,
                child: Text("Report"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
