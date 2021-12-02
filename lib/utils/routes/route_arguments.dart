import 'package:cinema_fe/models/actor.dart';
import 'package:cinema_fe/models/director.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/models/user.dart';

class UserArgument {
  final User user;

  const UserArgument({required this.user});
}

class MovieArgument extends UserArgument {
  final Movie movie;

  const MovieArgument({required this.movie, required User user})
      : super(user: user);
}

class ActorArgument extends UserArgument {
  final Actor actor;

  const ActorArgument({required this.actor, required User user})
      : super(user: user);
}

class DirectorArgument extends UserArgument {
  final Director director;

  const DirectorArgument({required this.director, required User user})
      : super(user: user);
}
