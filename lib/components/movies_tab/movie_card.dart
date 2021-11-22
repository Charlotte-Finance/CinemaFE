import 'dart:collection';

import 'package:cinema_fe/blocs/movie/movie_bloc.dart';
import 'package:cinema_fe/blocs/movies_tab/movies_tab_bloc.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/src/provider.dart';

import '../widgets/error_message.dart';

class MovieCard extends StatelessWidget {
  final dynamic movies;
  final Movie movie;
  final User user;

  final Icon unlikedIcon = const Icon(
    Icons.favorite_border,
    color: Colors.red,
    size: 40,
  );
  final Icon likedIcon = const Icon(
    Icons.favorite,
    color: Colors.red,
    size: 40,
  );

  const MovieCard({
    Key? key,
    required this.user,
    required this.movies,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state is MovieEmpty) {
          context.watch<MovieBloc>().add(
                FetchLike(
                  user: user,
                  movie: movie,
                ),
              );
        } else if (state is MovieLoaded) {
          return Stack(
            children: [
              GestureDetector(
                onTap: () {
                  Provider.of<MoviesTabBloc>(context, listen: false).add(
                    FetchDescription(
                      movies: movies,
                      movie: movie,
                    ),
                  );
                },
                child: Image(
                  image: AssetImage('lib/assets/movies/${movie.id}.jpg'),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Provider.of<MovieBloc>(context, listen: false).add(
                    LikeMovieWhenLoaded(
                      user: user,
                      movie: movie,
                      isLiked: !(movie.isLiked!),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  color: Colors.white.withOpacity(0.2),
                  child: movie.isLiked! ? likedIcon : unlikedIcon,
                ),
              ),
            ],
          );
        } else if (state is MovieError) {
          return ErrorMessage(
            error: state.error,
            bloc: BlocProvider.of<MovieBloc>(context),
            event: state.event,
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
