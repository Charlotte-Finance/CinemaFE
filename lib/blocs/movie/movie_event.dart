part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();
}

class FetchLike extends MovieEvent {
  final Movie movie;

  const FetchLike({
    required this.movie,
  });

  @override
  List<Object> get props => [movie];
}

class LikeMovie extends MovieEvent {
  final Movie movie;
  final bool liked;

  const LikeMovie({required this.movie, required this.liked});

  @override
  List<Object> get props => [movie, liked];
}
