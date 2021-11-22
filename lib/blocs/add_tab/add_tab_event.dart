part of 'add_tab_bloc.dart';

abstract class AddTabEvent extends Equatable {
  const AddTabEvent();
}

class GetMovieForm extends AddTabEvent {
  @override
  List<Object> get props => [];
}

class AddMovie extends AddTabEvent {
  final Movie movie;

  const AddMovie({required this.movie});

  @override
  List<Object> get props => [movie];
}

class GetCharacterForm extends AddTabEvent {
  @override
  List<Object> get props => [];
}

class AddCharacter extends AddTabEvent {
  final Character character;

  const AddCharacter(
      {required this.character});

  @override
  List<Object> get props => [character];
}

class GetActorForm extends AddTabEvent {
  @override
  List<Object> get props => [];
}

class AddActor extends AddTabEvent {
  final Actor actor;

  const AddActor({
    required this.actor,
  });

  @override
  List<Object?> get props => [actor];
}

class GetDirectorForm extends AddTabEvent {
  @override
  List<Object> get props => [];
}

class AddDirector extends AddTabEvent {
  final Director director;

  const AddDirector({
    required this.director
  });

  @override
  List<Object> get props => [
    director
      ];
}

class GoBack extends AddTabEvent {
  @override
  List<Object> get props => [];
}
