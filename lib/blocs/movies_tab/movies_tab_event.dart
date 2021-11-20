part of 'movies_tab_bloc.dart';

abstract class MoviesTabEvent extends Equatable {
  const MoviesTabEvent();
}

class GetMovies extends MoviesTabEvent {
  @override
  List<Object> get props => [];
}
