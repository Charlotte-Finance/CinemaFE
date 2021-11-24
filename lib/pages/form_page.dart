import 'package:cinema_fe/blocs/forms/forms_bloc.dart';
import 'package:cinema_fe/components/forms/actor_form.dart';
import 'package:cinema_fe/components/forms/character_form.dart';
import 'package:cinema_fe/components/forms/director_form.dart';
import 'package:cinema_fe/components/forms/movie_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormPage extends StatelessWidget {
  const FormPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form'),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              context.read<FormsBloc>().add(ResetForm());
              Navigator.pop(context);
            }),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<FormsBloc, FormsState>(
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
