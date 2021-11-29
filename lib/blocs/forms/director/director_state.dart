part of 'director_bloc.dart';

abstract class DirectorState extends Equatable {
  const DirectorState();
}

class DirectorEmpty extends DirectorState {
  @override
  List<Object> get props => [];
}

class DirectorActionSent extends DirectorState {
  final String message;
  final bool succeed;

  const DirectorActionSent({
    required this.message,
    required this.succeed,
  });

  @override
  List<Object> get props => [message, succeed];
}

class DirectorAdded extends DirectorActionSent {
  final Director director;
  final String message;
  final bool succeed;

  const DirectorAdded({
    required this.director, required this.message,required this.succeed,
  }) : super(message:message, succeed:succeed) ;

  @override
  List<Object> get props => [director, message, succeed];
}


class DirectorDeleted extends DirectorActionSent {
  final Director director;
  final String message;
  final bool succeed;

  const DirectorDeleted({
    required this.director, required this.message,required this.succeed,
  }) : super(message:message, succeed:succeed) ;

  @override
  List<Object> get props => [director, message, succeed];
}
