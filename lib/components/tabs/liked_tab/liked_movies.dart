import 'package:cinema_fe/blocs/tabs/liked_tab/liked_tab_bloc.dart';
import 'package:cinema_fe/components/widgets/error_message.dart';
import 'package:cinema_fe/components/widgets/movie_card.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LikedMovies extends StatelessWidget {
  final User user;
  final List<Movie> movies;
  const LikedMovies({Key? key, required this.user, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double itemHeight =
        (MediaQuery.of(context).size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = MediaQuery.of(context).size.width / 2;
    return GridView.count(
      crossAxisCount: 3,
      childAspectRatio: (itemWidth / itemHeight),
      controller: ScrollController(keepScrollOffset: false),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: movies.map((Movie movie) {
        return MovieCard(
            user: user,
            movie: movie,
            width: MediaQuery.of(context).size.width * 0.3);
      }).toList(),
    );
  }
}
