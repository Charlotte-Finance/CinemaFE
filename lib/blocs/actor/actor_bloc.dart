import 'package:bloc/bloc.dart';
import 'package:cinema_fe/models/actor.dart';
import 'package:cinema_fe/repositories/actor_repository.dart';
import 'package:equatable/equatable.dart';

part 'actor_event.dart';
part 'actor_state.dart';

class ActorBloc extends Bloc<ActorEvent, ActorState> {
  final ActorRepository actorRepository = ActorRepository();

  ActorBloc() : super(ActorEmpty());

  @override
  Stream<ActorState> mapEventToState(
    ActorEvent event,
  ) async* {
    if (event is AddActor) {
      yield* _mapAddActor(event);
    }
    if (event is DeleteActor) {
      yield* _mapDeleteActor(event);
    }
  }

  Stream<ActorState> _mapAddActor(AddActor event) async* {
    try {
      await actorRepository.post(event.actor);
      yield ActorEmpty();
    } catch (_) {
      yield ActorError(
        error: "Something went wrong...",
        event: event,
      );
    }
  }

  Stream<ActorState> _mapDeleteActor(DeleteActor event) async* {
    try {
      await actorRepository.delete(event.actor);
      yield ActorEmpty();
    } catch (_) {
      yield ActorError(
        error: "Something went wrong...",
        event: event,
      );
    }
  }
}
