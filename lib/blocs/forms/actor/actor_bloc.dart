import 'package:bloc/bloc.dart';
import 'package:cinema_fe/models/actor.dart';
import 'package:cinema_fe/repositories/like_repository.dart';
import 'package:cinema_fe/repositories/actor_repository.dart';
import 'package:cinema_fe/utils/texts.dart';
import 'package:equatable/equatable.dart';

part 'actor_event.dart';

part 'actor_state.dart';

class ActorBloc extends Bloc<ActorEvent, ActorState> {
  final ActorRepository actorRepository = ActorRepository();
  final LikeRepository likeRepository = LikeRepository();

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
    if (event is ResetActor) {
      yield ActorEmpty();
    }
  }

  Stream<ActorState> _mapAddActor(AddActor event) async* {
    try {
      Actor actor = await actorRepository.post(event.actor);
      yield ActorAdded(
        actor: actor,
        succeed: true,
        message: addToastStr(
          event.actor,
          event.actor.id,
          true,
        ),
      );
    } catch (_) {
      yield ActorActionSent(
        succeed: false,
        message: addToastStr(
          event.actor,
          event.actor.id,
          false,
        ),
      );
    }
  }

  Stream<ActorState> _mapDeleteActor(DeleteActor event) async* {
    try {
      await actorRepository.delete(event.actor);
      yield ActorDeleted(
        actor: event.actor,
        succeed: true,
        message: deleteToastStr(
          event.actor,
          true,
        ),
      );
    } catch (_) {
      yield ActorActionSent(
        succeed: false,
        message: deleteToastStr(
          event.actor,
          false,
        ),
      );
    }
  }
}
