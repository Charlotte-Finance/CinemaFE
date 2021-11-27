part of 'liked_tab_bloc.dart';

abstract class LikedTabEvent extends Equatable {
  const LikedTabEvent();
}

class GetLikedMovies extends LikedTabEvent {
  final User user;

  const GetLikedMovies({required this.user});

  @override
  List<Object> get props => [user];
}

class ChangeLikedMovies extends LikedTabEvent {
  final User user;
  final Movie movie;
  final bool isLiked;


  const ChangeLikedMovies({required this.user, required this.movie, required this.isLiked});
  @override
  List<Object> get props => [user, movie, isLiked];
}
