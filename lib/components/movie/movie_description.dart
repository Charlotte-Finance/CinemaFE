import 'dart:collection';

import 'package:cinema_fe/blocs/movie/movie_bloc.dart';
import 'package:cinema_fe/blocs/movies_tab/movies_tab_bloc.dart';

import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:cinema_fe/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../movies_tab/movie_card.dart';
import 'actor_list.dart';
import 'character_list.dart';
import 'package:provider/src/provider.dart';

import 'director_list.dart';

class MovieDescription extends StatelessWidget {
  final User user;
  final HashMap movies;
  final Movie movie;


  const MovieDescription({
    Key? key,
    required this.user,
    required this.movies,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => MovieBloc(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(movie.title!, style: movieTitleStyle),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "A movie from ${movie.director!.firstname} ${movie.director!.name}",
                  style: movieSubtitleStyle,
                ),
                Text(
                  movie.category!.label,
                  style: categoryStyle,
                ),
              ],
            ),
          ),
          MovieCard(
            user: user,
            movies: movies,
            movie: movie,
          ),
          CharacterList(
            movies: movies,
            movie: movie,
            characters: movie.characters!,
          ),
          ActorList(
            movies: movies,
            movie: movie,
            actors: movie.actors!,
          ),
          DirectorList(
            movies: movies,
            movie: movie,
            directors: [movie.director!],
          ),
          GestureDetector(
            child: const Text("Edit"),
            onTap: () {
              Provider.of<MoviesTabBloc>(context, listen: false).add(
                FetchMovieForm(movies: movies, movie: movie),
              );
            },
          ),
          GestureDetector(
            child: const Text("Delete"),
            onTap: () {
              Provider.of<MoviesTabBloc>(context, listen: false).add(
                DeleteMovie(movie: movie),
              );
            },
          ),
        ],
      ),
    );
  }
}
