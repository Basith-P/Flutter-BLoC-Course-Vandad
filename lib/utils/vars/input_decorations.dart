import 'package:flutter/material.dart';

import '../global/keys.dart';

final kInputDecoration = InputDecoration(
  filled: true,
  fillColor: Theme.of(navigatorKey.currentContext!).colorScheme.surfaceVariant,
  isDense: true,
  contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: BorderSide.none,
  ),
);
