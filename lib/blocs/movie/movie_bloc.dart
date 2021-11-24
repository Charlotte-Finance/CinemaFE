import 'dart:collection';

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

part 'movie_event.dart';

part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository movieRepository = MovieRepository();
  final LikeRepository likeRepository = LikeRepository();
  final ActorRepository actorRepository = ActorRepository();
  final DirectorRepository directorRepository = DirectorRepository();
  final CharacterRepository characterRepository = CharacterRepository();
  final CategoryRepository categoryRepository = CategoryRepository();

  MovieBloc() : super(MovieEmpty());

  @override
  Stream<MovieState> mapEventToState(
    MovieEvent event,
  ) async* {
    if (event is FetchDescription) {
      yield* _mapFetchDescription(event);
    }
    if (event is FetchLike) {
      yield* _mapFetchLike(event);
    }
    if (event is LikeMovie) {
      yield* _mapLikeMovie(event);
    }
    if (event is AddMovie) {
      yield* _mapAddMovie(event);
    }
    if (event is DeleteMovie) {
      yield* _mapDeleteMovie(event);
    }
  }

  Stream<MovieState> _mapFetchDescription(FetchDescription event) async* {
    yield MovieLoading();
    try {
      List<Actor> actors = await actorRepository.getByMovie(event.movie);
      List<Character> characters = await characterRepository.getByMovie(event.movie);
      Director director =
          await directorRepository.getDirector(event.movie.directorId!);
      Category category =
          await categoryRepository.getCategory(event.movie.categoryCode!);
      event.movie.category = category;
      event.movie.director = director;
      event.movie.actors = actors;
      event.movie.characters = characters;
      yield MovieLoaded(
        movie: event.movie,
      );
    } catch (_) {
      yield MovieError(
        error: "Something went wrong...",
        event: event,
      );
    }
  }

  Stream<MovieState> _mapFetchLike(FetchLike event) async* {
    yield MovieLoading();
    try {
      bool isLiked = await likeRepository.getLike(event.user, event.movie);
      event.movie.isLiked = isLiked;
      yield MovieLoaded(movie: event.movie);
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
      event.movie.isLiked = event.isLiked;
      yield MovieLoaded(movie: event.movie);
    } catch (_) {
      yield MovieError(
        error: "Something went wrong...",
        event: event,
      );
    }
  }

  Stream<MovieState> _mapAddMovie(AddMovie event) async* {
    yield MovieLoading();
    try {
      await movieRepository.post(event.movie);
      yield MovieLoaded(movie: event.movie);
    } catch (_) {
      yield MovieError(
        error: "Something went wrong...",
        event: event,
      );
    }
  }

  Stream<MovieState> _mapDeleteMovie(DeleteMovie event) async* {
    yield MovieLoading();
    try {
      await movieRepository.delete(event.movie);
      yield MovieEmpty();
    } catch (_) {
      yield MovieError(
        error: "Something went wrong...",
        event: event,
      );
    }
  }
}
