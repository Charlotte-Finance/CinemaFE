import 'package:bloc/bloc.dart';
import 'package:cinema_fe/models/actor.dart';
import 'package:cinema_fe/models/category.dart';
import 'package:cinema_fe/models/character.dart';
import 'package:cinema_fe/models/director.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/repositories/actor_repository.dart';
import 'package:cinema_fe/repositories/category_repository.dart';
import 'package:cinema_fe/repositories/character_repository.dart';
import 'package:cinema_fe/repositories/director_repository.dart';
import 'package:cinema_fe/repositories/movie_repository.dart';
import 'package:equatable/equatable.dart';

part 'add_tab_event.dart';

part 'add_tab_state.dart';

class AddTabBloc extends Bloc<AddTabEvent, AddTabState> {
  final MovieRepository movieRepository = MovieRepository();
  final DirectorRepository directorRepository = DirectorRepository();
  final CategoryRepository categoryRepository = CategoryRepository();
  final ActorRepository actorRepository = ActorRepository();
  final CharacterRepository characterRepository = CharacterRepository();

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
    if (event is GetDirectorForm) {
      yield* _mapGetDirectorForm(event);
    }
    if (event is AddDirector) {
      yield* _mapAddDirector(event);
    }
    if (event is GoBack) {
      yield AddTabLoaded();
    }
  }

  Stream<AddTabState> _mapGetMovieForm(GetMovieForm event) async* {
    yield AddTabLoading();
    //List<Director> directors = await directorRepository.getDirectors();
    //List<Category> categories = await categoryRepository.getCategories();
    List<Category> categories = [
      Category(code: "AC", label: "Action", picture: "None"),
      Category(code: "HR", label: "Horror", picture: "None"),
    ];
    List<Director> directors = [
      Director(id: 1, name: "Tarantino", firstname: "Quentin"),
      Director(id: 2, name: "Besson", firstname: "Luc"),
    ];
    try {
      yield MovieFormState(directors: directors, categories: categories);
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
      //await movieRepository.post(movie);
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
      yield ActorFormState();
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
      //await actorRepository.post(actor);
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
      List<Actor> actors = await actorRepository.getActors();
      List<Movie> movies = await movieRepository.getMovies();

      yield CharacterFormState(actors: actors, movies: movies);
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
      //await characterRepository.post(character);
      yield AddTabLoaded();
    } catch (_) {
      yield AddTabError(
        error: "Something went wrong...",
        event: event,
      );
    }
  }

  Stream<AddTabState> _mapGetDirectorForm(GetDirectorForm event) async* {
    yield AddTabLoading();
    try {
      yield DirectorFormState();
    } catch (_) {
      yield AddTabError(
        error: "Something went wrong...",
        event: event,
      );
    }
  }

  Stream<AddTabState> _mapAddDirector(AddDirector event) async* {
    yield AddTabLoading();
    try {
      //await directorRepository.post(director);
      yield AddTabLoaded();
    } catch (_) {
      yield AddTabError(
        error: "Something went wrong...",
        event: event,
      );
    }
  }
}
