part of 'forms_bloc.dart';

abstract class FormsState extends Equatable {
  const FormsState();
}

class FormEmpty extends FormsState {
  @override
  List<Object> get props => [];
}



class FormLoaded extends FormsState {
  @override
  List<Object> get props => [];
}

class MovieFormState extends FormsState {
  final Movie movie;
  final List<Director> directors;
  final List<Category> categories;

  const MovieFormState({
    required this.movie,
    required this.directors,
    required this.categories,
  });

  @override
  List<Object> get props => [
        movie,
        directors,
        categories,
      ];
}

class ActorFormState extends FormsState {
  final Actor actor;

  const ActorFormState({required this.actor});

  @override
  List<Object> get props => [actor];
}

class CharacterFormState extends FormsState {
  final Character character;
  final List<Actor> actors;
  final List<Movie> movies;

  const CharacterFormState({
    required this.character,
    required this.actors,
    required this.movies,
  });

  @override
  List<Object> get props => [
        character,
        actors,
        movies,
      ];
}

class DirectorFormState extends FormsState {
  final Director director;

  const DirectorFormState({required this.director});

  @override
  List<Object> get props => [director];
}

class FormError extends FormsState {
  final String error;
  final Equatable event;

  const FormError({
    required this.error,
    required this.event,
  });

  @override
  List<Object> get props => [error, event];
}
