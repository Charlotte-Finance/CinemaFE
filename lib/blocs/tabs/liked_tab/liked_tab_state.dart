part of 'liked_tab_bloc.dart';

abstract class LikedTabState extends Equatable {
  final List<Movie> movies;

  const LikedTabState({required this.movies});

  @override
  List<Object> get props => [movies];
}

class LikedTabEmpty extends LikedTabState {
  final List<Movie> movies;

  const LikedTabEmpty({required this.movies}) : super(movies: movies);

  @override
  List<Object> get props => [];
}

class LikedTabLoaded extends LikedTabState {
  final List<Movie> movies;

  const LikedTabLoaded({required this.movies}) : super(movies:movies);

  @override
  List<Object> get props => [movies];
}

class LikedTabError extends LikedTabState {
  final List<Movie> movies;
  final String error;
  final Equatable event;

  const LikedTabError({
    required this.movies,
    required this.error,
    required this.event,
  }): super(movies:movies);

  @override
  List<Object> get props => [movies, error, event];
}
