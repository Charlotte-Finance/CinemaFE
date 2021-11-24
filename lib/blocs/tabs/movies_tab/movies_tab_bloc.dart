import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:cinema_fe/models/actor.dart';
import 'package:cinema_fe/models/category.dart';
import 'package:cinema_fe/models/character.dart';
import 'package:cinema_fe/models/director.dart';
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

  MoviesTabBloc() : super(MoviesTabEmpty());

  @override
  Stream<MoviesTabState> mapEventToState(
    MoviesTabEvent event,
  ) async* {
    if (event is GetMovies) {
      yield* _mapGetMovies(event);
    }
  }

  Stream<MoviesTabState> _mapGetMovies(GetMovies event) async* {
    yield MoviesTabLoading();
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
        error: "Something went wrong...",
        event: event,
      );
    }
  }
}
