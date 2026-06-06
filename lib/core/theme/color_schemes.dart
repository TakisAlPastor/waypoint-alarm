import 'package:flutter/material.dart';

const Color _kSeedColor = Color(0xFF2979FF);

final ColorScheme kLightColorScheme = ColorScheme.fromSeed(
  seedColor: _kSeedColor,
);

final ColorScheme kDarkColorScheme = ColorScheme.fromSeed(
  seedColor: _kSeedColor,
  brightness: Brightness.dark,
);
