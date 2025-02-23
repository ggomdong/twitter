import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter/view_models/settings_vm.dart';

bool isDarkMode(WidgetRef ref) => ref.watch(settingsProvider).darkMode;

enum LeadingType { cancel, arrow, none }

enum ButtonSize { large, small }

enum ButtonType { main, sub }

// elapsedMinutes에 따라 표기방법(분, 시간, 일)을 다르게 해주는 함수
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
