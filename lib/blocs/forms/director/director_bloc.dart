import 'package:bloc/bloc.dart';
import 'package:cinema_fe/models/director.dart';
import 'package:cinema_fe/repositories/like_repository.dart';
import 'package:cinema_fe/repositories/director_repository.dart';
import 'package:cinema_fe/utils/texts.dart';
import 'package:equatable/equatable.dart';

part 'director_event.dart';

part 'director_state.dart';

class DirectorBloc extends Bloc<DirectorEvent, DirectorState> {
  final DirectorRepository directorRepository = DirectorRepository();
  final LikeRepository likeRepository = LikeRepository();

  DirectorBloc() : super(DirectorEmpty());

  @override
  Stream<DirectorState> mapEventToState(
      DirectorEvent event,
      ) async* {
    if (event is AddDirector) {
      yield* _mapAddDirector(event);
    }
    if (event is DeleteDirector) {
      yield* _mapDeleteDirector(event);
    }
    if (event is ResetDirector) {
      yield DirectorEmpty();
    }
  }

  Stream<DirectorState> _mapAddDirector(AddDirector event) async* {
    try {
      Director director = await directorRepository.post(event.director);
      yield DirectorAdded(
        director: director,
        succeed: true,
        message: addToastStr(
          event.director,
          event.director.id,
          true,
        ),
      );
    } catch (_) {
      yield DirectorActionSent(
        succeed: false,
        message: addToastStr(
          event.director,
          event.director.id,
          false,
        ),
      );
    }
  }

  Stream<DirectorState> _mapDeleteDirector(DeleteDirector event) async* {
    try {
      await directorRepository.delete(event.director);
      yield DirectorDeleted(
        director: event.director,
        succeed: true,
        message: deleteToastStr(
          event.director,
          true,
        ),
      );
    } catch (_) {
      yield DirectorActionSent(
        succeed: false,
        message: deleteToastStr(
          event.director,
          false,
        ),
      );
    }
  }
}
