import 'package:bloc/bloc.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:cinema_fe/repositories/like_repository.dart';
import 'package:cinema_fe/repositories/movie_repository.dart';
import 'package:equatable/equatable.dart';

part 'liked_tab_event.dart';
part 'liked_tab_state.dart';

class LikedTabBloc extends Bloc<LikedTabEvent, LikedTabState> {
  final MovieRepository movieRepository = MovieRepository();
  final LikeRepository likeRepository = LikeRepository();

  LikedTabBloc() : super(const LikedTabEmpty(movies: []));

  @override
  Stream<LikedTabState> mapEventToState(
    LikedTabEvent event,
  ) async* {
    if (event is GetLikedMovies) {
      yield* _mapGetLikedMovies(event);
    }
    if (event is ChangeLikedMovies) {
      yield* _mapChangeLikedMovies(event);
    }
  }

  Stream<LikedTabState> _mapGetLikedMovies(GetLikedMovies event) async* {
    try {
      List<Movie> movies = await movieRepository.getLikedMovies(event.user);
      for (Movie movie in movies) {
        movie.isLiked = true;
      }
      yield LikedTabLoaded(movies: movies);
    } catch (_) {
      yield LikedTabError(
        movies: const [],
        error: "Something went wrong...",
        event: event,
      );
    }
  }

  Stream<LikedTabState> _mapChangeLikedMovies(ChangeLikedMovies event) async* {
    if (state is LikedTabLoaded) {
      yield LikedTabReloading(movies: state.movies);
      List<Movie> movies = state.movies;
      try {
        if (event.isLiked) {
          event.movie.isLiked = event.isLiked;
          movies.add(event.movie);
        } else {
          movies.remove(event.movie);
        }
        yield LikedTabLoaded(movies: movies);
      } catch (_) {
        yield LikedTabError(
          movies: const [],
          error: "Something went wrong...",
          event: GetLikedMovies(user: event.user),
        );
      }
    }
  }
}
