import 'package:bloc/bloc.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:cinema_fe/repositories/movie_repository.dart';
import 'package:equatable/equatable.dart';

part 'my_favourites_event.dart';

part 'my_favourites_state.dart';


class MyFavouritesBloc extends Bloc<MyFavouritesEvent, MyFavouritesState> {
  final MovieRepository movieRepository = MovieRepository();

  MyFavouritesBloc() : super(MyFavouritesEmpty());

  @override
  Stream<MyFavouritesState> mapEventToState(
    MyFavouritesEvent event,
  ) async* {
    if (event is GetFavouriteMovies) {
      yield* _mapGetFavouriteMovies(event);
    }
  }

  Stream<MyFavouritesState> _mapGetFavouriteMovies(GetFavouriteMovies event) async* {
    yield MyFavouritesLoading();
    try {
      List<Movie> movies = await movieRepository.getFavouriteMovies();
      yield MyFavouritesLoaded(movies: movies);
    } catch (_) {
      yield MyFavouritesError(
        error: "Something went wrong...",
        event: event,
      );
    }
  }
}
