import 'package:flutter/material.dart';
import 'package:search_repository/search_repository.dart';
import 'package:timetabl_app/src/view/pages/home/widgets/location_chips.dart';
import 'package:timetabl_app/src/view/pages/home/widgets/location_is_best.dart';

class ListLocationItemWidget extends StatelessWidget {
  final Location location;

  const ListLocationItemWidget({
    super.key,
    required this.location,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Row(
          children: [
            Expanded(
              child: Text(
                location.name,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
            LocationIsBestWidget(
              isBest: location.isBest,
            ),
          ],
        ),
        subtitle: LocationChips(
          chipsLabel: location.buildContent(),
        ),
      ),
    );
  }
}
