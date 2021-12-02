import 'package:bloc/bloc.dart';
import 'package:cinema_fe/models/director.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/repositories/category_repository.dart';
import 'package:cinema_fe/repositories/character_repository.dart';
import 'package:cinema_fe/repositories/director_repository.dart';
import 'package:cinema_fe/repositories/movie_repository.dart';
import 'package:equatable/equatable.dart';

part 'director_description_event.dart';
part 'director_description_state.dart';

class DirectorDescriptionBloc
    extends Bloc<DirectorDescriptionEvent, DirectorDescriptionState> {
  final DirectorRepository directorRepository = DirectorRepository();
  final CharacterRepository characterRepository = CharacterRepository();
  final CategoryRepository categoryRepository = CategoryRepository();
  final MovieRepository movieRepository = MovieRepository();
  DirectorDescriptionBloc() : super(const DirectorDescriptionEmpty(movies: []));

  @override
  Stream<DirectorDescriptionState> mapEventToState(
      DirectorDescriptionEvent event,
      ) async* {
    if (event is FetchDirectorDescription) {
      yield* _mapFetchDirectorDescription(event);
    }
    if (event is UpdateDescription) {
      yield DirectorDescriptionReloading(movies: state.movies);
    }
    if (event is RefreshDescription) {
      yield const DirectorDescriptionEmpty(movies: []);
    }
  }

  Stream<DirectorDescriptionState> _mapFetchDirectorDescription(
      FetchDirectorDescription event) async* {
    yield DirectorDescriptionReloading(movies: state.movies);
    try {
      List<Movie> movies = await movieRepository.getByDirector(event.director);
      yield DirectorDescriptionLoaded(
        movies: movies,
      );
    } catch (_) {
      yield DirectorDescriptionError(
        movies: state.movies,
        error: "Something went wrong...",
        event: event,
      );
    }
  }
}
