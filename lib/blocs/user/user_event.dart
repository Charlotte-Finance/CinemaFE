part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class GetMovies extends UserEvent {
  @override
  List<Object> get props => [];
}

class AddMovieToList extends UserEvent {
  final Movie movie;

  const AddMovieToList({required this.movie});

  @override
  List<Object> get props => [movie];
}

class EditMovie extends UserEvent {
  final Movie movie;

  const EditMovie({required this.movie});

  @override
  List<Object> get props => [movie];
}
class RemoveMovieFromList extends UserEvent {
  final Movie movie;

  const RemoveMovieFromList({required this.movie});

  @override
  List<Object> get props => [movie];
}
