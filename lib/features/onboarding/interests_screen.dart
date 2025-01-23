import 'package:flutter/material.dart';
import 'package:twitter/constants/gaps.dart';
import 'package:twitter/constants/sizes.dart';
import 'package:twitter/features/authentication/widgets/form_button_small.dart';
import 'package:twitter/features/common/common_app_bar.dart';
import 'package:twitter/features/onboarding/widgets/interest_button.dart';
import 'package:twitter/utils.dart';

const interests = [
  "Daily Life",
  "Comedy",
  "Entertainment",
  "Animals",
  "Food",
  "Beauty & Style",
  "Drama",
  "Learning",
  "Talent",
  "Sports",
  "Auto",
  "Family",
  "Fitness & Health",
  "DIY & Life Hacks",
  "Arts & Crafts",
  "Dance",
  "Outdoors",
  "Oddly Satisfying",
  "Home & Garden",
  "Daily Life",
  "Comedy",
  "Entertainment",
  "Animals",
  "Food",
  "Beauty & Style",
  "Drama",
  "Learning",
  "Talent",
  "Sports",
  "Auto",
  "Family",
  "Fitness & Health",
  "DIY & Life Hacks",
  "Arts & Crafts",
  "Dance",
  "Outdoors",
  "Oddly Satisfying",
  "Home & Garden",
];

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({super.key});

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(type: LeadingType.none),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size32,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.v12,
                const Text(
                  "What do you want to see on Twitter?",
                  style: TextStyle(
                    letterSpacing: -1,
                    fontSize: Sizes.size28,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Gaps.v16,
                Text(
                  "Select at least 3 interests to personalize your Twitter experience. They will be visible on your profile.",
                  style: TextStyle(
                    fontSize: Sizes.size16,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey.shade800,
                  ),
                ),
                Gaps.v24,
                Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey.shade200,
                ),
                Gaps.v40,
                Expanded(
                  child: SingleChildScrollView(
                    child: Wrap(
                      runSpacing: Sizes.size10,
                      spacing: Sizes.size10,
                      children: [
                        for (var interest in interests)
                          InterestButton(
                            interest: interest,
                          )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            child: Container(
              height: 1,
              width: double.infinity,
              color: Colors.grey.shade200,
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: Sizes.size40,
            top: Sizes.size16,
            left: Sizes.size24,
            right: Sizes.size24,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.size16 + Sizes.size2,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: FormButtonSmall(disabled: true, text: "Next"),
          ),
        ),
      ),
    );
  }
}
