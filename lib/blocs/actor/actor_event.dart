part of 'actor_bloc.dart';

abstract class ActorEvent extends Equatable {
  const ActorEvent();
}

class AddActor extends ActorEvent {
  final Actor actor;

  const AddActor(
      {required this.actor});

  @override
  List<Object> get props => [actor];
}

class DeleteActor extends ActorEvent {
  final Actor actor;

  const DeleteActor({
    required this.actor,
  });

  @override
  List<Object> get props => [
    actor,
  ];
}