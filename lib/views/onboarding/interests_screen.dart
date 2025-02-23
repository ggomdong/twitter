import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter/constants/gaps.dart';
import 'package:twitter/constants/sizes.dart';
import 'package:twitter/views/authentication_twitter/widgets/form_button.dart';
import 'package:twitter/views/common/common_app_bar.dart';
import 'package:twitter/views/onboarding/another_interests_screen.dart';
import 'package:twitter/views/onboarding/widgets/firework_icon.dart';
import 'package:twitter/views/onboarding/widgets/interest_button.dart';
import 'package:twitter/utils.dart';

const interests = {
  0: "Daily Life",
  1: "Comedy",
  2: "Entertainment",
  3: "Animals",
  4: "Food",
  5: "Beauty & Style",
  6: "Drama",
  7: "Learning",
  8: "Talent",
  9: "Sports",
  10: "Auto",
  11: "Family",
  12: "Fitness & Health",
  13: "DIY & Life Hacks",
  14: "Arts & Crafts",
  15: "Dance",
  16: "Outdoors",
  17: "Oddly Satisfying",
  18: "Home & Garden",
};

class InterestsScreen extends ConsumerStatefulWidget {
  static const routeURL = "/onboarding";
  static const routeName = "interestsScreen";
  const InterestsScreen({super.key});

  @override
  InterestsScreenState createState() => InterestsScreenState();
}

class InterestsScreenState extends ConsumerState<InterestsScreen> {
  /// 선택된 항목의 인덱스 관리
  final Set<String> _selectedInterests = {};

  void _onCountSelectedInterests(item) {
    final uniqueKey = '$item.key-$item.value';
    setState(() {
      if (_selectedInterests.contains(uniqueKey)) {
        _selectedInterests.remove(uniqueKey);
      } else {
        _selectedInterests.add(uniqueKey);
      }
    });
    // TODO: 추후 서버 연계시 추가 작성
  }

  void _onAnotherInterestsTap() {
    if (_selectedInterests.length < 3) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AnotherInterestsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(ref);
    return Scaffold(
      appBar: CommonAppBar(type: LeadingType.none),
      body: Column(
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
                    color: isDark ? Colors.grey.shade400 : Colors.grey.shade800,
                  ),
                ),
              ],
            ),
          ),
          Gaps.v20,
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
                  for (var item in interests.entries)
                    InterestButton(
                      item: item.value,
                      isSelected:
                          _selectedInterests.contains('$item.key-$item.value'),
                      onTap: () => _onCountSelectedInterests(item),
                    )
                ],
              ),
            ),
          ),
          Gaps.v20,
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey.shade300,
              width: Sizes.size1,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: Sizes.size32,
            right: Sizes.size32,
            top: Sizes.size12,
            bottom: Sizes.size36,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 선택된 개수 표시
              _selectedInterests.length >= 3
                  ? RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Great works ",
                            style: TextStyle(
                              fontSize: Sizes.size14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          WidgetSpan(
                            child: FireworkIcon(),
                          ),
                        ],
                      ),
                    )
                  : Text(
                      '${_selectedInterests.length} of 3 selected',
                      style: TextStyle(
                        fontSize: Sizes.size14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade600,
                      ),
                    ),
              // 버튼 (Container로 구현)
              GestureDetector(
                onTap: _onAnotherInterestsTap,
                child: FormButton(
                  disabled: _selectedInterests.length < 3,
                  text: "Next",
                  buttonSize: ButtonSize.small,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
