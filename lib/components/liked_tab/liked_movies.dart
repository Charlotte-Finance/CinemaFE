import 'package:cinema_fe/components/movie_card/movie_card.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LikedMovies extends StatelessWidget {
  final User user;
  final List<Movie> movies;

  const LikedMovies({Key? key, required this.user, required this.movies})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: movies
          .map((movie) => MovieCard(user: user, movie: movie, isLikedTab: true))
          .toList()
          .cast<Widget>(),
    );
  }
}
