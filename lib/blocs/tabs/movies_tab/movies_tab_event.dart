part of 'movies_tab_bloc.dart';

abstract class MoviesTabEvent extends Equatable {
  const MoviesTabEvent();
}

class GetMovies extends MoviesTabEvent {
  @override
  List<Object> get props => [];
}

class AddMovieToList extends MoviesTabEvent {
  final Movie movie;

  const AddMovieToList({required this.movie});

  @override
  List<Object> get props => [movie];
}

class RemoveMovieFromList extends MoviesTabEvent {
  final Movie movie;

  const RemoveMovieFromList({required this.movie});

  @override
  List<Object> get props => [movie];
}
