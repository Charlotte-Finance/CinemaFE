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
