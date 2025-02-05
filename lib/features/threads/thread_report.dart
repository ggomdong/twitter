import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter/constants/sizes.dart';
import 'package:twitter/utils.dart';

class ThreadReport extends StatefulWidget {
  const ThreadReport({super.key});

  @override
  State<ThreadReport> createState() => _ThreadReportState();
}

class _ThreadReportState extends State<ThreadReport> {
  final List<String> _reports = [
    "I just don't like it",
    "It's unlawful content under NetzDG",
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.65,
      child: Scaffold(
        backgroundColor: isDark ? Colors.grey.shade500 : Colors.white,
        appBar: AppBar(
          leading: null,
          title: Text(
            "Report",
            style:
                TextStyle(fontSize: Sizes.size20, fontWeight: FontWeight.w700),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: Sizes.size16),
          child: Card(
            child: ListTile(
              title: Text("I just don't like it"),
            ),
          ),
        ),
      ),
    );
  }
}
