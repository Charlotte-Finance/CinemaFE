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
