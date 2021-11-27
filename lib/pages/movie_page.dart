import 'package:cinema_fe/blocs/forms/movie/movie_bloc.dart';
import 'package:cinema_fe/blocs/movie_description/movie_description_bloc.dart';
import 'package:cinema_fe/blocs/tabs/movies_tab/movies_tab_bloc.dart';
import 'package:cinema_fe/components/movie_description/movie_description.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.movie.title}"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            //context.read<MovieDescriptionBloc>().add(ResetMovieDescription());
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
          ],
          child: BlocProvider(
            create: (BuildContext context) => MovieDescriptionBloc(),
            child: BlocBuilder<MovieDescriptionBloc, MovieDescriptionState>(
              builder: (context, state) {
                if (state is MovieDescriptionEmpty) {
                  BlocProvider.of<MovieDescriptionBloc>(context).add(
                    FetchMovieDescription(
                      movie: widget.movie,
                    ),
                  );
                } else if (state is MovieDescriptionLoaded) {
                  if (state.movie == widget.movie) {
                    return MovieDescription(
                      user: widget.user,
                      movie: state.movie,
                    );
                  } else {
                    BlocProvider.of<MovieDescriptionBloc>(context).add(
                      FetchMovieDescription(
                        movie: widget.movie,
                      ),
                    );
                  }
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
        ),
      ),
    );
  }
}
