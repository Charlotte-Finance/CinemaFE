import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:cinema_fe/models/category.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/repositories/category_repository.dart';
import 'package:cinema_fe/repositories/movie_repository.dart';
import 'package:equatable/equatable.dart';

part 'home_page_event.dart';

part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final MovieRepository movieRepository = MovieRepository();
  final CategoryRepository categoryRepository = CategoryRepository();

  HomePageBloc() : super(HomePageEmpty());

  @override
  Stream<HomePageState> mapEventToState(
    HomePageEvent event,
  ) async* {
    if (event is GetMovies) {
      yield* _mapGetMovies(event);
    }
  }

  Stream<HomePageState> _mapGetMovies(GetMovies event) async* {
    yield HomePageLoading();
    try {
      List<Category> categories = await categoryRepository.getCategories();
      HashMap movies= HashMap<Category, List<Movie>>();
      for (Category category in categories){
        List<Movie> moviesCategory = await movieRepository.getMoviesByCategory(category);
        movies.putIfAbsent(category, () => moviesCategory);
      }
      yield HomePageLoaded(movies: movies);
    } catch (_) {
      yield HomePageError(
        error: "Something went wrong...",
        event: event,
      );
    }
  }
}
