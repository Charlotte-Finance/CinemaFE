import 'package:bloc/bloc.dart';
import 'package:cinema_fe/models/actor.dart';
import 'package:cinema_fe/models/category.dart';
import 'package:cinema_fe/models/character.dart';
import 'package:cinema_fe/models/director.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/repositories/actor_repository.dart';
import 'package:cinema_fe/repositories/category_repository.dart';
import 'package:cinema_fe/repositories/director_repository.dart';
import 'package:cinema_fe/repositories/movie_repository.dart';
import 'package:equatable/equatable.dart';

part 'forms_event.dart';
part 'forms_state.dart';

class FormsBloc extends Bloc<FormsEvent, FormsState> {
  final MovieRepository movieRepository = MovieRepository();
  final DirectorRepository directorRepository = DirectorRepository();
  final CategoryRepository categoryRepository = CategoryRepository();
  final ActorRepository actorRepository = ActorRepository();

  FormsBloc() : super(FormLoaded());

  @override
  Stream<FormsState> mapEventToState(
    FormsEvent event,
  ) async* {
    if (event is GetMovieForm) {
      yield* _mapGetMovieForms(event);
    }
    if (event is GetActorForm) {
      yield* _mapGetActorForms(event);
    }
    if (event is GetCharacterForm) {
      yield* _mapGetCharacterForms(event);
    }
    if (event is GetDirectorForm) {
      yield* _mapGetDirectorForms(event);
    }
    if (event is ResetForm) {
      yield FormEmpty();
    }
  }

  Stream<FormsState> _mapGetMovieForms(GetMovieForm event) async* {
    try {
      List<Director> directors = await directorRepository.getDirectors();
      List<Category> categories = await categoryRepository.getCategories();
      if (event.movie.id != null){
        Director director =
        await directorRepository.getDirector(event.movie.directorId!);
        Category category =
        await categoryRepository.getCategory(event.movie.categoryCode!);
        event.movie.director = director;
        event.movie.category = category;
      }
      yield MovieFormState(
        movie: event.movie,
        directors: directors,
        categories: categories,
      );
    } catch (_) {
      yield FormError(
        error: "Something went wrong...",
        event: event,
      );
    }
  }

  Stream<FormsState> _mapGetActorForms(GetActorForm event) async* {
    try {
      yield ActorFormState(
        actor: event.actor,
      );
    } catch (_) {
      yield FormError(
        error: "Something went wrong...",
        event: event,
      );
    }
  }

  Stream<FormsState> _mapGetCharacterForms(GetCharacterForm event) async* {
    try {
      List<Actor> actors = await actorRepository.getActors();
      List<Movie> movies = await movieRepository.getMovies();
      if (event.character.id != null) {
        Actor actor = await actorRepository.getActor(event.character.actorId!);
        Movie movie = await movieRepository.getMovie(event.character.movieId!);
        event.character.actor = actor;
        event.character.movie = movie;
      }
      yield CharacterFormState(
        character: event.character,
        actors: actors,
        movies: movies,
      );
    } catch (_) {
      yield FormError(
        error: "Something went wrong...",
        event: event,
      );
    }
  }

  Stream<FormsState> _mapGetDirectorForms(GetDirectorForm event) async* {
    try {
      yield DirectorFormState(director: event.director);
    } catch (_) {
      yield FormError(
        error: "Something went wrong...",
        event: event,
      );
    }
  }
}
