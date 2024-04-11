import 'package:flutter/material.dart';

class LocationIsBestWidget extends StatelessWidget {
  final bool isBest;
  const LocationIsBestWidget({
    super.key,
    this.isBest = false,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      switch (isBest) {
        true => Icons.star,
        _ => Icons.star_border,
      },
      color: switch (isBest) {
        true => Theme.of(context).colorScheme.tertiary,
        _ => Theme.of(context).colorScheme.outline
      },
      size: 24,
    );
  }
}
