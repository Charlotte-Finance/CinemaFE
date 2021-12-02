part of 'actor_description_bloc.dart';

abstract class ActorDescriptionState extends Equatable {
  final List<Character> characters;

  const ActorDescriptionState({required this.characters});

  @override
  List<Object> get props => [characters];
}

class ActorDescriptionEmpty extends ActorDescriptionState {
  final List<Character> characters;

  const ActorDescriptionEmpty({required this.characters}) : super(characters:characters);

  @override
  List<Object> get props => [characters];
}



class ActorDescriptionLoaded extends ActorDescriptionState {
  final List<Character> characters;

  const ActorDescriptionLoaded({required this.characters}): super(characters:characters);

  @override
  List<Object> get props => [characters];
}

class ActorDescriptionReloading extends ActorDescriptionLoaded {
  final List<Character> characters;

  const ActorDescriptionReloading({required this.characters}) : super(characters: characters);

  @override
  List<Object> get props => [characters];
}

class ActorDescriptionError extends ActorDescriptionState {
  final String error;
  final Equatable event;
  final List<Character> characters;
  const ActorDescriptionError({
    required this.error,
    required this.event,
    required this.characters,
  }): super(characters:characters);

  @override
  List<Object> get props => [error, event, characters];
}
