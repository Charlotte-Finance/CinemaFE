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
