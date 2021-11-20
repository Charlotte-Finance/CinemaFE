import 'package:bloc/bloc.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:cinema_fe/repositories/like_repository.dart';
import 'package:cinema_fe/repositories/movie_repository.dart';
import 'package:equatable/equatable.dart';

part 'movie_event.dart';

part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository movieRepository = MovieRepository();
  final LikeRepository likeRepository = LikeRepository();

  MovieBloc() : super(MovieEmpty());

  @override
  Stream<MovieState> mapEventToState(
    MovieEvent event,
  ) async* {
    if (event is FetchLike) {
      yield* _mapFetchLike(event);
    }
    if (event is LikeMovie) {
      yield* _mapLikeMovie(event);
    }
  }

  Stream<MovieState> _mapFetchLike(FetchLike event) async* {
    yield MovieLoading();
    try {
      bool isLiked = await likeRepository.getLike(event.user, event.movie);
      yield MovieLoaded(movie: event.movie, isLiked: isLiked);
    } catch (_) {
      yield MovieError(
        error: "Something went wrong...",
        event: event,
      );
    }
  }

  Stream<MovieState> _mapLikeMovie(LikeMovie event) async* {
    yield MovieLoading();
    try {
      await likeRepository.changeLike(event.user, event.movie);
      yield MovieLoaded(movie: event.movie, isLiked: event.isLiked);
    } catch (_) {
      yield MovieError(
        error: "Something went wrong...",
        event: event,
      );
    }
  }
}
