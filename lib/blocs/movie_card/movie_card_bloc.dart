import 'package:bloc/bloc.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:cinema_fe/repositories/like_repository.dart';
import 'package:equatable/equatable.dart';

part 'movie_card_event.dart';
part 'movie_card_state.dart';

class MovieCardBloc extends Bloc<MovieCardEvent, MovieCardState> {
  final LikeRepository likeRepository = LikeRepository();

  MovieCardBloc() : super(MovieCardEmpty());

  @override
  Stream<MovieCardState> mapEventToState(
    MovieCardEvent event,
  ) async* {
    if (event is FetchLike) {
      yield* _mapFetchLike(event);
    }
    if (event is LikeMovie) {
      yield* _mapLikeMovie(event);
    }
  }

  Stream<MovieCardState> _mapFetchLike(FetchLike event) async* {
    try {
      bool isLiked = await likeRepository.getLike(event.user, event.movie);
      event.movie.isLiked = isLiked;
      yield MovieCardLoaded(movie: event.movie);
    } catch (_) {
      yield MovieCardError(
        error: "Something went wrong...",
        event: event,
      );
    }
  }

  Stream<MovieCardState> _mapLikeMovie(LikeMovie event) async* {
    try {
      await likeRepository.changeLike(event.user, event.movie);
      event.movie.isLiked = event.isLiked;
      yield MovieCardReloading(movie: event.movie);
    } catch (_) {
      yield MovieCardError(
        error: "Something went wrong...",
        event: event,
      );
    }
  }
}
