import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

bool isDarkMode(BuildContext context) =>
    MediaQuery.of(context).platformBrightness == Brightness.dark;

enum LeadingType { cancel, arrow, none }

enum ButtonSize { large, small }
