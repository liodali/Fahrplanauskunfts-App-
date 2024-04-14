import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timetabl_app/src/commons/commons.dart';
import 'package:timetabl_app/src/model/search_state.dart';
import 'package:timetabl_app/src/view/widgets/error_widget.dart';
import 'package:timetabl_app/src/view/widgets/light_dark_mode_widget.dart';
import 'package:timetabl_app/src/view/widgets/loading.dart';
import 'package:timetabl_app/src/view/pages/home/widgets/location_item.dart';
import 'package:timetabl_app/src/view/pages/home/widgets/no_location_avalaible.dart';
import 'package:timetabl_app/src/view/pages/home/widgets/search.dart';
import 'package:timetabl_app/src/viewmodel/search_vm.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fahrplann"),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        notificationPredicate: (notification) => false,
        actions: const [
          LightDarkModeWidget(),
        ],
      ),
      body: OrientationBuilder(builder: (context, orientation) {
        return const HomeBodyWidget();
      }),
    );
  }
}

class HomeBodyWidget extends ConsumerWidget {
  const HomeBodyWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final istate = ref.watch(searchProvider);
    ref.listen(searchProvider, (prev, next) {
      if (next is ErrorState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).colorScheme.error,
            content: Text(next.error),
          ),
        );
      }
    });
    final isPortrait = MediaQuery.orientationOf(context).isPortrait;
    final widthScreen = MediaQuery.sizeOf(context).width;
    return Stack(
      children: [
        Positioned(
          top: istate is LoadingState
              ? 0
              : istate is SearchState && istate.location.isEmpty
                  ? 0
                  : isPortrait
                      ? 135
                      : 96,
          left: 8,
          right: 8,
          bottom: 0,
          child: const ListLocationWidget(),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          top: istate is LoadingState
              ? 25
              : istate is SearchState
                  ? 10
                  : 125,
          left: isPortrait ? 8 : widthScreen * 0.1,
          right: isPortrait ? 8 : widthScreen * 0.2,
          height: isPortrait ? null : 92,
          child: const SearchWidget(),
        ),
      ],
    );
  }
}

class ListLocationWidget extends ConsumerWidget {
  const ListLocationWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final istate = ref.watch(searchProvider);
    final orientation = MediaQuery.orientationOf(context);
    return switch (istate) {
      SearchState() => istate.location.isNotEmpty
          ? orientation.isPortrait
              ? ListView.builder(
                  itemBuilder: (context, index) => ListLocationItemWidget(
                    location: istate.location[index],
                  ),
                  itemCount: istate.location.length,
                )
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 6,
                    crossAxisSpacing: 8,
                  ),
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) => ListLocationItemWidget(
                    location: istate.location[index],
                  ),
                  itemCount: istate.location.length,
                )
          : const EmptyLocation(),
      LoadingState() => const LoadingWidget(),
      NoState() => const SizedBox.shrink(),
      ErrorState() => ErrorLocationWidget(
          error: istate.error,
        ),
    };
  }
}
