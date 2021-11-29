import 'package:cinema_fe/blocs/forms/forms_bloc.dart';
import 'package:cinema_fe/models/actor.dart';
import 'package:cinema_fe/models/character.dart';
import 'package:cinema_fe/models/director.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'add_section.dart';

class AddTab extends StatelessWidget {
  final User user;

  const AddTab({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = kIsWeb ? MediaQuery.of(context).size.height * 0.5 : MediaQuery.of(context).size.height * 0.25;
    return Column(
      children: [
        AddSection(
          user: user,
          path: "add_movies.jpg",
          event: GetMovieForm(movie: Movie()),
          text: "Add a movie",
          beginAlignment: Alignment.centerLeft,
          endAlignment: Alignment.centerRight,
          height : height,
        ),
        const SizedBox(height: 3),
        AddSection(
          user: user,
          path: "add_actors.jpg",
          event: GetActorForm(actor: Actor()),
          text: "Add an actor",
          beginAlignment: Alignment.centerRight,
          endAlignment: Alignment.centerLeft,
          height : height,
        ),
        const SizedBox(height: 3),
        AddSection(
          user: user,
          path: "add_characters.jpg",
          event: GetCharacterForm(character: Character()),
          text: "Add a character",
          beginAlignment: Alignment.centerLeft,
          endAlignment: Alignment.centerRight,
          height : height,
        ),
        const SizedBox(height: 3),
        AddSection(
          user: user,
          path: "add_directors.jpg",
          event: GetDirectorForm(director: Director()),
          text: "Add a director",
          beginAlignment: Alignment.centerRight,
          endAlignment: Alignment.centerLeft,
          height : height,
        ),
      ],
    );
  }
}
