import 'package:flutter/material.dart';
import 'package:twitter/constants/gaps.dart';
import 'package:twitter/constants/sizes.dart';
import 'package:twitter/views/onboarding/widgets/another_interest_button.dart';

class HorizontalInterests extends StatefulWidget {
  const HorizontalInterests({
    super.key,
    required this.items,
    required this.category,
    required this.onSelectedItemsChanged,
  });

  final Map<String, String> items;
  final String category;
  final ValueChanged<Set<String>> onSelectedItemsChanged;

  @override
  State<HorizontalInterests> createState() => _HorizontalInterestsState();
}

class _HorizontalInterestsState extends State<HorizontalInterests> {
  final Set<String> selectedItems = {};

  void _onSelectItems(String key) {
    setState(() {
      if (selectedItems.contains(key)) {
        selectedItems.remove(key);
      } else {
        selectedItems.add(key);
      }
    });
    widget.onSelectedItemsChanged(selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
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
                widget.category,
                style: TextStyle(
                  fontSize: Sizes.size20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Gaps.v32,
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: size.width * 2,
                  child: Wrap(
                    runSpacing: Sizes.size10,
                    spacing: Sizes.size10,
                    children: [
                      for (var item in widget.items.entries)
                        AnotherInterestButton(
                          item: item.value,
                          isSelected: selectedItems.contains(item.key),
                          onTap: () => _onSelectItems(item.key),
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
    );
  }
}
