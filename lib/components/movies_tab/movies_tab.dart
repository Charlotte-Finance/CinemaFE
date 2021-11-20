import 'package:cinema_fe/blocs/movie/movie_bloc.dart';
import 'package:cinema_fe/blocs/movies_tab/movies_tab_bloc.dart';
import 'package:cinema_fe/components/error_message.dart';
import 'package:cinema_fe/models/category.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../movie_card.dart';

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
          return Column(
            children: [
              for (List<Movie> movies in state.movies.values) ...[
                for (Movie movie in movies) ...[
                  Text(movie.title),
                ]
              ],
              for (Category category in state.movies.keys) ...[
                const SizedBox(height: 50),
                Text(category.label),
                for (Movie movie in state.movies[category]) ...[
                  BlocProvider(
                    create: (BuildContext context) => MovieBloc(),
                    child: MovieCard(
                      user: user,
                      movie: movie,
                    ),
                  ),
                ],
              ],
            ],
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
