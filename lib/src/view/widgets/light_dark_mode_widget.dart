import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timetabl_app/src/commons/commons.dart';
import 'package:timetabl_app/src/viewmodel/commons.dart';

class LightDarkModeWidget extends ConsumerWidget {
  const LightDarkModeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(appModeProvider);
    return IconButton(
      onPressed: () {
        ref
            .read(appModeProvider.notifier)
            .update((state) => mode.nextAppMode());
      },
      icon: Icon(switch (mode) {
        AppMode.light => Icons.dark_mode,
        AppMode.dark => Icons.light_mode,
      }),
    );
  }
}
