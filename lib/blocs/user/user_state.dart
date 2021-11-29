part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  final HashMap movies;

  const UserState({required this.movies});

  @override
  List<Object> get props => [movies];
}

class UserEmpty extends UserState {
  final HashMap movies;

  UserEmpty({required this.movies}) : super(movies: movies);

  @override
  List<Object> get props => [movies];
}
class UserError extends UserState {
  final HashMap movies;
  final String error;
  final Equatable event;

  const UserError({
    required this.movies,
    required this.error,
    required this.event,
  }) : super(movies: movies);

  @override
  List<Object> get props => [movies, error, event];
}

class UserLoaded extends UserState {
  final HashMap movies;

  const UserLoaded({required this.movies}) : super(movies: movies);

  @override
  List<Object> get props => [movies];
}

class UserReloading extends UserLoaded {
  final HashMap movies;

  const UserReloading({required this.movies}) : super(movies: movies);

  @override
  List<Object> get props => [movies];
}

