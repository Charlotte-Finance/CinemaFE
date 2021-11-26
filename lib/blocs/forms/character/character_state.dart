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
