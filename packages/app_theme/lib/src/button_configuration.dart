import 'package:flutter/material.dart';

enum _InnerStyle {
  text,
  elevated;
}

enum AppButtonStyle {
  flat(
    ButtonStyleConfiguration.textButton(
      elevation: 0,
      backgroundColor: Colors.transparent,
      roundedRectangleBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    ),
  ),
  elevated(
    ButtonStyleConfiguration.elevateButton(
      elevation: 1,
      roundedRectangleBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    ),
  );

  const AppButtonStyle(this.configuration);
  final ButtonStyleConfiguration configuration;
}

class ButtonStyleConfiguration {
  final RoundedRectangleBorder? roundedRectangleBorder;
  final double elevation;
  final Color? backgroundColor;
  final _InnerStyle _innerStyle;
  const ButtonStyleConfiguration._({
    this.roundedRectangleBorder,
    this.elevation = 2,
    this.backgroundColor,
    _InnerStyle innerStyle = _InnerStyle.elevated,
  }) : _innerStyle = innerStyle;
  const ButtonStyleConfiguration.elevateButton({
    this.roundedRectangleBorder,
    this.elevation = 2,
    this.backgroundColor,
  }) : _innerStyle = _InnerStyle.elevated;
  const ButtonStyleConfiguration.textButton({
    this.roundedRectangleBorder,
    this.elevation = 0,
    this.backgroundColor,
  }) : _innerStyle = _InnerStyle.text;

  ButtonStyleConfiguration copyWith({
    RoundedRectangleBorder? roundedRectangleBorder,
    double? elevation,
    Color? backgroundColor,
  }) =>
      ButtonStyleConfiguration._(
        innerStyle: _innerStyle,
        elevation: elevation ?? this.elevation,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        roundedRectangleBorder:
            roundedRectangleBorder ?? this.roundedRectangleBorder,
      );

  ButtonStyle get style => _innerStyle == _InnerStyle.text
      ? TextButton.styleFrom(
          elevation: elevation,
          shape: roundedRectangleBorder,
          backgroundColor: backgroundColor,
        )
      : ElevatedButton.styleFrom(
          elevation: elevation,
          shape: roundedRectangleBorder,
          backgroundColor: backgroundColor,
        );
}
