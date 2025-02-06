import 'package:flutter/material.dart';
import 'package:twitter/constants/gaps.dart';
import 'package:twitter/constants/sizes.dart';
import 'package:twitter/features/thread/widgets/thread_button.dart';
import 'package:twitter/features/thread/widgets/thread_list.dart';
import 'package:twitter/utils.dart';

class ThreadReport extends StatelessWidget {
  const ThreadReport({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.65,
      child: Scaffold(
        backgroundColor: isDark ? Colors.grey.shade500 : Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(Sizes.size40),
          child: AppBar(
            toolbarHeight: Sizes.size24,
            automaticallyImplyLeading: false,
            centerTitle: true,
            shape: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 0.5,
              ),
            ),
            title: Text(
              "Report",
              style: TextStyle(
                fontSize: Sizes.size20,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Why are you reporting this thread?",
                      style: TextStyle(
                        fontSize: Sizes.size18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Gaps.v10,
                    Text(
                      "Your report is anonymous, except if you're reporting an intellectual property infringement. If someone is in immediate danger, call the local emergency services - don't wait.",
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: Sizes.size16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Gaps.v10,
              buildDivider(),
              ThreadsList(text: "I just don't like it"),
              ThreadsList(text: "It's unlawful content under NetzDG"),
              ThreadsList(text: "It's spam"),
              ThreadsList(text: "Hate speech or symbols"),
              ThreadsList(text: "Nudity or sexual activity"),
              ThreadsList(text: "Fearful articles"),
              ThreadsList(text: "It's related to the real crime"),
            ],
          ),
        ),
      ),
    );
  }
}
