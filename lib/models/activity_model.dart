import 'dart:math';

import 'package:faker/faker.dart';

enum ActivityCategory { mention, reply, like }

class Activities {
  final int userId;
  final String avatarUrl;
  final String username;
  bool isFollowed = false;
  final ActivityCategory categoty;
  final String message;
  final int elapsedMinutes;

  Activities({
    required this.userId,
    required this.avatarUrl,
    required this.username,
    required this.isFollowed,
    required this.categoty,
    required this.message,
    required this.elapsedMinutes,
  });

  factory Activities.generate(int index) {
    final faker = Faker();
    final fakerFa = Faker(provider: FakerDataProvider());

    // 구독한 user 이름 옆 체크표시를 위한 랜덤 bool 세팅
    bool randomBool = faker.randomGenerator.integer(10) < 2;

    // 랜덤 ActivityCategory 값 생성
    ActivityCategory getRandomCategory() {
      final random = Random();
      return ActivityCategory
          .values[random.nextInt(ActivityCategory.values.length)];
    }

    return Activities(
      userId: index,
      avatarUrl:
          "https://i.pravatar.cc/150?img=${faker.randomGenerator.integer(70)}",
      username: faker.internet.userName(),
      isFollowed: randomBool,
      categoty: getRandomCategory(),
      message: fakerFa.lorem.sentence(),
      elapsedMinutes: faker.randomGenerator.integer(5000),
    );
  }
}
