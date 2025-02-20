import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/features/view_models/config_vm.dart';

bool isDarkMode(BuildContext context) =>
    context.read<ConfigViewModel>().darkmode;

enum LeadingType { cancel, arrow, none }

enum ButtonSize { large, small }

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
