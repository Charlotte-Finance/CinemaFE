import 'package:cinema_fe/blocs/movie/movie_bloc.dart';
import 'package:cinema_fe/blocs/tabs/movies_tab/movies_tab_bloc.dart';
import 'package:cinema_fe/components/widgets/error_message.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:cinema_fe/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'category_movies.dart';
import 'movies_carousel.dart';

class MoviesTab extends StatelessWidget {
  final User user;

  const MoviesTab({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesTabBloc, MoviesTabState>(
      builder: (context, state) {
        if (state is MoviesTabEmpty) {
          context.watch<MoviesTabBloc>().add(GetMovies());
        } else if (state is MoviesTabLoaded) {
          List<Movie> allMovies = [];
          for (List<Movie> movies in state.movies.values) {
            for (Movie movie in movies) {
              allMovies.add(movie);
            }
          }
          return BlocProvider(
            create: (BuildContext context) => MovieBloc(),
            child: Column(
              children: [
                Column(
                  children: [
                    Text("Our movies", style: subtitleStyle),
                    const SizedBox(height: 20),
                    MoviesCarousel(
                        user: user, movies: state.movies, allMovies: allMovies),
                  ],
                ),
                CategoryMovies(
                  user: user,
                  movies: state.movies,
                ),
              ],
            ),
          );
        } else if (state is MoviesTabError) {
          return ErrorMessage(
            error: state.error,
            bloc: BlocProvider.of<MoviesTabBloc>(context),
            event: state.event,
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
