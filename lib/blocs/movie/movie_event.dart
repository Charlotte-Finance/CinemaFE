part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();
}

class FetchLike extends MovieEvent {
  final User user;
  final Movie movie;

  const FetchLike({
    required this.user,
    required this.movie,
  });

  @override
  List<Object> get props => [movie];
}

class LikeMovieWhenLoaded extends MovieEvent {
  final User user;
  final Movie movie;
  final bool isLiked;

  const LikeMovieWhenLoaded({
    required this.user,
    required this.movie,
    required this.isLiked,
  });

  @override
  List<Object> get props => [
        user,
        movie,
        isLiked,
      ];
}
