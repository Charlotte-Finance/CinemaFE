import 'package:cinema_fe/blocs/movie_card/movie_card_bloc.dart';
import 'package:cinema_fe/components/widgets/error_message.dart';
import 'package:cinema_fe/components/movie_card/movie_picture.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieCard extends StatefulWidget {
  final Movie movie;
  final User user;
  final bool enableClick;

  const MovieCard({
    Key? key,
    required this.user,
    required this.movie,
    this.enableClick = true,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MovieCardState();
  }
}

class _MovieCardState extends State<MovieCard> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieCardBloc, MovieCardState>(
      builder: (context, state) {
        if (state is MovieCardEmpty) {
          context.watch<MovieCardBloc>().add(
                FetchLike(
                  user: widget.user,
                  movie: widget.movie,
                ),
              );
        } else if (state is MovieCardLoaded) {
          if (state is MovieCardReloading &&
              state.movie.id == widget.movie.id!) {
            context.watch<MovieCardBloc>().add(
                  FetchLike(
                    user: widget.user,
                    movie: widget.movie,
                  ),
                );
          }
          return MoviePicture(user: widget.user, movie: widget.movie);
        } else if (state is MovieCardError) {
          return ErrorMessage(
            error: state.error,
            bloc: BlocProvider.of<MovieCardBloc>(context),
            event: state.event,
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
