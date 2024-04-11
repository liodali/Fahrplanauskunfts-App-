import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_repository/search_repository.dart';
import 'package:timetabl_app/src/model/search_state.dart';
import 'package:timetabl_app/src/viewmodel/commons.dart';

final searchProvider =
    AutoDisposeNotifierProvider<SearchNotifier, IState>(SearchNotifier.new);

class SearchNotifier extends AutoDisposeNotifier<IState> {
  late final SearchRepository repo = ref.read(repositoryProvider);
  SearchNotifier();
  var locations = <Location>[];
  CancelToken? cancelToken;
  @override
  IState build() {
    ref.onDispose(() {
      if (cancelToken != null && !cancelToken!.isCancelled) {
        cancelToken!.cancel();
        cancelToken = null;
      }
    });
    state = NoState();
    return state;
  }

  Future<void> searchStartPoint(String text) async {
    cancelToken = CancelToken();
    state = LoadingState();
    final asyncValue = await AsyncValue.guard(() => repo.retrieveStartPoints(
          text,
          cancelToken: cancelToken,
        ));
    if (asyncValue.hasValue) {
      locations = asyncValue.value!;
      state = SearchState(location: locations);
    } else if (asyncValue.hasError) {
      state = ErrorState(error: "Ops!we cannot retrieve the data!");
    } else {
      state = NoState();
    }
  }
  void reset(){
       state = NoState();
    }
}
