part of 'movie_description_bloc.dart';

abstract class MovieDescriptionEvent extends Equatable {
  const MovieDescriptionEvent();
}

class FetchMovieDescription extends MovieDescriptionEvent {
  final Movie movie;

  const FetchMovieDescription({
    required this.movie,
  });

  @override
  List<Object> get props => [
        movie,
      ];
}


class FetchLike extends MovieDescriptionEvent {
  final User user;
  final Movie movie;

  const FetchLike({
    required this.user,
    required this.movie,
  });

  @override
  List<Object> get props => [user, movie];
}

class LikeMovie extends MovieDescriptionEvent {
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

class UpdateActorDescription extends MovieDescriptionEvent {
  final Actor actor;

  const UpdateActorDescription({
    required this.actor,
  });

  @override
  List<Object> get props => [actor];
}

