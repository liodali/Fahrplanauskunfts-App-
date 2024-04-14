import 'package:flutter/material.dart';

enum RowColumn { row, column }

typedef WhenUse = ({Orientation orientation, RowColumn rowColumn});

class RowColumnConfiguration {
  final MainAxisSize mainRowAxisSize;
  final MainAxisSize mainColmnAxisSize;
  final MainAxisAlignment mainRowAxisAlignment;
  final CrossAxisAlignment crossRowAxisAlignment;

  final MainAxisAlignment mainColumnAxisAlignment;
  final CrossAxisAlignment crossColumnAxisAlignment;

  const RowColumnConfiguration({
    this.mainRowAxisSize = MainAxisSize.min,
    this.mainColmnAxisSize = MainAxisSize.min,
    this.mainRowAxisAlignment = MainAxisAlignment.start,
    this.crossRowAxisAlignment = CrossAxisAlignment.center,
    this.mainColumnAxisAlignment = MainAxisAlignment.start,
    this.crossColumnAxisAlignment = CrossAxisAlignment.center,
  });
}

class DynamicOrientationRowColumn extends StatelessWidget {
  final List<Widget> children;
  final (WhenUse usage1, WhenUse usage2) whenUsage;
  final RowColumnConfiguration rowColumnConfiguration;
  DynamicOrientationRowColumn({
    super.key,
    required this.children,
    required this.whenUsage,
    this.rowColumnConfiguration = const RowColumnConfiguration(),
  }) : assert(whenUsage.$1.orientation != whenUsage.$2.orientation &&
            whenUsage.$1.rowColumn != whenUsage.$2.rowColumn);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      final usage1 = whenUsage.$1;
      final usage2 = whenUsage.$2;
      if (usage1.orientation == orientation) {
        return switch (usage1.rowColumn) {
          RowColumn.row => Row(
              mainAxisSize: rowColumnConfiguration.mainRowAxisSize,
              mainAxisAlignment: rowColumnConfiguration.mainRowAxisAlignment,
              crossAxisAlignment: rowColumnConfiguration.crossRowAxisAlignment,
              children: children,
            ),
          RowColumn.column => Column(
              mainAxisSize: rowColumnConfiguration.mainColmnAxisSize,
              mainAxisAlignment: rowColumnConfiguration.mainColumnAxisAlignment,
              crossAxisAlignment:
                  rowColumnConfiguration.crossColumnAxisAlignment,
              children: children,
            ),
        };
      } else if (usage2.orientation == orientation) {
        return switch (usage2.rowColumn) {
          RowColumn.row => Row(
              mainAxisSize: rowColumnConfiguration.mainRowAxisSize,
              mainAxisAlignment: rowColumnConfiguration.mainRowAxisAlignment,
              crossAxisAlignment: rowColumnConfiguration.crossRowAxisAlignment,
              children: children,
            ),
          RowColumn.column => Column(
              mainAxisSize: rowColumnConfiguration.mainColmnAxisSize,
              mainAxisAlignment: rowColumnConfiguration.mainColumnAxisAlignment,
              crossAxisAlignment:
                  rowColumnConfiguration.crossColumnAxisAlignment,
              children: children,
            ),
        };
      }
      return const SizedBox.shrink();
    });
  }
}
