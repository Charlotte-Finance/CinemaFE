part of 'movie_bloc.dart';

abstract class MovieState extends Equatable {
  const MovieState();
}

class MovieEmpty extends MovieState {
  @override
  List<Object> get props => [];
}

class MovieActionSent extends MovieState {
  final String message;
  final bool succeed;

  const MovieActionSent({
    required this.message,
    required this.succeed,
  });

  @override
  List<Object> get props => [message, succeed];
}

class MovieAdded extends MovieActionSent {
  final Movie movie;
  final String message;
  final bool succeed;

  const MovieAdded({
    required this.movie, required this.message,required this.succeed,
  }) : super(message:message, succeed:succeed) ;

  @override
  List<Object> get props => [movie, message, succeed];
}


class MovieDeleted extends MovieActionSent {
  final Movie movie;
  final String message;
  final bool succeed;

  const MovieDeleted({
    required this.movie, required this.message,required this.succeed,
  }) : super(message:message, succeed:succeed) ;

  @override
  List<Object> get props => [movie, message, succeed];
}
