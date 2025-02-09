import 'dart:math';

import 'package:faker/faker.dart';

class Post {
  final String avatarUrl;
  final String username;
  final bool subscribed;
  final String content;
  final List<String> imageUrls;
  final int elapsedMinutes;
  final int replies;
  final List<String> repliesAvatars;
  final int likes;

  Post({
    required this.avatarUrl,
    required this.username,
    required this.subscribed,
    required this.content,
    required this.imageUrls,
    required this.elapsedMinutes,
    required this.replies,
    required this.repliesAvatars,
    required this.likes,
  });

  factory Post.generate() {
    final faker = Faker();
    List<String> images = [];
    List<String> avatars = [];

    // 구독한 user 이름 옆 체크표시를 위한 랜덤 bool 세팅
    bool randomBool = Random().nextBool();

    // 랜덤하게 0~3개의 이미지 추가
    int imageCount = faker.randomGenerator.integer(4);
    int imageNumber;

    for (int i = 0; i < imageCount; i++) {
      imageNumber = faker.randomGenerator.integer(1000);
      images.add(faker.image
          .loremPicsum(width: 1200, height: 900, random: imageNumber));
    }

    // reply한 user들의 avatar 이미지
    for (int i = 0; i < 3; i++) {
      avatars.add(
          "https://i.pravatar.cc/150?img=${faker.randomGenerator.integer(70)}");
    }

    return Post(
      avatarUrl:
          "https://i.pravatar.cc/150?img=${faker.randomGenerator.integer(70)}",
      username: faker.internet.userName(),
      subscribed: randomBool,
      content: faker.lorem.sentences(2).join(" "),
      imageUrls: images,
      elapsedMinutes: faker.randomGenerator.integer(5000),
      replies: faker.randomGenerator.integer(4),
      repliesAvatars: avatars,
      likes: faker.randomGenerator.integer(1000),
    );
  }
}
