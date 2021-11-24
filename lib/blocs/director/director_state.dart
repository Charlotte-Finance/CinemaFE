part of 'director_bloc.dart';


abstract class DirectorState extends Equatable {
  const DirectorState();
}

class DirectorEmpty extends DirectorState {
  @override
  List<Object> get props => [];
}

class DirectorLoading extends DirectorState {
  @override
  List<Object> get props => [];
}

class DirectorLoaded extends DirectorState {
  final Director director;

  const DirectorLoaded({required this.director});

  @override
  List<Object> get props => [director];
}


class DirectorError extends DirectorState {
  final String error;
  final Equatable event;

  const DirectorError({
    required this.error,
    required this.event,
  });

  @override
  List<Object> get props => [error, event];
}
