import 'package:bloc/bloc.dart';
import 'package:cinema_fe/models/director.dart';
import 'package:cinema_fe/repositories/director_repository.dart';
import 'package:equatable/equatable.dart';

part 'director_event.dart';
part 'director_state.dart';

class DirectorBloc extends Bloc<DirectorEvent, DirectorState> {
  final DirectorRepository directorRepository = DirectorRepository();

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
  }

  Stream<DirectorState> _mapAddDirector(AddDirector event) async* {
    try {
      await directorRepository.post(event.director);
      yield DirectorEmpty();
    } catch (_) {
      yield DirectorError(
        error: "Something went wrong...",
        event: event,
      );
    }
  }


  Stream<DirectorState> _mapDeleteDirector(DeleteDirector event) async* {
    try {
      await directorRepository.delete(event.director);
      yield DirectorEmpty();
    } catch (_) {
      yield DirectorError(
        error: "Something went wrong...",
        event: event,
      );
    }
  }
}
