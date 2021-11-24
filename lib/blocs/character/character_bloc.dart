import 'package:bloc/bloc.dart';
import 'package:cinema_fe/models/character.dart';
import 'package:cinema_fe/repositories/character_repository.dart';
import 'package:equatable/equatable.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final CharacterRepository characterRepository = CharacterRepository();

  CharacterBloc() : super(CharacterEmpty());

  @override
  Stream<CharacterState> mapEventToState(
    CharacterEvent event,
  ) async* {
    if (event is AddCharacter) {
      yield* _mapAddCharacter(event);
    }
    if (event is DeleteCharacter) {
      yield* _mapDeleteCharacter(event);
    }
  }

  Stream<CharacterState> _mapAddCharacter(AddCharacter event) async* {
    try {
      Character character = await characterRepository.post(event.character);
      yield CharacterSent(character: character);
    } catch (_) {
      yield CharacterError(
        error: "Something went wrong...",
        event: event,
      );
    }
  }

  Stream<CharacterState> _mapDeleteCharacter(DeleteCharacter event) async* {
    try {
      await characterRepository.delete(event.character);
      yield CharacterEmpty();
    } catch (_) {
      yield CharacterError(
        error: "Something went wrong...",
        event: event,
      );
    }
  }
}
