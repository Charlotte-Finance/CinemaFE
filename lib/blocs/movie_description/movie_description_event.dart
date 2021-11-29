part of 'movie_description_bloc.dart';

abstract class MovieDescriptionEvent extends Equatable {
  const MovieDescriptionEvent();
}

class FetchMovieDescription extends MovieDescriptionEvent {
  final Movie movie;

  const FetchMovieDescription({
    required this.movie,
  });

  @override
  List<Object> get props => [
        movie,
      ];
}

class UpdateDescription extends MovieDescriptionEvent {
  @override
  List<Object> get props => [];
}
class RefreshDescription extends MovieDescriptionEvent {
  @override
  List<Object> get props => [];
}