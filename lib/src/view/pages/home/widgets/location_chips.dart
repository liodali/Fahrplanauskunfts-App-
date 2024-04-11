import 'package:flutter/material.dart';

class LocationChips extends StatelessWidget {
  final List<String> chipsLabel;
  const LocationChips({
    super.key,
    required this.chipsLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      children: chipsLabel
          .map(
            (label) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Chip(
                label: Text(
                  label,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
