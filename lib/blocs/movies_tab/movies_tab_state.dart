part of 'movies_tab_bloc.dart';

abstract class MoviesTabState extends Equatable {
  final HashMap movies;

  const MoviesTabState({required this.movies});

  @override
  List<Object> get props => [movies];
}

class MoviesTabEmpty extends MoviesTabState {
  final HashMap movies;

  MoviesTabEmpty({required this.movies}) : super(movies: movies);

  @override
  List<Object> get props => [movies];
}
class MoviesTabError extends MoviesTabState {
  final HashMap movies;
  final String error;
  final Equatable event;

  const MoviesTabError({
    required this.movies,
    required this.error,
    required this.event,
  }) : super(movies: movies);

  @override
  List<Object> get props => [movies, error, event];
}

class MoviesTabLoaded extends MoviesTabState {
  final HashMap movies;

  const MoviesTabLoaded({required this.movies}) : super(movies: movies);

  @override
  List<Object> get props => [movies];
}

class MoviesTabReloading extends MoviesTabLoaded {
  final HashMap movies;

  const MoviesTabReloading({required this.movies}) : super(movies: movies);

  @override
  List<Object> get props => [movies];
}

