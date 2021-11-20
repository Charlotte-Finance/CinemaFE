part of 'movies_tab_bloc.dart';

abstract class MoviesTabState extends Equatable {
  const MoviesTabState();
}

class MoviesTabEmpty extends MoviesTabState {
  @override
  List<Object> get props => [];
}

class MoviesTabLoading extends MoviesTabState {
  @override
  List<Object> get props => [];
}

class MoviesTabLoaded extends MoviesTabState {
  final HashMap movies;

  const MoviesTabLoaded({required this.movies});

  @override
  List<Object> get props => [movies];
}

class MoviesTabError extends MoviesTabState {
  final String error;
  final Equatable event;

  const MoviesTabError({
    required this.error,
    required this.event,
  });

  @override
  List<Object> get props => [error, event];
}
