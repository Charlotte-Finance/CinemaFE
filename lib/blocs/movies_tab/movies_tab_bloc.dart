import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:cinema_fe/models/category.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/repositories/actor_repository.dart';
import 'package:cinema_fe/repositories/category_repository.dart';
import 'package:cinema_fe/repositories/director_repository.dart';
import 'package:cinema_fe/repositories/movie_repository.dart';
import 'package:equatable/equatable.dart';

part 'movies_tab_event.dart';
part 'movies_tab_state.dart';

class MoviesTabBloc extends Bloc<MoviesTabEvent, MoviesTabState> {
  final MovieRepository movieRepository = MovieRepository();
  final CategoryRepository categoryRepository = CategoryRepository();
  final DirectorRepository directorRepository = DirectorRepository();
  final ActorRepository actorRepository = ActorRepository();

  MoviesTabBloc()
      : super(MoviesTabEmpty(movies: HashMap<Category, List<Movie>>()));

  @override
  Stream<MoviesTabState> mapEventToState(
    MoviesTabEvent event,
  ) async* {
    if (event is GetMovies) {
      yield* _mapGetMovies(event);
    }
    if (event is AddMovieToList) {
      yield* _mapAddMovieToList(event);
    }
    if (event is EditMovie) {
      yield* _mapEditMovie(event);
    }
    if (event is RemoveMovieFromList) {
      yield* _mapRemoveMovieFromList(event);
    }
  }

  Stream<MoviesTabState> _mapGetMovies(GetMovies event) async* {
    try {
      List<Category> categories = await categoryRepository.getCategories();
      HashMap movies = HashMap<Category, List<Movie>>();
      for (Category category in categories) {
        List<Movie> moviesCategory =
            await movieRepository.getMoviesByCategory(category);
        movies.putIfAbsent(category, () => moviesCategory);
      }
      yield MoviesTabLoaded(movies: movies);
    } catch (_) {
      yield MoviesTabError(
        movies: HashMap<Category, List<Movie>>(),
        error: "Something went wrong...",
        event: event,
      );
    }
  }

  Stream<MoviesTabState> _mapAddMovieToList(AddMovieToList event) async* {
    yield MoviesTabReloading(movies: state.movies);
    try {
      for (Category categoryKey in state.movies.keys){
        if (categoryKey.code == event.movie.categoryCode){
          state.movies[categoryKey].add(event.movie);
        }
      }
      yield MoviesTabLoaded(movies: state.movies);
    } catch (_) {
      yield MoviesTabError(
        movies: HashMap<Category, List<Movie>>(),
        error: "Something went wrong...",
        event: GetMovies(),
      );
    }
  }
  Stream<MoviesTabState> _mapEditMovie(EditMovie event) async* {
    yield MoviesTabReloading(movies: state.movies);
    try {
      Movie? removeMovie;
      for (Category categoryKey in state.movies.keys){
        for (Movie movieValue in state.movies[categoryKey]){
          if (movieValue.id == event.movie.id && categoryKey.code != event.movie.categoryCode){
            removeMovie = movieValue;
          }
        }
        if (removeMovie != null) {
          state.movies[categoryKey].remove(removeMovie);
          for (Category categoryKey in state.movies.keys){
            if (categoryKey.code == event.movie.categoryCode){
              state.movies[categoryKey].add(event.movie);
            }
          }
        }
      }
      yield MoviesTabLoaded(movies: state.movies);
    } catch (_) {
      yield MoviesTabError(
        movies: HashMap<Category, List<Movie>>(),
        error: "Something went wrong...",
        event: GetMovies(),
      );
    }
  }
  Stream<MoviesTabState> _mapRemoveMovieFromList(
      RemoveMovieFromList event) async* {
    yield MoviesTabReloading(movies: state.movies);
    try {
      Category category =
          await categoryRepository.getCategory(event.movie.categoryCode!);
      for (Category categoryKey in state.movies.keys){
        if (categoryKey == category){
          state.movies[category].remove(event.movie);
        }
      }
      yield MoviesTabLoaded(movies: state.movies);
    } catch (_) {
      yield MoviesTabError(
        movies: HashMap<Category, List<Movie>>(),
        error: "Something went wrong...",
        event: GetMovies(),
      );
    }
  }
}
