part of 'actor_bloc.dart';

abstract class ActorState extends Equatable {
  const ActorState();
}

class ActorEmpty extends ActorState {
  @override
  List<Object> get props => [];
}

class ActorActionSent extends ActorState {
  final String message;
  final bool succeed;

  const ActorActionSent({
    required this.message,
    required this.succeed,
  });

  @override
  List<Object> get props => [message, succeed];
}

class ActorAdded extends ActorActionSent {
  final Actor actor;
  final String message;
  final bool succeed;

  const ActorAdded({
    required this.actor, required this.message,required this.succeed,
  }) : super(message:message, succeed:succeed) ;

  @override
  List<Object> get props => [actor, message, succeed];
}


class ActorDeleted extends ActorActionSent {
  final Actor actor;
  final String message;
  final bool succeed;

  const ActorDeleted({
    required this.actor, required this.message,required this.succeed,
  }) : super(message:message, succeed:succeed) ;

  @override
  List<Object> get props => [actor, message, succeed];
}
