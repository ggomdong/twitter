import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter/constants/gaps.dart';
import 'package:twitter/constants/sizes.dart';

class ThreadSample extends StatelessWidget {
  const ThreadSample({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: Sizes.size16,
            right: Sizes.size16,
            top: Sizes.size16,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: Sizes.size24,
                    backgroundColor: Colors.grey.shade300,
                    foregroundImage: NetworkImage(
                        "https://avatars.githubusercontent.com/u/63599714?v=4"),
                  ),
                ],
              ),
              Gaps.h10,
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "jane_mobbin",
                          style: TextStyle(
                            fontSize: Sizes.size16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "5h",
                              style: TextStyle(
                                fontSize: Sizes.size16,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade500,
                              ),
                            ),
                            Gaps.h14,
                            Text(
                              "···",
                              style: TextStyle(
                                fontSize: Sizes.size16,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      "Give @john_mobbin a follow if you want to see more travel content!",
                      // 이미지가 있으면 1줄, 없으면 2줄
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: Sizes.size16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Gaps.v16,
                    Row(
                      children: [
                        FaIcon(FontAwesomeIcons.heart),
                        Gaps.h20,
                        FaIcon(FontAwesomeIcons.comment),
                        Gaps.h20,
                        FaIcon(FontAwesomeIcons.arrowsRotate),
                        Gaps.h20,
                        FaIcon(FontAwesomeIcons.paperPlane),
                      ],
                    ),
                    Gaps.v16,
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 1,
          width: double.infinity,
          color: Colors.grey.shade200,
        ),
      ],
    );
  }
}
