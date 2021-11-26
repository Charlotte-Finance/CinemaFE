import 'package:cinema_fe/blocs/forms/forms_bloc.dart';
import 'package:cinema_fe/blocs/forms/movie/movie_bloc.dart';
import 'package:cinema_fe/blocs/movie_description/movie_description_bloc.dart';
import 'package:cinema_fe/components/widgets/error_message.dart';
import 'package:cinema_fe/components/widgets/movie_card.dart';
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
    return BlocBuilder<MovieDescriptionBloc, MovieDescriptionState>(
      builder: (context, state) {
        if (state is MovieDescriptionEmpty) {
          context.watch<MovieDescriptionBloc>().add(
              FetchMovieDescription(movie: movie));
        } else if (state is MovieDescriptionLoaded) {
          return Column(
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
                      "A movie from ${movie.director!.firstname} ${movie
                          .director!.name}",
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
                enableClick: false,
              ),
              CharacterList(
                user: user,
                characters: movie.characters!,
              ),
              ActorList(
                user: user,
                characters: movie.characters!,
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
                  Navigator.pushNamed(
                    context,
                    FormRoute,
                    arguments: UserArgument(user: user),
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
          );
        } else if (state is MovieDescriptionError) {
          return ErrorMessage(
            error: state.error,
            bloc: BlocProvider.of<MovieDescriptionBloc>(context),
            event: state.event,
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
