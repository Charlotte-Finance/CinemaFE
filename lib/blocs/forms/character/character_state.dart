part of 'character_bloc.dart';

abstract class CharacterState extends Equatable {
  const CharacterState();
}

class CharacterEmpty extends CharacterState {
  @override
  List<Object> get props => [];
}

class CharacterActionSent extends CharacterState {
  final String message;
  final bool succeed;

  const CharacterActionSent({
    required this.message,
    required this.succeed,
  });

  @override
  List<Object> get props => [message, succeed];
}

class CharacterAdded extends CharacterActionSent {
  final Character character;
  final String message;
  final bool succeed;

  const CharacterAdded({
    required this.character, required this.message,required this.succeed,
  }) : super(message:message, succeed:succeed) ;

  @override
  List<Object> get props => [character, message, succeed];
}


class CharacterDeleted extends CharacterActionSent {
  final Character character;
  final String message;
  final bool succeed;

  const CharacterDeleted({
    required this.character, required this.message,required this.succeed,
  }) : super(message:message, succeed:succeed) ;

  @override
  List<Object> get props => [character, message, succeed];
}
