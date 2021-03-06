import 'package:cinema_fe/blocs/forms/actor/actor_bloc.dart';
import 'package:cinema_fe/blocs/forms/character/character_bloc.dart';
import 'package:cinema_fe/blocs/forms/director/director_bloc.dart';
import 'package:cinema_fe/blocs/forms/forms_bloc.dart';
import 'package:cinema_fe/blocs/forms/movie/movie_bloc.dart';
import 'package:cinema_fe/blocs/movie_description/movie_description_bloc.dart';
import 'package:cinema_fe/blocs/movies_tab/movies_tab_bloc.dart';
import 'package:cinema_fe/components/forms/actor_form.dart';
import 'package:cinema_fe/components/forms/character_form.dart';
import 'package:cinema_fe/components/forms/director_form.dart';
import 'package:cinema_fe/components/forms/movie_form.dart';
import 'package:cinema_fe/components/widgets/snack_bar.dart';
import 'package:cinema_fe/utils/styles/icons.dart';
import 'package:cinema_fe/utils/styles/texts.dart';
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
        title: Text(formTabStr),
        leading: IconButton(
          icon: backArrow,
          onPressed: () {
            context.read<FormsBloc>().add(ResetForm());
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: MultiBlocListener(
          listeners: [
            BlocListener<MovieBloc, MovieState>(
              listener: (context, state) {
                if (state is MovieActionSent) {
                  context.read<MovieBloc>().add(ResetMovie());
                  toast(context, state.message, state.succeed);
                  if (state is MovieAdded) {
                    if (state is MovieEdited) {
                      context
                          .read<MoviesTabBloc>()
                          .add(EditMovie(movie: state.movie));
                    }
                    if (state is! MovieEdited) {
                      context.read<MoviesTabBloc>().add(
                            AddMovieToList(movie: state.movie),
                          );
                    }
                    context.read<MovieDescriptionBloc>().add(
                          RefreshDescription(),
                        );
                  }
                }
              },
            ),
            BlocListener<ActorBloc, ActorState>(
              listener: (context, state) {
                if (state is ActorActionSent) {
                  context.read<ActorBloc>().add(ResetActor());
                  toast(context, state.message, state.succeed);
                }
                if (state is ActorAdded) {
                  context.read<MovieDescriptionBloc>().add(
                        UpdateDescription(),
                      );
                }
              },
            ),
            BlocListener<CharacterBloc, CharacterState>(
              listener: (context, state) {
                if (state is CharacterActionSent) {
                  context.read<CharacterBloc>().add(ResetCharacter());
                  toast(context, state.message, state.succeed);
                }
                if (state is CharacterAdded) {
                  context.read<MovieDescriptionBloc>().add(
                        UpdateDescription(),
                      );
                }
              },
            ),
            BlocListener<DirectorBloc, DirectorState>(
              listener: (context, state) {
                if (state is DirectorActionSent) {
                  context.read<DirectorBloc>().add(ResetDirector());
                  toast(context, state.message, state.succeed);
                }
                if (state is DirectorAdded) {
                  context.read<MovieDescriptionBloc>().add(
                        UpdateDescription(),
                      );
                }
              },
            ),
          ],
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
      ),
    );
  }
}
