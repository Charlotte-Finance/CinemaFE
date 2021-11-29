import 'package:bloc/bloc.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/repositories/like_repository.dart';
import 'package:cinema_fe/repositories/movie_repository.dart';
import 'package:cinema_fe/utils/styles/texts.dart';
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
    if (event is AddMovie) {
      yield* _mapAddMovie(event);
    }
    if (event is DeleteMovie) {
      yield* _mapDeleteMovie(event);
    }
    if (event is ResetMovie) {
      yield MovieEmpty();
    }
  }

  Stream<MovieState> _mapAddMovie(AddMovie event) async* {
    try {
      int? id = event.movie.id;
      Movie movie = await movieRepository.post(event.movie);
      if (id != null){
        yield MovieEdited(
          movie: movie,
          succeed: true,
          message: addToastStr(
            event.movie,
            event.movie.id,
            true,
          ),
        );
      }
      else{
        yield MovieAdded(
          movie: movie,
          succeed: true,
          message: addToastStr(
            event.movie,
            event.movie.id,
            true,
          ),
        );
      }
    } catch (_) {
      yield MovieActionSent(
        succeed: false,
        message: addToastStr(
          event.movie,
          event.movie.id,
          false,
        ),
      );
    }
  }

  Stream<MovieState> _mapDeleteMovie(DeleteMovie event) async* {
    try {
      await movieRepository.delete(event.movie);
      yield MovieDeleted(
        movie: event.movie,
        succeed: true,
        message: deleteToastStr(
          event.movie,
          true,
        ),
      );
    } catch (_) {
      yield MovieActionSent(
        succeed: false,
        message: deleteToastStr(
          event.movie,
          false,
        ),
      );
    }
  }
}
