import 'package:equatable/equatable.dart';
import 'package:search_repository/search_repository.dart';

sealed class IState extends Equatable {}

class SearchState extends IState {
  final List<Location> location;

  SearchState({required this.location});

  @override
  List<Object?> get props => [location];
}

class LoadingState extends IState {
  @override
  List<Object?> get props => [];
}

class NoState extends IState {
  @override
  List<Object?> get props => [];
}

class ErrorState extends IState {
  final String error;

  ErrorState({required this.error});
  @override
  List<Object?> get props => [error];
}
/*
class SearchState {
  final bool isLoading;
  final List<Location> location;
  final String error;

  SearchState({
    required this.isLoading,
    required this.location,
    required this.error,
  });
  SearchState.loading()
      : isLoading = true,
        location = [],
        error = "";
  SearchState.data({
    required this.location,
  })  : isLoading = false,
        error = "";
         SearchState.data({
    required this.location,
  })  : isLoading = false,
        error = "";
}*/
