import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter/view_models/settings_view_model.dart';

bool isDarkMode(WidgetRef ref) => ref.watch(settingsProvider).darkMode;

enum LeadingType { cancel, arrow, none }

enum ButtonSize { large, small }

enum ButtonType { main, sub }

// elapsedMinutes에 따라 표기방법(분, 시간, 일)을 다르게 해주는 함수
// 아직 사용하는 화면이 있어서 추후 삭제 예정
String convertTime(int minutes) {
  switch (minutes) {
    case <= 60:
      return "${minutes}m";
    case <= 1440:
      return "${(minutes / 60).floor()}h";
    default:
      return "${(minutes / 1440).floor()}d";
  }
}

// DateTime.now().millisecondsSinceEpoch 으로 작성된 createdAt 값을 넣고 현재와의 차이를 계산하여 반환
String calculateTimeByCreatedAt(int createdAt) {
  int nowMillis = DateTime.now().millisecondsSinceEpoch;
  int differenceInSeconds = (nowMillis - createdAt) ~/ 1000;
  int minutes = differenceInSeconds ~/ 60;

  switch (minutes) {
    case <= 60:
      return "${minutes}m";
    case <= 1440:
      return "${(minutes / 60).floor()}h";
    default:
      return "${(minutes / 1440).floor()}d";
  }
}

void showFirebaseErrorSnack(BuildContext context, Object? error) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      showCloseIcon: true,
      content: Text(
        (error as FirebaseException).message ?? "Something went wrong.",
      ),
    ),
  );
}

String loadAvatar(String uid) =>
    "https://firebasestorage.googleapis.com/v0/b/twitter-ggomdong.firebasestorage.app/o/avatars%2F$uid?alt=media";

String loadAvatarForUpdate(String uid) =>
    "https://firebasestorage.googleapis.com/v0/b/twitter-ggomdong.firebasestorage.app/o/avatars%2F$uid?alt=media&haha=${DateTime.now().toString()}";
