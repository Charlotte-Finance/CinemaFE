part of 'actor_bloc.dart';


abstract class ActorState extends Equatable {
  const ActorState();
}

class ActorEmpty extends ActorState {
  @override
  List<Object> get props => [];
}

class ActorLoading extends ActorState {
  @override
  List<Object> get props => [];
}

class ActorLoaded extends ActorState {
  final Actor actor;

  const ActorLoaded({required this.actor});

  @override
  List<Object> get props => [actor];
}


class ActorError extends ActorState {
  final String error;
  final Equatable event;

  const ActorError({
    required this.error,
    required this.event,
  });

  @override
  List<Object> get props => [error, event];
}
