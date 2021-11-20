import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:cinema_fe/models/category.dart';
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
  }

  Stream<MoviesTabState> _mapGetMovies(GetMovies event) async* {
    yield MoviesTabLoading();
    try {
      //List<Category> categories = await categoryRepository.getCategories();
      HashMap movies = HashMap<Category, List<Movie>>();
      // for (Category category in categories){
      //   List<Movie> moviesCategory = await movieRepository.getMoviesByCategory(category);
      //   movies.putIfAbsent(category, () => moviesCategory);
      // }
      List<Movie> actionMovies = [
        Movie(
            id: 1,
            title: "Leon",
            duration: 1,
            release: DateTime.now(),
            budget: 1,
            revenue: 1,
            directorId: 1,
            categoryCode: "AC"),
        Movie(
            id: 2,
            title: "Cash",
            duration: 1,
            release: DateTime.now(),
            budget: 1,
            revenue: 1,
            directorId: 1,
            categoryCode: "AC"),
      ];
      List<Movie> horrorMovies = [
        Movie(
            id: 3,
            title: "Vadrouille",
            duration: 1,
            release: DateTime.now(),
            budget: 1,
            revenue: 1,
            directorId: 1,
            categoryCode: "AC"),
        Movie(
          id: 4,
          title: "Subway",
          duration: 1,
          release: DateTime.now(),
          budget: 1,
          revenue: 1,
          directorId: 1,
          categoryCode: "AC",
        ),
      ];
      movies.putIfAbsent(Category(code: "AC", label: "Action", picture: "None"),
          () => actionMovies);
      movies.putIfAbsent(Category(code: "HR", label: "Horror", picture: "None"),
              () => horrorMovies);
      yield MoviesTabLoaded(movies: movies);
    } catch (_) {
      yield MoviesTabError(
        error: "Something went wrong...",
        event: event,
      );
    }
  }
}
