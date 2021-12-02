part of 'actor_description_bloc.dart';

abstract class ActorDescriptionEvent extends Equatable {
  const ActorDescriptionEvent();
}

class FetchActorDescription extends ActorDescriptionEvent {
  final Actor actor;

  const FetchActorDescription({
    required this.actor,
  });

  @override
  List<Object> get props => [
    actor,
      ];
}

class UpdateDescription extends ActorDescriptionEvent {

  @override
  List<Object> get props => [];
}

class RefreshDescription extends ActorDescriptionEvent {
  @override
  List<Object> get props => [];
}