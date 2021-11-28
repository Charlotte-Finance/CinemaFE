import 'package:bloc/bloc.dart';
import 'package:cinema_fe/models/character.dart';
import 'package:cinema_fe/repositories/character_repository.dart';
import 'package:cinema_fe/repositories/like_repository.dart';
import 'package:cinema_fe/utils/styles/texts.dart';
import 'package:equatable/equatable.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final CharacterRepository characterRepository = CharacterRepository();
  final LikeRepository likeRepository = LikeRepository();

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
    if (event is ResetCharacter) {
      yield CharacterEmpty();
    }
  }

  Stream<CharacterState> _mapAddCharacter(AddCharacter event) async* {
    try {
      print("AAAAAAAAAA");
      print(event.character.toJson());
      Character character = await characterRepository.post(event.character);
      print("BBBBBBBBBBB");
      yield CharacterAdded(
        character: character,
        succeed: true,
        message: addToastStr(
          event.character,
          event.character.id,
          true,
        ),
      );
      print("CCCCCCCCCCC");

    } catch (_) {
      yield CharacterActionSent(
        succeed: false,
        message: addToastStr(
          event.character,
          event.character.id,
          false,
        ),
      );
    }
  }

  Stream<CharacterState> _mapDeleteCharacter(DeleteCharacter event) async* {
    try {
      await characterRepository.delete(event.character);
      yield CharacterDeleted(
        character: event.character,
        succeed: true,
        message: deleteToastStr(
          event.character,
          true,
        ),
      );
    } catch (_) {
      yield CharacterActionSent(
        succeed: false,
        message: deleteToastStr(
          event.character,
          false,
        ),
      );
    }
  }
}
