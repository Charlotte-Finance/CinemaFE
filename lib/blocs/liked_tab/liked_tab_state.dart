part of 'liked_tab_bloc.dart';

abstract class LikedTabState extends Equatable {
  const LikedTabState();
}

class LikedTabEmpty extends LikedTabState {
  @override
  List<Object> get props => [];
}

class LikedTabLoading extends LikedTabState {
  @override
  List<Object> get props => [];
}

class LikedTabLoaded extends LikedTabState {
  final List<Movie> movies;

  const LikedTabLoaded({required this.movies});

  @override
  List<Object> get props => [movies];
}

class LikedTabError extends LikedTabState {
  final String error;
  final Equatable event;

  const LikedTabError({
    required this.error,
    required this.event,
  });

  @override
  List<Object> get props => [error, event];
}
