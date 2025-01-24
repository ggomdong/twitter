import 'package:flutter/material.dart';
import 'package:twitter/constants/gaps.dart';
import 'package:twitter/constants/sizes.dart';
import 'package:twitter/features/authentication/widgets/form_button.dart';
import 'package:twitter/features/common/common_app_bar.dart';
import 'package:twitter/features/onboarding/widgets/another_interest_button.dart';
import 'package:twitter/utils.dart';

const music = {
  0: "Pop",
  1: "Rock",
  2: "Hiphop",
  3: "Country",
  4: "Classical",
  5: "Jazz",
  6: "Electronic",
  7: "Rhythm and Blues",
  8: "Rock and Metal",
  9: "Composer",
  10: "Conductor",
  11: "Performer",
  12: "Singer",
  13: "Melody",
  14: "Rhythm",
  15: "Harmony",
  16: "Tempo",
  17: "Scale",
  18: "Upbeat",
  19: "Calm",
  20: "Intense",
  21: "Lyrical",
  22: "Synthesizer",
  23: "A cappella",
  24: "Brass",
};

const entertainment = {
  0: "Cinema",
  1: "Music",
  2: "Performing Arts",
  3: "Television",
  4: "Radio",
  5: "Gaming",
  6: "Sports",
  7: "Theme Parks",
  8: "Circus",
  9: "Comedy",
  10: "Magic",
  11: "Theatre",
  12: "Opera",
  13: "Musical",
  14: "Concerts",
  15: "Festivals",
  16: "Exhibitions",
  17: "Nightlife",
  18: "Dance",
  19: "Puzzles",
  20: "Literature",
  21: "Comics",
  22: "Animation",
  23: "Fashion Shows",
  24: "Karaoke",
};

const sports = {
  0: "Football",
  1: "Basketball",
  2: "Baseball",
  3: "Tennis",
  4: "Swimming",
  5: "Athletics",
  6: "Volleyball",
  7: "Golf",
  8: "Boxing",
  9: "Taekwondo",
  10: "Skiing",
  11: "Snowboarding",
  12: "Surfing",
  13: "Gymnastics",
  14: "Cycling",
  15: "Marathon",
  16: "Rugby",
  17: "Table Tennis",
  18: "Badminton",
  19: "Ice Hockey",
  20: "Yoga",
  21: "Pilates",
  22: "CrossFit",
  23: "Fencing",
  24: "Archery",
};

class AnotherInterestsScreen extends StatefulWidget {
  const AnotherInterestsScreen({super.key});

  @override
  State<AnotherInterestsScreen> createState() => _AnotherInterestsScreenState();
}

class _AnotherInterestsScreenState extends State<AnotherInterestsScreen> {
  /// 선택된 항목의 인덱스 관리
  final Set<String> _selectedItems = {};

  void _onCountSelectedInterests(item) {
    final uniqueKey = '$item.key-$item.value';
    setState(() {
      if (_selectedItems.contains(uniqueKey)) {
        _selectedItems.remove(uniqueKey);
      } else {
        _selectedItems.add(uniqueKey);
      }
    });
    // TODO: 추후 서버 연계시 추가 작성
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(type: LeadingType.arrow),
      body: SingleChildScrollView(
        child: Column(
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
                    "Interests are used to personalize your experience and will be visible on your profile.",
                    style: TextStyle(
                      fontSize: Sizes.size16,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey.shade800,
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
            Gaps.v24,
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Music",
                    style: TextStyle(
                      fontSize: Sizes.size20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Gaps.v32,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: 1100,
                      child: Wrap(
                        runSpacing: Sizes.size10,
                        spacing: Sizes.size10,
                        children: [
                          for (var item in music.entries)
                            AnotherInterestButton(
                              item: item.value,
                              isSelected: _selectedItems
                                  .contains('$item.key-$item.value'),
                              onTap: () => _onCountSelectedInterests(item),
                            ),
                        ],
                      ),
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
            Gaps.v24,
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Entertainment",
                    style: TextStyle(
                      fontSize: Sizes.size20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Gaps.v32,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: 1100,
                      child: Wrap(
                        runSpacing: Sizes.size10,
                        spacing: Sizes.size10,
                        children: [
                          for (var item in entertainment.entries)
                            AnotherInterestButton(
                              item: item.value,
                              isSelected: _selectedItems
                                  .contains('$item.key-$item.value'),
                              onTap: () => _onCountSelectedInterests(item),
                            ),
                        ],
                      ),
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
            Gaps.v24,
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sports",
                    style: TextStyle(
                      fontSize: Sizes.size20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Gaps.v32,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: 1100,
                      child: Wrap(
                        runSpacing: Sizes.size10,
                        spacing: Sizes.size10,
                        children: [
                          for (var item in sports.entries)
                            AnotherInterestButton(
                              item: item.value,
                              isSelected: _selectedItems
                                  .contains('$item.key-$item.value'),
                              onTap: () => _onCountSelectedInterests(item),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Gaps.v20,
          ],
        ),
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
              Text(""),
              GestureDetector(
                onTap: () {},
                child: FormButton(
                  disabled: _selectedItems.length < 3,
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
