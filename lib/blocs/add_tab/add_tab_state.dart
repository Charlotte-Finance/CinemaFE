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

class MovieForm extends AddTabState {
  @override
  List<Object> get props => [];
}

class ActorForm extends AddTabState {
  @override
  List<Object> get props => [];
}

class CharacterForm extends AddTabState {
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
