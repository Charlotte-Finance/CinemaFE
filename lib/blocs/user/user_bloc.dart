import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:cinema_fe/models/category.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/repositories/actor_repository.dart';
import 'package:cinema_fe/repositories/category_repository.dart';
import 'package:cinema_fe/repositories/director_repository.dart';
import 'package:cinema_fe/repositories/movie_repository.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final MovieRepository movieRepository = MovieRepository();
  final CategoryRepository categoryRepository = CategoryRepository();
  final DirectorRepository directorRepository = DirectorRepository();
  final ActorRepository actorRepository = ActorRepository();

  UserBloc()
      : super(UserEmpty(movies: HashMap<Category, List<Movie>>()));

  @override
  Stream<UserState> mapEventToState(
      UserEvent event,
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

  Stream<UserState> _mapGetMovies(GetMovies event) async* {
    try {
      List<Category> categories = await categoryRepository.getCategories();
      HashMap movies = HashMap<Category, List<Movie>>();
      for (Category category in categories) {
        List<Movie> moviesCategory =
        await movieRepository.getMoviesByCategory(category);
        movies.putIfAbsent(category, () => moviesCategory);
      }
      yield UserLoaded(movies: movies);
    } catch (_) {
      yield UserError(
        movies: HashMap<Category, List<Movie>>(),
        error: "Something went wrong...",
        event: event,
      );
    }
  }

  Stream<UserState> _mapAddMovieToList(AddMovieToList event) async* {
    yield UserReloading(movies: state.movies);
    try {
      for (Category categoryKey in state.movies.keys){
        if (categoryKey.code == event.movie.categoryCode){
          state.movies[categoryKey].add(event.movie);
        }
      }
      yield UserLoaded(movies: state.movies);
    } catch (_) {
      yield UserError(
        movies: HashMap<Category, List<Movie>>(),
        error: "Something went wrong...",
        event: GetMovies(),
      );
    }
  }
  Stream<UserState> _mapEditMovie(EditMovie event) async* {
    yield UserReloading(movies: state.movies);
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
      yield UserLoaded(movies: state.movies);
    } catch (_) {
      yield UserError(
        movies: HashMap<Category, List<Movie>>(),
        error: "Something went wrong...",
        event: GetMovies(),
      );
    }
  }
  Stream<UserState> _mapRemoveMovieFromList(
      RemoveMovieFromList event) async* {
    yield UserReloading(movies: state.movies);
    try {
      Category category =
      await categoryRepository.getCategory(event.movie.categoryCode!);
      for (Category categoryKey in state.movies.keys){
        if (categoryKey == category){
          state.movies[category].remove(event.movie);
        }
      }
      yield UserLoaded(movies: state.movies);
    } catch (_) {
      yield UserError(
        movies: HashMap<Category, List<Movie>>(),
        error: "Something went wrong...",
        event: GetMovies(),
      );
    }
  }
}
