part of 'director_bloc.dart';

abstract class DirectorEvent extends Equatable {
  const DirectorEvent();
}

class AddDirector extends DirectorEvent {
  final Director director;

  const AddDirector(
      {required this.director});

  @override
  List<Object> get props => [director];
}


class DeleteDirector extends DirectorEvent {
  final Director director;

  const DeleteDirector({
    required this.director,
  });

  @override
  List<Object> get props => [
    director,
  ];
}
