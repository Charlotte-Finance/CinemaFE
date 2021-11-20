part of 'more_bloc.dart';

abstract class MoreState extends Equatable {
  const MoreState();
}

class MoreLoading extends MoreState {
  @override
  List<Object> get props => [];
}

class MoreLoaded extends MoreState {
  @override
  List<Object> get props => [];
}

class MovieForm extends MoreState {
  @override
  List<Object> get props => [];
}

class ActorForm extends MoreState {
  @override
  List<Object> get props => [];
}

class CharacterForm extends MoreState {
  @override
  List<Object> get props => [];
}

class MoreError extends MoreState {
  final String error;
  final Equatable event;

  const MoreError({
    required this.error,
    required this.event,
  });

  @override
  List<Object> get props => [error, event];
}
