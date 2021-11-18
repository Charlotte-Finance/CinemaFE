part of 'my_favourites_bloc.dart';

abstract class MyFavouritesState extends Equatable {
  const MyFavouritesState();
}

class MyFavouritesEmpty extends MyFavouritesState {
  @override
  List<Object> get props => [];
}

class MyFavouritesLoading extends MyFavouritesState {
  @override
  List<Object> get props => [];
}

class MyFavouritesLoaded extends MyFavouritesState {
  final List<Movie> movies;

  const MyFavouritesLoaded({required this.movies});

  @override
  List<Object> get props => [movies];
}

class MyFavouritesError extends MyFavouritesState {
  final String error;
  final Equatable event;

  const MyFavouritesError({
    required this.error,
    required this.event,
  });

  @override
  List<Object> get props => [error, event];
}
