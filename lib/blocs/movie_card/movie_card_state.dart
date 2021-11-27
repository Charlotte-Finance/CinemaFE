part of 'movie_card_bloc.dart';

abstract class MovieCardState extends Equatable {

  const MovieCardState();
  @override
  List<Object> get props => [];
}

class MovieCardEmpty extends MovieCardState {

  @override
  List<Object> get props => [];
}


class MovieCardLoaded extends MovieCardState {
  final Movie movie;

  const MovieCardLoaded({required this.movie});

  @override
  List<Object> get props => [movie];
}

class MovieCardReloading extends MovieCardLoaded {
  final Movie movie;

  const MovieCardReloading({required this.movie}) : super(movie: movie);

  @override
  List<Object> get props => [movie];
}


class MovieCardError extends MovieCardState {
  final String error;
  final Equatable event;
  const MovieCardError({
    required this.error,
    required this.event,
  });

  @override
  List<Object> get props => [error, event,];
}
