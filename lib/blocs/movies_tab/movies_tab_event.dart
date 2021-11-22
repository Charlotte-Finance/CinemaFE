part of 'movies_tab_bloc.dart';

abstract class MoviesTabEvent extends Equatable {
  const MoviesTabEvent();
}

class GetMovies extends MoviesTabEvent {
  @override
  List<Object> get props => [];
}

class FetchDescription extends MoviesTabEvent {
  final HashMap movies;
  final Movie movie;

  const FetchDescription({
    required this.movies,
    required this.movie,
  });

  @override
  List<Object> get props => [
        movies,
        movie,
      ];
}

class GoBackMovies extends MoviesTabEvent {
  final HashMap movies;

  const GoBackMovies({
    required this.movies,
  });

  @override
  List<Object> get props => [
        movies,
      ];
}

class GoBackMovie extends MoviesTabEvent {
  final HashMap movies;
  final Movie movie;

  const GoBackMovie({
    required this.movies,
    required this.movie,
  });

  @override
  List<Object> get props => [
        movies,
        movie,
      ];
}

class FetchMovieForm extends MoviesTabEvent {
  final HashMap movies;
  final Movie movie;

  const FetchMovieForm({
    required this.movies,
    required this.movie,
  });

  @override
  List<Object> get props => [
        movies,
        movie,
      ];
}

class EditMovie extends MoviesTabEvent {
  final Movie movie;

  const EditMovie({
    required this.movie,
  });

  @override
  List<Object> get props => [
        movie,
      ];
}

class DeleteMovie extends MoviesTabEvent {
  final Movie movie;

  const DeleteMovie({
    required this.movie,
  });

  @override
  List<Object> get props => [
        movie,
      ];
}

class FetchActorForm extends MoviesTabEvent {
  final HashMap movies;
  final Movie movie;

  final Actor actor;

  const FetchActorForm({
    required this.movies,
    required this.movie,
    required this.actor,
  });

  @override
  List<Object> get props => [
        movies,
        actor,
      ];
}

class EditActor extends MoviesTabEvent {
  final Actor actor;

  const EditActor({
    required this.actor,
  });

  @override
  List<Object> get props => [
        actor,
      ];
}

class DeleteActor extends MoviesTabEvent {
  final Actor actor;

  const DeleteActor({
    required this.actor,
  });

  @override
  List<Object> get props => [
        actor,
      ];
}

class FetchCharacterForm extends MoviesTabEvent {
  final HashMap movies;
  final Movie movie;
  final Character character;

  const FetchCharacterForm({
    required this.movies,
    required this.movie,
    required this.character,
  });

  @override
  List<Object> get props => [
        movies,
        movie,
        character,
      ];
}

class EditCharacter extends MoviesTabEvent {
  final Character character;

  const EditCharacter({
    required this.character,
  });

  @override
  List<Object> get props => [
        character,
      ];
}

class DeleteCharacter extends MoviesTabEvent {
  final Character character;

  const DeleteCharacter({
    required this.character,
  });

  @override
  List<Object> get props => [
        character,
      ];
}

class FetchDirectorForm extends MoviesTabEvent {
  final HashMap movies;
  final Movie movie;
  final Director director;

  const FetchDirectorForm({
    required this.movies,
    required this.movie,
    required this.director,
  });

  @override
  List<Object> get props => [
        movies,
        movie,
        director,
      ];
}

class EditDirector extends MoviesTabEvent {
  final Director director;

  const EditDirector({
    required this.director,
  });

  @override
  List<Object> get props => [
        director,
      ];
}

class DeleteDirector extends MoviesTabEvent {
  final Director director;

  const DeleteDirector({
    required this.director,
  });

  @override
  List<Object> get props => [
        director,
      ];
}
