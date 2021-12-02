part of 'director_description_bloc.dart';

abstract class DirectorDescriptionState extends Equatable {
  final List<Movie> movies;

  const DirectorDescriptionState({required this.movies});

  @override
  List<Object> get props => [movies];
}

class DirectorDescriptionEmpty extends DirectorDescriptionState {
  final List<Movie> movies;

  const DirectorDescriptionEmpty({required this.movies}) : super(movies:movies);

  @override
  List<Object> get props => [movies];
}



class DirectorDescriptionLoaded extends DirectorDescriptionState {
  final List<Movie> movies;

  const DirectorDescriptionLoaded({required this.movies}): super(movies:movies);

  @override
  List<Object> get props => [movies];
}

class DirectorDescriptionReloading extends DirectorDescriptionLoaded {
  final List<Movie> movies;

  const DirectorDescriptionReloading({required this.movies}) : super(movies: movies);

  @override
  List<Object> get props => [movies];
}

class DirectorDescriptionError extends DirectorDescriptionState {
  final String error;
  final Equatable event;
  final List<Movie> movies;
  const DirectorDescriptionError({
    required this.error,
    required this.event,
    required this.movies,
  }): super(movies:movies);

  @override
  List<Object> get props => [error, event, movies];
}
