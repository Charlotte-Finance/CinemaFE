import 'package:cinema_fe/blocs/movie/movie_bloc.dart';
import 'package:cinema_fe/components/movie/movie_description.dart';
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
            context.read<MovieBloc>().add(ResetMovie());
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            if (state is MovieEmpty) {
              BlocProvider.of<MovieBloc>(context).add(
                FetchDescription(
                  movie: widget.movie,
                ),
              );
            } else if (state is MovieLoaded) {
              if (state.movie == widget.movie) {
                return MovieDescription(
                  user: widget.user,
                  movie: state.movie,
                );
              }
              else {
                BlocProvider.of<MovieBloc>(context).add(
                  FetchDescription(
                    movie: widget.movie,
                  ),
                );
              }
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
