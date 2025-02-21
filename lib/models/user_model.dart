import 'dart:math';

import 'package:faker/faker.dart';

class Users {
  final int userId;
  final String avatarUrl;
  final String username;
  bool isFollowed;
  final String company;
  final String followers;
  final int elapsedMinutes;

  Users({
    required this.userId,
    required this.avatarUrl,
    required this.username,
    required this.isFollowed,
    required this.company,
    required this.followers,
    required this.elapsedMinutes,
  });

  factory Users.generate(int index) {
    final faker = Faker();

    // 구독한 user 이름 옆 체크표시를 위한 랜덤 bool 세팅
    bool randomBool = Random().nextBool();

    return Users(
      userId: index,
      avatarUrl:
          "https://i.pravatar.cc/150?img=${faker.randomGenerator.integer(70)}",
      username: faker.internet.userName(),
      isFollowed: randomBool,
      company: faker.company.name(),
      followers:
          (faker.randomGenerator.integer(10000) * 0.1).toStringAsFixed(1),
      elapsedMinutes: faker.randomGenerator.integer(5000),
    );
  }
}
