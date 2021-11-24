import 'package:bloc/bloc.dart';
import 'package:cinema_fe/models/actor.dart';
import 'package:cinema_fe/models/category.dart';
import 'package:cinema_fe/models/director.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/repositories/actor_repository.dart';
import 'package:cinema_fe/repositories/category_repository.dart';
import 'package:cinema_fe/repositories/director_repository.dart';
import 'package:cinema_fe/repositories/movie_repository.dart';
import 'package:equatable/equatable.dart';

part 'add_tab_event.dart';
part 'add_tab_state.dart';

class AddTabBloc extends Bloc<AddTabEvent, AddTabState> {
  final MovieRepository movieRepository = MovieRepository();
  final DirectorRepository directorRepository = DirectorRepository();
  final CategoryRepository categoryRepository = CategoryRepository();
  final ActorRepository actorRepository = ActorRepository();

  AddTabBloc() : super(AddTabLoaded());

  @override
  Stream<AddTabState> mapEventToState(
    AddTabEvent event,
  ) async* {

  }

}
