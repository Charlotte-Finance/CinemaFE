import 'package:cinema_fe/blocs/add_tab/add_tab_bloc.dart';
import 'package:cinema_fe/components/widgets/error_message.dart';
import 'package:cinema_fe/models/actor.dart';
import 'package:cinema_fe/models/character.dart';
import 'package:cinema_fe/models/director.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'actor_form.dart';
import 'add_section.dart';
import 'character_form.dart';
import 'director_form.dart';
import 'movie_form.dart';

class AddTab extends StatelessWidget {
  final User user;

  const AddTab({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddTabBloc, AddTabState>(
      builder: (context, state) {
        if (state is AddTabLoaded) {
          return Column(
            children: [
              AddSection(
                path: "add_movies.jpg",
                event: GetMovieForm(),
                text: "Add a movie",
                beginAlignment: Alignment.centerLeft,
                endAlignment: Alignment.centerRight,
              ),
              const SizedBox(height: 3),
              AddSection(
                path: "add_actors.jpg",
                event: GetActorForm(),
                text: "Add an actor",
                beginAlignment: Alignment.centerRight,
                endAlignment: Alignment.centerLeft,
              ),
              const SizedBox(height: 3),
              AddSection(
                path: "add_characters.jpg",
                event: GetCharacterForm(),
                text: "Add a character",
                beginAlignment: Alignment.centerLeft,
                endAlignment: Alignment.centerRight,
              ),
              const SizedBox(height: 3),
              AddSection(
                path: "add_directors.jpg",
                event: GetDirectorForm(),
                text: "Add a director",
                beginAlignment: Alignment.centerRight,
                endAlignment: Alignment.centerLeft,
              ),
            ],
          );
        } else if (state is MovieFormState) {
          return MovieForm(
            directors: state.directors,
            categories: state.categories,
            create: true,
            movie: Movie(),
          );
        } else if (state is ActorFormState) {
          return ActorForm(
            actor: Actor(),
            create: true,
          );
        } else if (state is CharacterFormState) {
          return CharacterForm(
            character: Character(),
            create: true,
            actors: state.actors,
            movies: state.movies,
          );
        } else if (state is DirectorFormState) {
          return DirectorForm(
            director: Director(), create: true,
          );
        } else if (state is AddTabError) {
          return ErrorMessage(
            error: state.error,
            bloc: BlocProvider.of<AddTabBloc>(context),
            event: state.event,
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
