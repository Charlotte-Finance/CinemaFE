part of 'director_description_bloc.dart';

abstract class DirectorDescriptionEvent extends Equatable {
  const DirectorDescriptionEvent();
}

class FetchDirectorDescription extends DirectorDescriptionEvent {
  final Director director;

  const FetchDirectorDescription({
    required this.director,
  });

  @override
  List<Object> get props => [
    director,
      ];
}

class UpdateDescription extends DirectorDescriptionEvent {

  @override
  List<Object> get props => [];
}

class RefreshDescription extends DirectorDescriptionEvent {
  @override
  List<Object> get props => [];
}