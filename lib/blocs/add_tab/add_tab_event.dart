part of 'add_tab_bloc.dart';

abstract class AddTabEvent extends Equatable {
  const AddTabEvent();
}

class GetMovieForm extends AddTabEvent {
  @override
  List<Object> get props => [];
}

class AddMovie extends AddTabEvent {
  final String title;
  final int duration;
  final DateTime release;
  final int budget;
  final int revenue;
  final int directorId;
  final String categoryCode;

  const AddMovie({
    required this.title,
    required this.duration,
    required this.release,
    required this.budget,
    required this.revenue,
    required this.directorId,
    required this.categoryCode,
  });

  @override
  List<Object> get props => [
        title,
        duration,
        release,
        budget,
        revenue,
        directorId,
        categoryCode,
      ];
}

class GetCharacterForm extends AddTabEvent {
  @override
  List<Object> get props => [];
}

class AddCharacter extends AddTabEvent {
  final String name;
  final int actorId;
  final int movieId;

  const AddCharacter(
      {required this.name, required this.actorId, required this.movieId});

  @override
  List<Object> get props => [name, actorId, movieId];
}

class GetActorForm extends AddTabEvent {
  @override
  List<Object> get props => [];
}

class AddActor extends AddTabEvent {
  final String name;
  final String firstname;
  final DateTime birth;
  final DateTime? death;

  const AddActor({
    required this.name,
    required this.firstname,
    required this.birth,
    required this.death,
  });

  @override
  List<Object?> get props => [
        name,
        firstname,
        birth,
        death,
      ];
}

class GetDirectorForm extends AddTabEvent {
  @override
  List<Object> get props => [];
}

class AddDirector extends AddTabEvent {
  final String name;
  final String firstname;

  const AddDirector({
    required this.name,
    required this.firstname,
  });

  @override
  List<Object> get props => [
        name,
        firstname,
      ];
}

class GoBack extends AddTabEvent {
  @override
  List<Object> get props => [];
}
