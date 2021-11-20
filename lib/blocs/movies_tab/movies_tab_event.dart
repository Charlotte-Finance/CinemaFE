part of 'home_page_bloc.dart';

abstract class HomePageEvent extends Equatable {
  const HomePageEvent();
}

class GetMovies extends HomePageEvent {
  @override
  List<Object> get props => [];
}
