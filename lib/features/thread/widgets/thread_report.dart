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
        backgroundColor: isDark ? Colors.grey.shade900 : Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(Sizes.size36),
          child: AppBar(
            backgroundColor: isDark ? Colors.grey.shade900 : Colors.white,
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
                fontSize: Sizes.size18 + Sizes.size1,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : Colors.black,
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
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Gaps.v6,
                    Text(
                      "Your report is anonymous, except if you're reporting an intellectual property infringement. If someone is in immediate danger, call the local emergency services - don't wait.",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: Sizes.size14 + Sizes.size1,
                        fontWeight: FontWeight.w400,
                        height: 1.2,
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
