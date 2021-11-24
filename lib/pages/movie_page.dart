import 'package:cinema_fe/blocs/movie/movie_bloc.dart';
import 'package:cinema_fe/components/movie/movie_description.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:cinema_fe/utils/routing_constants.dart';
import 'package:cinema_fe/utils/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoviePage extends StatelessWidget {
  final User user;
  final Movie movie;

  const MoviePage({
    Key? key,
    required this.user,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${movie.title}"),
          leading: backLeading(context, AppRoute, user),
        ),
        body: SingleChildScrollView(
          child: BlocBuilder<MovieBloc, MovieState>(
            builder: (context, state) {
              if (state is MovieEmpty) {
                BlocProvider.of<MovieBloc>(context).add(
                  FetchDescription(
                    movie: movie,
                  ),
                );
              } else if (state is MovieLoaded) {
                return MovieDescription(
                  user: user,
                  movie: state.movie,
                );
              }
              return const CircularProgressIndicator();
            },
          ),
        ));
  }
}
