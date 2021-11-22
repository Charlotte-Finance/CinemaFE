part of 'add_tab_bloc.dart';

abstract class AddTabState extends Equatable {
  const AddTabState();
}

class AddTabLoading extends AddTabState {
  @override
  List<Object> get props => [];
}

class AddTabLoaded extends AddTabState {
  @override
  List<Object> get props => [];
}

class MovieFormState extends AddTabState {
  final List<Director> directors;
  final List<Category> categories;

  const MovieFormState({
    required this.directors,
    required this.categories,
  });

  @override
  List<Object> get props => [
        directors,
        categories,
      ];
}

class ActorFormState extends AddTabState {
  @override
  List<Object> get props => [];
}

class CharacterFormState extends AddTabState {
  final List<Actor> actors;
  final List<Movie> movies;

  const CharacterFormState({
    required this.actors,
    required this.movies,
  });

  @override
  List<Object> get props => [
        actors,
        movies,
      ];
}
class DirectorFormState extends AddTabState {
  @override
  List<Object> get props => [];
}
class AddTabError extends AddTabState {
  final String error;
  final Equatable event;

  const AddTabError({
    required this.error,
    required this.event,
  });

  @override
  List<Object> get props => [error, event];
}
