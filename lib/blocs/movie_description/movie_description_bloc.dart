import 'package:bloc/bloc.dart';
import 'package:cinema_fe/models/actor.dart';
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
    if (event is LikeMovie) {
      yield* _mapLikeMovie(event);
    }
    // if (event is UpdateActorDescription) {
    //   yield* _mapUpdateActorDescription(event);
    // }

  }

  Stream<MovieDescriptionState> _mapFetchMovieDescription(
      FetchMovieDescription event) async* {
    try {
      List<Character> characters =
          await characterRepository.getByMovie(event.movie);
      for (Character character in characters) {
        character.actor = await actorRepository.getActor(character.id!);
      }
      Director director =
          await directorRepository.getDirector(event.movie.directorId!);
      Category category =
          await categoryRepository.getCategory(event.movie.categoryCode!);
      event.movie.category = category;
      event.movie.director = director;
      event.movie.characters = characters;
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
    print(event.isLiked);
    yield MovieDescriptionReloading(movie:event.movie);
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

  // Stream<MovieDescriptionState> _mapUpdateActorDescription(UpdateActorDescription event) async* {
  //   print("AAAAAAA");
  //   yield MovieDescriptionReloading(movie:state.movie);
  //   try {
  //     for (Actor actor in state.movie.actors!){
  //       if (actor.id == event.actor.id){
  //         actor = event.actor;
  //       }
  //     }
  //     yield MovieDescriptionLoaded(movie: state.movie);
  //   } catch (_) {
  //     yield MovieDescriptionError(
  //       movie: state.movie,
  //       error: "Something went wrong...",
  //       event: MovieDescriptionEmpty(),
  //     );
  //   }
  // }
}
