part of 'movie_bloc.dart';


abstract class MovieState extends Equatable {
  const MovieState();
}

class MovieEmpty extends MovieState {
  @override
  List<Object> get props => [];
}

class MovieLoading extends MovieState {
  @override
  List<Object> get props => [];
}

class MovieLoaded extends MovieState {
  final Movie movie;
  final bool isLiked;

  const MovieLoaded({required this.movie, required this.isLiked});

  @override
  List<Object> get props => [movie, isLiked];
}

class MovieError extends MovieState {
  final String error;
  final Equatable event;

  const MovieError({
    required this.error,
    required this.event,
  });

  @override
  List<Object> get props => [error, event];
}
