import 'package:flutter/material.dart';
import 'package:waypoint_alarm/core/theme/color_schemes.dart';

final ThemeData kLightTheme = ThemeData(
  colorScheme: kLightColorScheme,
  navigationBarTheme: const NavigationBarThemeData(
    labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
  ),
);

final ThemeData kDarkTheme = ThemeData(
  colorScheme: kDarkColorScheme,
  navigationBarTheme: const NavigationBarThemeData(
    labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
  ),
);
