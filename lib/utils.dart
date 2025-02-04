import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

bool isDarkMode(BuildContext context) =>
    MediaQuery.of(context).platformBrightness == Brightness.dark;

enum LeadingType { cancel, arrow, none }

enum ButtonSize { large, small }

class Post {
  final String avatarUrl;
  final String username;
  final bool subscribed;
  final String content;
  final List<String> imageUrls;
  final int elapsedMinutes;
  final int replies;
  final int likes;

  Post({
    required this.avatarUrl,
    required this.username,
    required this.subscribed,
    required this.content,
    required this.imageUrls,
    required this.elapsedMinutes,
    required this.replies,
    required this.likes,
  });

  factory Post.generate() {
    final faker = Faker();
    List<String> images = [];

    // 랜덤하게 0~3개의 이미지 추가
    int imageCount = faker.randomGenerator.integer(4);
    int imageNumber;
    bool randomBool = Random().nextBool();

    for (int i = 0; i < imageCount; i++) {
      imageNumber = faker.randomGenerator.integer(1000);
      images.add(faker.image
          .loremPicsum(width: 1200, height: 900, random: imageNumber));
    }

    return Post(
      avatarUrl:
          "https://i.pravatar.cc/150?img=${faker.randomGenerator.integer(70)}",
      username: faker.internet.userName(),
      subscribed: randomBool,
      content: faker.lorem.sentences(2).join(" "),
      imageUrls: images,
      elapsedMinutes: faker.randomGenerator.integer(5000),
      replies: faker.randomGenerator.integer(200),
      likes: faker.randomGenerator.integer(1000),
    );
  }
}
