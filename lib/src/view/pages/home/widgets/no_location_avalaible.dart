import 'package:flutter/material.dart';
import 'package:timetabl_app/src/commons/commons.dart';

class EmptyLocation extends StatelessWidget {
  const EmptyLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.location_searching,
          size: 56,
          color: Colors.grey,
        ),
        Text("No Location Match You search")
      ],
    ).center();
  }
}
