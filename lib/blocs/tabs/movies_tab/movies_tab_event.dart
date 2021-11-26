part of 'movies_tab_bloc.dart';

abstract class MoviesTabEvent extends Equatable {
  const MoviesTabEvent();
}

class GetMovies extends MoviesTabEvent {
  @override
  List<Object> get props => [];
}

class AddMovieToList extends MoviesTabEvent {
  final HashMap movies;
  final int movieId;

  const AddMovieToList({required this.movies, required this.movieId});

  @override
  List<Object> get props => [movies, movieId];
}

