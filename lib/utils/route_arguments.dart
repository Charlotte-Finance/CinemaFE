import 'package:bloc/bloc.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:equatable/equatable.dart';

class UserArgument {
  final User user;

  const UserArgument({required this.user});
}

class MovieArgument extends UserArgument {
  final Movie movie;

  const MovieArgument({required this.movie, required User user})
      : super(user: user);
}
