part of 'movie_description_bloc.dart';

abstract class MovieDescriptionState extends Equatable {
  final Movie movie;

  const MovieDescriptionState({required this.movie});

  @override
  List<Object> get props => [movie];
}

class MovieDescriptionEmpty extends MovieDescriptionState {
  final Movie movie;

  const MovieDescriptionEmpty({required this.movie}) : super(movie:movie);

  @override
  List<Object> get props => [movie];
}



class MovieDescriptionLoaded extends MovieDescriptionState {
  final Movie movie;

  const MovieDescriptionLoaded({required this.movie}): super(movie:movie);

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
  final Movie movie;
  const MovieDescriptionError({
    required this.error,
    required this.event,
    required this.movie,
  }): super(movie:movie);

  @override
  List<Object> get props => [error, event, movie];
}
