part of 'my_favourites_bloc.dart';

abstract class MyFavouritesEvent extends Equatable {
  const MyFavouritesEvent();
}

class GetFavouriteMovies extends MyFavouritesEvent {
  final User? user;

  const GetFavouriteMovies({this.user});

  @override
  List<Object?> get props => [user];
}
