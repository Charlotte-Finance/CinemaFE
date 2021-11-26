import 'package:bloc/bloc.dart';
import 'package:cinema_fe/models/category.dart';
import 'package:cinema_fe/models/character.dart';
import 'package:cinema_fe/models/director.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:cinema_fe/repositories/actor_repository.dart';
import 'package:cinema_fe/repositories/category_repository.dart';
import 'package:cinema_fe/repositories/character_repository.dart';
import 'package:cinema_fe/repositories/director_repository.dart';
import 'package:cinema_fe/repositories/like_repository.dart';
import 'package:cinema_fe/repositories/movie_repository.dart';
import 'package:equatable/equatable.dart';

part 'movie_description_event.dart';

part 'movie_description_state.dart';

class MovieDescriptionBloc
    extends Bloc<MovieDescriptionEvent, MovieDescriptionState> {
  final MovieRepository movieRepository = MovieRepository();
  final LikeRepository likeRepository = LikeRepository();
  final ActorRepository actorRepository = ActorRepository();
  final DirectorRepository directorRepository = DirectorRepository();
  final CharacterRepository characterRepository = CharacterRepository();
  final CategoryRepository categoryRepository = CategoryRepository();

  MovieDescriptionBloc() : super(MovieDescriptionEmpty());

  @override
  Stream<MovieDescriptionState> mapEventToState(
    MovieDescriptionEvent event,
  ) async* {
    if (event is FetchMovieDescription) {
      yield* _mapFetchMovieDescription(event);
    }

    if (event is FetchLike) {
      yield* _mapFetchLike(event);
    }
    if (event is LikeMovie) {
      yield* _mapLikeMovie(event);
    }
    if (event is ResetMovieDescription) {
      yield MovieDescriptionEmpty();
    }
  }

  Stream<MovieDescriptionState> _mapFetchMovieDescription(
      FetchMovieDescription event) async* {
    try {
      print("AAAA");
      List<Character> characters =
          await characterRepository.getByMovie(event.movie);
      print("BBBBBB");

      for (Character character in characters) {
        character.actor = await actorRepository.getActor(character.id!);
      }
      print("CCCCCCCCCC");

      Director director =
          await directorRepository.getDirector(event.movie.directorId!);
      print("DDDDDDDD");

      Category category =
          await categoryRepository.getCategory(event.movie.categoryCode!);
      event.movie.category = category;
      event.movie.director = director;
      event.movie.characters = characters;
      print("EEEEEEEEE");

      yield MovieDescriptionLoaded(
        movie: event.movie,
      );
    } catch (_) {
      yield MovieDescriptionError(
        error: "Something went wrong...",
        event: event,
      );
    }
  }

  Stream<MovieDescriptionState> _mapFetchLike(FetchLike event) async* {
    try {
      bool isLiked = await likeRepository.getLike(event.user, event.movie);
      event.movie.isLiked = isLiked;
      yield MovieDescriptionLoaded(movie: event.movie);
    } catch (_) {
      yield MovieDescriptionError(
        error: "Something went wrong...",
        event: event,
      );
    }
  }

  Stream<MovieDescriptionState> _mapLikeMovie(LikeMovie event) async* {
    try {
      await likeRepository.changeLike(event.user, event.movie);
      event.movie.isLiked = event.isLiked;
      yield MovieDescriptionLoaded(movie: event.movie);
    } catch (_) {
      yield MovieDescriptionError(
        error: "Something went wrong...",
        event: event,
      );
    }
  }
}
