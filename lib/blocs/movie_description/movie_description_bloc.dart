import 'package:bloc/bloc.dart';
import 'package:cinema_fe/models/category.dart';
import 'package:cinema_fe/models/character.dart';
import 'package:cinema_fe/models/director.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/repositories/actor_repository.dart';
import 'package:cinema_fe/repositories/category_repository.dart';
import 'package:cinema_fe/repositories/character_repository.dart';
import 'package:cinema_fe/repositories/director_repository.dart';
import 'package:cinema_fe/repositories/movie_repository.dart';
import 'package:equatable/equatable.dart';

part 'movie_description_event.dart';
part 'movie_description_state.dart';

class MovieDescriptionBloc
    extends Bloc<MovieDescriptionEvent, MovieDescriptionState> {
  final MovieRepository movieRepository = MovieRepository();
  final ActorRepository actorRepository = ActorRepository();
  final DirectorRepository directorRepository = DirectorRepository();
  final CharacterRepository characterRepository = CharacterRepository();
  final CategoryRepository categoryRepository = CategoryRepository();

  MovieDescriptionBloc() : super(MovieDescriptionEmpty(movie: Movie()));

  @override
  Stream<MovieDescriptionState> mapEventToState(
    MovieDescriptionEvent event,
  ) async* {
    if (event is FetchMovieDescription) {
      yield* _mapFetchMovieDescription(event);
    }
    if (event is UpdateDescription) {
      yield MovieDescriptionReloading(movie: state.movie);
    }
    if (event is RefreshDescription) {
      yield MovieDescriptionEmpty(movie: Movie());
    }
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
        movie: state.movie,
        error: "Something went wrong...",
        event: event,
      );
    }
  }

}
