part of 'character_bloc.dart';

abstract class CharacterEvent extends Equatable {
  const CharacterEvent();
}

class AddCharacter extends CharacterEvent {
  final Character character;

  const AddCharacter({required this.character});

  @override
  List<Object> get props => [character];
}

class DeleteCharacter extends CharacterEvent {
  final Character character;

  const DeleteCharacter({
    required this.character,
  });

  @override
  List<Object> get props => [character];
}

class ResetCharacter extends CharacterEvent {
  @override
  List<Object> get props => [];
}
