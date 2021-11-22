part of 'movies_tab_bloc.dart';

abstract class MoviesTabState extends Equatable {
  const MoviesTabState();
}

class MoviesTabEmpty extends MoviesTabState {
  @override
  List<Object> get props => [];
}

class MoviesTabLoading extends MoviesTabState {
  @override
  List<Object> get props => [];
}

class MoviesTabLoaded extends MoviesTabState {
  final HashMap movies;

  const MoviesTabLoaded({required this.movies});

  @override
  List<Object> get props => [movies];
}

class DescriptionLoaded extends MoviesTabState {
  final HashMap movies;
  final Movie movie;

  const DescriptionLoaded({
    required this.movies,
    required this.movie,
  });

  @override
  List<Object> get props => [
        movies,
        movie,
      ];
}

class EditForm extends MoviesTabState {
  final HashMap movies;
  final Movie movie;

  const EditForm({
    required this.movies,
    required this.movie,
  });

  @override
  List<Object> get props => [
        movies,
        movie,
      ];
}

class EditMovieForm extends EditForm {
  final HashMap movies;
  final Movie movie;
  final List<Director> directors;
  final List<Category> categories;

  const EditMovieForm({
    required this.movies,
    required this.movie,
    required this.directors,
    required this.categories,
  }) : super(movies: movies, movie: movie);

  @override
  List<Object> get props => [
        movies,
        movie,
        directors,
        categories,
      ];
}

class EditActorForm extends EditForm {
  final HashMap movies;
  final Movie movie;
  final Actor actor;

  const EditActorForm(
      {required this.movies, required this.movie, required this.actor})
      : super(movies: movies, movie: movie);

  @override
  List<Object> get props => [
        movies,
        movie,
        actor,
      ];
}

class EditCharacterForm extends EditForm {
  final HashMap movies;
  final Movie movie;
  final Character character;
  final List<Actor> actors;
  final List<Movie> allMovies;

  const EditCharacterForm({
    required this.movies,
    required this.movie,
    required this.character,
    required this.actors,
    required this.allMovies,
  }) : super(movies: movies, movie: movie);

  @override
  List<Object> get props => [
        movies,
        movie,
        character,
        actors,
    allMovies,
      ];
}

class EditDirectorForm extends EditForm {
  final HashMap movies;
  final Movie movie;
  final Director director;

  const EditDirectorForm({
    required this.movies,
    required this.movie,
    required this.director,
  }) : super(movies: movies, movie: movie);

  @override
  List<Object> get props => [
        movies,
        movie,
        director,
      ];
}

class MoviesTabError extends MoviesTabState {
  final String error;
  final Equatable event;

  const MoviesTabError({
    required this.error,
    required this.event,
  });

  @override
  List<Object> get props => [error, event];
}
