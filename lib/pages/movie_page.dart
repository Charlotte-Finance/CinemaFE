import 'package:cinema_fe/blocs/forms/actor/actor_bloc.dart';
import 'package:cinema_fe/blocs/forms/character/character_bloc.dart';
import 'package:cinema_fe/blocs/forms/director/director_bloc.dart';
import 'package:cinema_fe/blocs/forms/movie/movie_bloc.dart';
import 'package:cinema_fe/blocs/movie_description/movie_description_bloc.dart';
import 'package:cinema_fe/blocs/tabs/movies_tab/movies_tab_bloc.dart';
import 'package:cinema_fe/components/movie_description/movie_description.dart';
import 'package:cinema_fe/components/widgets/error_message.dart';
import 'package:cinema_fe/components/widgets/snack_bar.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoviePage extends StatefulWidget {
  final User user;
  final Movie movie;

  const MoviePage({
    Key? key,
    required this.user,
    required this.movie,
  }) : super(key: key);

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  late Movie movie;

  @override
  void initState() {
    movie = widget.movie;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.movie.title}"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
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
                if (state is MovieDeleted) {
                  context.read<MoviesTabBloc>().add(
                    RemoveMovieFromList(movie: state.movie),
                  );
                }
                }
              },
            ),
            BlocListener<MovieBloc, MovieState>(
              listener: (context, state) {
                if (state is MovieAdded) {
                  context.read<MovieDescriptionBloc>().add(
                    RefreshDescription(),
                  );
                }
              },
            ),
            BlocListener<ActorBloc, ActorState>(
              listener: (context, state) {
                if (state is ActorDeleted) {
                  context.read<MovieDescriptionBloc>().add(
                    RefreshDescription(),
                  );
                }
              },
            ),
            BlocListener<CharacterBloc, CharacterState>(
              listener: (context, state) {
                if (state is CharacterDeleted) {
                  context.read<MovieDescriptionBloc>().add(
                    RefreshDescription(),
                  );
                }
              },
            ),
            BlocListener<DirectorBloc, DirectorState>(
              listener: (context, state) {
                if (state is DirectorDeleted) {
                  context.read<MovieDescriptionBloc>().add(
                    RefreshDescription(),
                  );
                }
              },
            ),
          ],
          child: BlocBuilder<MovieDescriptionBloc, MovieDescriptionState>(
            builder: (context, state) {
              if (state is MovieDescriptionEmpty) {
                BlocProvider.of<MovieDescriptionBloc>(context).add(
                  FetchMovieDescription(
                    movie: movie,
                  ),
                );
              } else if (state is MovieDescriptionLoaded) {
                if (state is MovieDescriptionReloading &&
                    state.movie.id == movie.id) {
                  WidgetsBinding.instance!.addPostFrameCallback((_) {
                    setState(() {
                      movie = state.movie;
                    });
                  });
                }
                if (state.movie == movie) {
                  return MovieDescription(
                    user: widget.user,
                    movie: state.movie,
                  );
                }
                if (state.movie != movie) {
                  BlocProvider.of<MovieDescriptionBloc>(context).add(
                    FetchMovieDescription(
                      movie: movie,
                    ),
                  );
                }
              } else if (state is MovieDescriptionError) {
                return ErrorMessage(
                  error: state.error,
                  bloc: BlocProvider.of<MovieDescriptionBloc>(context),
                  event: state.event,
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
