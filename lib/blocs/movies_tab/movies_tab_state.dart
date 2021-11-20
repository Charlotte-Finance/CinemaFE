part of 'home_page_bloc.dart';

abstract class HomePageState extends Equatable {
  const HomePageState();
}

class HomePageEmpty extends HomePageState {
  @override
  List<Object> get props => [];
}

class HomePageLoading extends HomePageState {
  @override
  List<Object> get props => [];
}

class HomePageLoaded extends HomePageState {
  final HashMap movies;

  const HomePageLoaded({required this.movies});

  @override
  List<Object> get props => [movies];
}

class HomePageError extends HomePageState {
  final String error;
  final Equatable event;

  const HomePageError({
    required this.error,
    required this.event,
  });

  @override
  List<Object> get props => [error, event];
}
