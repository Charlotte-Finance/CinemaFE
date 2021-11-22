import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:cinema_fe/models/actor.dart';
import 'package:cinema_fe/models/category.dart';
import 'package:cinema_fe/models/character.dart';
import 'package:cinema_fe/models/director.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/repositories/category_repository.dart';
import 'package:cinema_fe/repositories/movie_repository.dart';
import 'package:equatable/equatable.dart';

part 'movies_tab_event.dart';
part 'movies_tab_state.dart';

class MoviesTabBloc extends Bloc<MoviesTabEvent, MoviesTabState> {
  final MovieRepository movieRepository = MovieRepository();
  final CategoryRepository categoryRepository = CategoryRepository();

  MoviesTabBloc() : super(MoviesTabEmpty());

  @override
  Stream<MoviesTabState> mapEventToState(
    MoviesTabEvent event,
  ) async* {
    if (event is GetMovies) {
      yield* _mapGetMovies(event);
    }
    if (event is FetchDescription) {
      yield* _mapFetchDescription(event);
    }
    if (event is GoBackMovies) {
      yield MoviesTabLoaded(movies: event.movies);
    }
    if (event is GoBackMovie) {
      yield DescriptionLoaded(
        movies: event.movies,
        movie: event.movie,
      );
    }
    if (event is FetchMovieForm) {
      yield* _mapFetchMovieForm(event);
    }
    if (event is EditMovie) {
      yield* _mapEditMovie(event);
    }
    if (event is DeleteMovie) {
      yield* _mapDeleteMovie(event);
    }
    if (event is FetchActorForm) {
      yield* _mapFetchActorForm(event);
    }
    if (event is EditActor) {
      yield* _mapEditActor(event);
    }
    if (event is DeleteActor) {
      yield* _mapDeleteActor(event);
    }
    if (event is FetchCharacterForm) {
      yield* _mapFetchCharacterForm(event);
    }
    if (event is EditCharacter) {
      yield* _mapEditCharacter(event);
    }
    if (event is DeleteCharacter) {
      yield* _mapDeleteCharacter(event);
    }
    if (event is FetchDirectorForm) {
      yield* _mapFetchDirectorForm(event);
    }
    if (event is EditDirector) {
      yield* _mapEditDirector(event);
    }
    if (event is DeleteDirector) {
      yield* _mapDeleteDirector(event);
    }
  }

  Stream<MoviesTabState> _mapGetMovies(GetMovies event) async* {
    yield MoviesTabLoading();
    try {
      List<Category> categories = await categoryRepository.getCategories();
      HashMap movies = HashMap<Category, List<Movie>>();
      for (Category category in categories){
        List<Movie> moviesCategory = await movieRepository.getMoviesByCategory(category);
        movies.putIfAbsent(category, () => moviesCategory);
      }



      yield MoviesTabLoaded(movies: movies);
    } catch (_) {
      print(_);
      yield MoviesTabError(
        error: "Something went wrong...",
        event: event,
      );
    }
  }

  Stream<MoviesTabState> _mapFetchDescription(FetchDescription event) async* {
    yield MoviesTabLoading();
    try {
      // List<Actor> actors = await actorRepository.getByMovie(event.movie);
      // List<Character> characters = await characterRepository.getByMovie(event.movie);
      // Director director = await directorRepository.getDirector(event.movie.directorId);
      // Category category = await categoryRepository.getCategory(event.movie.categoryCode);

      List<Actor> actors = [
        Actor(
          id: 1,
          name: "Dujardin",
          firstname: "Jean",
          birth: DateTime.now(),
          death: null,
        ),
        Actor(
          id: 2,
          name: "Dicaprio",
          firstname: "Leonardo",
          birth: DateTime.now(),
          death: null,
        ),
      ];
      List<Character> characters = [
        Character(id: 1, actorId: 1, movieId: 1, name: "Le joker"),
        Character(id: 2, actorId: 2, movieId: 1, name: "Batman"),
      ];
      Director director = Director(id: 1, name: "Besson", firstname: "Luc");
      Category category = Category(code: "AC", label: "action", picture: "");
      //await likeRepository.changeLike(event.user, event.movie);
      event.movie.category = category;
      event.movie.director = director;
      event.movie.actors = actors;
      event.movie.characters = characters;
      yield DescriptionLoaded(
        movies: event.movies,
        movie: event.movie,
      );
    } catch (_) {
      yield MoviesTabError(
        error: "Something went wrong...",
        event: event,
      );
    }
  }

  Stream<MoviesTabState> _mapFetchMovieForm(FetchMovieForm event) async* {
    yield MoviesTabLoading();
    try {
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
      //Director director = directorRepository.getDirector(event.movie.directorId);
      //Category category = categoryRepository.getCategory(event.movie.categoryCode);
      Director director =
          Director(id: 1, name: "Tarantino", firstname: "Quentin");
      Category category =
          Category(code: "HR", label: "Horror", picture: "None");
      event.movie.director = director;
      event.movie.category = category;
      yield EditMovieForm(
        movies: event.movies,
        movie: event.movie,
        directors: directors,
        categories: categories,
      );
    } catch (_) {
      yield MoviesTabError(
        error: "Something went wrong...",
        event: event,
      );
    }
  }

  Stream<MoviesTabState> _mapEditMovie(EditMovie event) async* {
    yield MoviesTabLoading();
    try {
      //await movieRepository.put(event.movie);
      yield MoviesTabEmpty();
    } catch (_) {
      yield MoviesTabError(
        error: "Something went wrong...",
        event: event,
      );
    }
  }

  Stream<MoviesTabState> _mapDeleteMovie(DeleteMovie event) async* {
    yield MoviesTabLoading();
    try {
      //await movieRepository.delete(event.movie);
      yield MoviesTabEmpty();
    } catch (_) {
      yield MoviesTabError(
        error: "Something went wrong...",
        event: event,
      );
    }
  }

  Stream<MoviesTabState> _mapFetchActorForm(FetchActorForm event) async* {
    yield MoviesTabLoading();
    try {
      yield EditActorForm(
        movies: event.movies,
        movie: event.movie,
        actor: event.actor,
      );
    } catch (_) {
      yield MoviesTabError(
        error: "Something went wrong...",
        event: event,
      );
    }
  }

  Stream<MoviesTabState> _mapEditActor(EditActor event) async* {
    yield MoviesTabLoading();
    try {
      //await actorRepository.put(event.actor);
      yield MoviesTabEmpty();
    } catch (_) {
      yield MoviesTabError(
        error: "Something went wrong...",
        event: event,
      );
    }
  }

  Stream<MoviesTabState> _mapDeleteActor(DeleteActor event) async* {
    yield MoviesTabLoading();
    try {
      //await actorRepository.delete(event.actor);
      yield MoviesTabEmpty();
    } catch (_) {
      yield MoviesTabError(
        error: "Something went wrong...",
        event: event,
      );
    }
  }

  Stream<MoviesTabState> _mapFetchCharacterForm(
      FetchCharacterForm event) async* {
    yield MoviesTabLoading();
    try {
      List<Movie> allMovies = await movieRepository.getMovies();


      // List<Actor> actors = await actorRepository.getByMovie(event.movie);
      // Actor actor = await actorRepository.getActor(event.character.actorId);

      // Movie movie = await movieRepository.getMovie(event.character.movieId);

      List<Actor> actors = [
        Actor(
          id: 1,
          name: "Dujardin",
          firstname: "Jean",
          birth: DateTime.now(),
          death: null,
        ),
        Actor(
          id: 2,
          name: "Dicaprio",
          firstname: "Leonardo",
          birth: DateTime.now(),
          death: null,
        ),
      ];
      Actor actor = actors[0];
      Movie movie = allMovies[0];
      event.character.actor = actor;
      event.character.movie = movie;
      yield EditCharacterForm(
        movies: event.movies,
        actors: actors,
        character: event.character,
        allMovies: allMovies,
        movie: event.movie,
      );
    } catch (_) {
      yield MoviesTabError(
        error: "Something went wrong...",
        event: event,
      );
    }
  }

  Stream<MoviesTabState> _mapEditCharacter(EditCharacter event) async* {
    yield MoviesTabLoading();
    try {
      //await characterRepository.put(event.character);
      yield MoviesTabEmpty();
    } catch (_) {
      yield MoviesTabError(
        error: "Something went wrong...",
        event: event,
      );
    }
  }

  Stream<MoviesTabState> _mapDeleteCharacter(DeleteCharacter event) async* {
    yield MoviesTabLoading();
    try {
      //await characterRepository.delete(event.character);
      yield MoviesTabEmpty();
    } catch (_) {
      yield MoviesTabError(
        error: "Something went wrong...",
        event: event,
      );
    }
  }

  Stream<MoviesTabState> _mapFetchDirectorForm(FetchDirectorForm event) async* {
    yield MoviesTabLoading();
    try {
      yield EditDirectorForm(
        movies: event.movies,
        movie: event.movie,
        director: event.director,
      );
    } catch (_) {
      yield MoviesTabError(
        error: "Something went wrong...",
        event: event,
      );
    }
  }

  Stream<MoviesTabState> _mapEditDirector(EditDirector event) async* {
    yield MoviesTabLoading();
    try {
      //await directorRepository.put(event.director);
      yield MoviesTabEmpty();
    } catch (_) {
      yield MoviesTabError(
        error: "Something went wrong...",
        event: event,
      );
    }
  }

  Stream<MoviesTabState> _mapDeleteDirector(DeleteDirector event) async* {
    yield MoviesTabLoading();
    try {
      //await directorRepository.delete(event.director);
      yield MoviesTabEmpty();
    } catch (_) {
      yield MoviesTabError(
        error: "Something went wrong...",
        event: event,
      );
    }
  }
}
