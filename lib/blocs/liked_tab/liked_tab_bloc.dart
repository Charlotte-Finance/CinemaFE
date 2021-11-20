import 'package:bloc/bloc.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:cinema_fe/repositories/movie_repository.dart';
import 'package:equatable/equatable.dart';

part 'liked_tab_event.dart';

part 'liked_tab_state.dart';


class LikedTabBloc extends Bloc<LikedTabEvent, LikedTabState> {
  final MovieRepository movieRepository = MovieRepository();

  LikedTabBloc() : super(LikedTabEmpty());

  @override
  Stream<LikedTabState> mapEventToState(
    LikedTabEvent event,
  ) async* {
    if (event is GetLikedMovies) {
      yield* _mapGetLikedMovies(event);
    }
  }

  Stream<LikedTabState> _mapGetLikedMovies(GetLikedMovies event) async* {
    yield LikedTabLoading();
    try {
      List<Movie> movies = await movieRepository.getLikedMovies(event.user);
      yield LikedTabLoaded(movies: movies);
    } catch (_) {
      yield LikedTabError(
        error: "Something went wrong...",
        event: event,
      );
    }
  }
}
