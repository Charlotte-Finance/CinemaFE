import 'package:bloc/bloc.dart';
import 'package:cinema_fe/models/actor.dart';
import 'package:cinema_fe/models/character.dart';
import 'package:cinema_fe/repositories/actor_repository.dart';
import 'package:cinema_fe/repositories/category_repository.dart';
import 'package:cinema_fe/repositories/character_repository.dart';
import 'package:cinema_fe/repositories/director_repository.dart';
import 'package:cinema_fe/repositories/movie_repository.dart';
import 'package:equatable/equatable.dart';

part 'actor_description_event.dart';
part 'actor_description_state.dart';

class ActorDescriptionBloc
    extends Bloc<ActorDescriptionEvent, ActorDescriptionState> {
  final ActorRepository actorRepository = ActorRepository();
  final DirectorRepository directorRepository = DirectorRepository();
  final CharacterRepository characterRepository = CharacterRepository();
  final CategoryRepository categoryRepository = CategoryRepository();
  final MovieRepository movieRepository = MovieRepository();
  ActorDescriptionBloc() : super(const ActorDescriptionEmpty(characters: []));

  @override
  Stream<ActorDescriptionState> mapEventToState(
    ActorDescriptionEvent event,
  ) async* {
    if (event is FetchActorDescription) {
      yield* _mapFetchActorDescription(event);
    }
    if (event is UpdateDescription) {
      yield ActorDescriptionReloading(characters: state.characters);
    }
    if (event is RefreshDescription) {
      yield const ActorDescriptionEmpty(characters: []);
    }
  }

  Stream<ActorDescriptionState> _mapFetchActorDescription(
      FetchActorDescription event) async* {
    yield ActorDescriptionReloading(characters: state.characters);
    try {
      List<Character>characters = await characterRepository.getByActor(event.actor);
      for (Character character in characters){
        character.movie = await movieRepository.getMovie(character.movieId!);
      }
      yield ActorDescriptionLoaded(
        characters: characters,
      );
    } catch (_) {
      yield ActorDescriptionError(
        characters: state.characters,
        error: "Something went wrong...",
        event: event,
      );
    }
  }
}
