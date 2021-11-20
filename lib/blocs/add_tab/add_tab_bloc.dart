import 'package:bloc/bloc.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/repositories/movie_repository.dart';
import 'package:equatable/equatable.dart';

part 'add_tab_event.dart';

part 'add_tab_state.dart';

class AddTabBloc extends Bloc<AddTabEvent, AddTabState> {
  final MovieRepository movieRepository = MovieRepository();

  AddTabBloc() : super(AddTabLoaded());

  @override
  Stream<AddTabState> mapEventToState(
    AddTabEvent event,
  ) async* {
    if (event is GetMovieForm) {
      yield* _mapGetMovieForm(event);
    }
    if (event is AddMovie) {
      yield* _mapAddMovie(event);
    }
    if (event is GetActorForm) {
      yield* _mapGetActorForm(event);
    }
    if (event is AddActor) {
      yield* _mapAddActor(event);
    }
    if (event is GetCharacterForm) {
      yield* _mapGetCharacterForm(event);
    }
    if (event is AddCharacter) {
      yield* _mapAddCharacter(event);
    }
  }

  Stream<AddTabState> _mapGetMovieForm(GetMovieForm event) async* {
    yield AddTabLoading();
    try {
      yield MovieForm();
    } catch (_) {
      yield AddTabError(
        error: "Something went wrong...",
        event: event,
      );
    }
  }
  Stream<AddTabState> _mapAddMovie(AddMovie event) async* {
    yield AddTabLoading();
    try {
      yield AddTabLoaded();
    } catch (_) {
      yield AddTabError(
        error: "Something went wrong...",
        event: event,
      );
    }
  }

  Stream<AddTabState> _mapGetActorForm(GetActorForm event) async* {
    yield AddTabLoading();
    try {
      yield ActorForm();
    } catch (_) {
      yield AddTabError(
        error: "Something went wrong...",
        event: event,
      );
    }
  }
  Stream<AddTabState> _mapAddActor(AddActor event) async* {
    yield AddTabLoading();
    try {
      yield AddTabLoaded();
    } catch (_) {
      yield AddTabError(
        error: "Something went wrong...",
        event: event,
      );
    }
  }
  Stream<AddTabState> _mapGetCharacterForm(GetCharacterForm event) async* {
    yield AddTabLoading();
    try {
      yield CharacterForm();
    } catch (_) {
      yield AddTabError(
        error: "Something went wrong...",
        event: event,
      );
    }
  }
  Stream<AddTabState> _mapAddCharacter(AddCharacter event) async* {
    yield AddTabLoading();
    try {
      yield AddTabLoaded();
    } catch (_) {
      yield AddTabError(
        error: "Something went wrong...",
        event: event,
      );
    }
  }
}
