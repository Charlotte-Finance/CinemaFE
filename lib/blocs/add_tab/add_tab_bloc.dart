import 'package:bloc/bloc.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/repositories/movie_repository.dart';
import 'package:equatable/equatable.dart';

part 'more_event.dart';

part 'more_state.dart';

class MoreBloc extends Bloc<MoreEvent, MoreState> {
  final MovieRepository movieRepository = MovieRepository();

  MoreBloc() : super(MoreLoaded());

  @override
  Stream<MoreState> mapEventToState(
    MoreEvent event,
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

  Stream<MoreState> _mapGetMovieForm(GetMovieForm event) async* {
    yield MoreLoading();
    try {
      yield MovieForm();
    } catch (_) {
      yield MoreError(
        error: "Something went wrong...",
        event: event,
      );
    }
  }
  Stream<MoreState> _mapAddMovie(AddMovie event) async* {
    yield MoreLoading();
    try {
      yield MoreLoaded();
    } catch (_) {
      yield MoreError(
        error: "Something went wrong...",
        event: event,
      );
    }
  }

  Stream<MoreState> _mapGetActorForm(GetActorForm event) async* {
    yield MoreLoading();
    try {
      yield ActorForm();
    } catch (_) {
      yield MoreError(
        error: "Something went wrong...",
        event: event,
      );
    }
  }
  Stream<MoreState> _mapAddActor(AddActor event) async* {
    yield MoreLoading();
    try {
      yield MoreLoaded();
    } catch (_) {
      yield MoreError(
        error: "Something went wrong...",
        event: event,
      );
    }
  }
  Stream<MoreState> _mapGetCharacterForm(GetCharacterForm event) async* {
    yield MoreLoading();
    try {
      yield CharacterForm();
    } catch (_) {
      yield MoreError(
        error: "Something went wrong...",
        event: event,
      );
    }
  }
  Stream<MoreState> _mapAddCharacter(AddCharacter event) async* {
    yield MoreLoading();
    try {
      yield MoreLoaded();
    } catch (_) {
      yield MoreError(
        error: "Something went wrong...",
        event: event,
      );
    }
  }
}
