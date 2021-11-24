import 'package:cinema_fe/blocs/forms/forms_bloc.dart';
import 'package:cinema_fe/components/forms/actor_form.dart';
import 'package:cinema_fe/components/forms/character_form.dart';
import 'package:cinema_fe/components/forms/director_form.dart';
import 'package:cinema_fe/components/forms/movie_form.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:cinema_fe/utils/routing_constants.dart';
import 'package:cinema_fe/utils/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormPage extends StatelessWidget {
  final User user;
  final Movie movie;
  const FormPage({
    required this.user,
    required this.movie,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form'),
        leading: backLeading(context, AppRoute, user),
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<FormsBloc, FormsState>(
          listener: (context, state){},
          builder: (context, state) {
            if (state is MovieFormState) {
              return MovieForm(
                movie: state.movie,
                directors: state.directors,
                categories: state.categories,
              );
            } else if (state is CharacterFormState) {
              return CharacterForm(
                character: state.character,
                actors: state.actors,
                movies: state.movies,
              );
            } else if (state is ActorFormState) {
              return ActorForm(actor: state.actor);
            } else if (state is DirectorFormState) {
              return DirectorForm(
                director: state.director,
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
