part of 'movie_card_bloc.dart';

abstract class MovieCardEvent extends Equatable {
  const MovieCardEvent();
}

class FetchLike extends MovieCardEvent {
  final User user;
  final Movie movie;

  const FetchLike({
    required this.user,
    required this.movie,
  });

  @override
  List<Object> get props => [user, movie];
}

class LikeMovie extends MovieCardEvent {
  final User user;
  final Movie movie;
  final bool isLiked;

  const LikeMovie({
    required this.user,
    required this.movie,
    required this.isLiked,
  });

  @override
  List<Object> get props => [user, movie, isLiked];
}
