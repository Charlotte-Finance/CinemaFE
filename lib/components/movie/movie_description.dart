import 'package:cinema_fe/blocs/forms/forms_bloc.dart';
import 'package:cinema_fe/blocs/movie/movie_bloc.dart';
import 'package:cinema_fe/blocs/tabs/movies_tab/movies_tab_bloc.dart';
import 'package:cinema_fe/components/tabs/movies_tab/movie_card.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:cinema_fe/utils/route_arguments.dart';
import 'package:cinema_fe/utils/routing_constants.dart';
import 'package:cinema_fe/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'actor_list.dart';
import 'character_list.dart';
import 'director_list.dart';

class MovieDescription extends StatelessWidget {
  final User user;
  final Movie movie;

  const MovieDescription({
    Key? key,
    required this.user,
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
            movie: movie,
          ),
          CharacterList(
            user: user,
            characters: movie.characters!,
          ),
          ActorList(
            user: user,
            actors: movie.actors!,
          ),
          DirectorList(
            user: user,
            directors: [movie.director!],
          ),
          GestureDetector(
            child: const Text("Edit"),
            onTap: () {
              BlocProvider.of<FormsBloc>(context).add(
                GetMovieForm(movie: movie),
              );
              WidgetsBinding.instance!.addPostFrameCallback(
                    (_) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    FormRoute,
                    ModalRoute.withName(FormRoute),
                    arguments: UserArgument(user: user),
                  );
                },
              );
            },
          ),
          GestureDetector(
            child: const Text("Delete"),
            onTap: () {
              BlocProvider.of<MovieBloc>(context).add(
                DeleteMovie(movie: movie),
              );
            },
          ),
        ],
      ),
    );
  }
}
