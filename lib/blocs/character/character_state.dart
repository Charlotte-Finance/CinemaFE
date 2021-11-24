part of 'character_bloc.dart';


abstract class CharacterState extends Equatable {
  const CharacterState();
}

class CharacterEmpty extends CharacterState {
  @override
  List<Object> get props => [];
}

class CharacterLoading extends CharacterState {
  @override
  List<Object> get props => [];
}

class CharacterSent extends CharacterState {
  final Character character;

  const CharacterSent({required this.character});

  @override
  List<Object> get props => [character];
}


class CharacterError extends CharacterState {
  final String error;
  final Equatable event;

  const CharacterError({
    required this.error,
    required this.event,
  });

  @override
  List<Object> get props => [error, event];
}
