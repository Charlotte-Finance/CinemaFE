part of 'forms_bloc.dart';

abstract class FormsEvent extends Equatable {
  const FormsEvent();
}

class GetMovieForm extends FormsEvent {
  final Movie movie;

  const GetMovieForm(
      {required this.movie});

  @override
  List<Object> get props => [movie];
}


class GetActorForm extends FormsEvent {
  final Actor actor;

  const GetActorForm(
      {required this.actor});

  @override
  List<Object> get props => [actor];
}

class GetCharacterForm extends FormsEvent {
  final Character character;

  const GetCharacterForm(
      {required this.character});

  @override
  List<Object> get props => [character];
}


class GetDirectorForm extends FormsEvent {
  final Director director;

  const GetDirectorForm(
      {required this.director});

  @override
  List<Object> get props => [director];
}

