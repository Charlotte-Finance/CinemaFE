part of 'movie_description_bloc.dart';

abstract class MovieDescriptionState extends Equatable {
  const MovieDescriptionState();
}

class MovieDescriptionEmpty extends MovieDescriptionState {
  @override
  List<Object> get props => [];
}

class MovieLikeLoaded extends MovieDescriptionState {
  final Movie movie;

  const MovieLikeLoaded({required this.movie});

  @override
  List<Object> get props => [movie];
}

class MovieDescriptionLoaded extends MovieDescriptionState {
  final Movie movie;

  const MovieDescriptionLoaded({required this.movie});

  @override
  List<Object> get props => [movie];
}

class MovieDescriptionReloading extends MovieDescriptionLoaded {
  final Movie movie;

  const MovieDescriptionReloading({required this.movie}) : super(movie: movie);

  @override
  List<Object> get props => [movie];
}

class MovieDescriptionError extends MovieDescriptionState {
  final String error;
  final Equatable event;

  const MovieDescriptionError({
    required this.error,
    required this.event,
  });

  @override
  List<Object> get props => [error, event];
}
