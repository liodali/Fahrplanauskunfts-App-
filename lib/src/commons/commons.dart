import 'package:flutter/material.dart';

final regexWhiteSpace = RegExp(r"\s+\b|\b\s");

enum AppMode {
  light,
  dark;

  AppMode nextAppMode() => this == AppMode.light ? AppMode.dark : AppMode.light;
  ThemeMode toThemeMode() =>
      this == AppMode.light ? ThemeMode.light : ThemeMode.dark;
}

ButtonStyle appElevatedButtonStyle() {
  return ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  );
}

extension UIWidget on Widget {
  Widget padding(EdgeInsetsGeometry padding) => Padding(
        padding: padding,
        child: this,
      );

  Widget center() => Center(
        child: this,
      );
}

extension OrientationExt on Orientation {
  bool get isPortrait => this == Orientation.portrait;
  bool get isLandscape => this == Orientation.landscape;
}
