import 'package:flutter/material.dart';
import 'package:timetabl_app/src/commons/commons.dart';

class ErrorLocationWidget extends StatelessWidget {
  final String error;
  const ErrorLocationWidget({
    super.key,
    required this.error,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.warning_amber_rounded,
          size: 56,
          color: Theme.of(context).colorScheme.error,
        ),
        Text(error),
      ],
    ).center();
  }
}
