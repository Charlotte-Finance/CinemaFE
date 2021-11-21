import 'package:cinema_fe/blocs/movie/movie_bloc.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'error_message.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final User user;

  final Icon unlikedIcon = const Icon(Icons.favorite_border);
  final Icon likedIcon = const Icon(
    Icons.favorite,
    color: Colors.red,
  );

  const MovieCard({
    Key? key,
    required this.user,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state is MovieEmpty) {
        } else if (state is MovieLoaded) {
          return Stack(
            children: <Widget>[
              Image(
                image: AssetImage('lib/assets/movies_tab/${movie.id}.jpg'),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    context.watch<MovieBloc>().add(
                          LikeMovie(
                            user: user,
                            movie: movie,
                            isLiked: !(state.isLiked),
                          ),
                        );
                  },
                  child: state.isLiked ? likedIcon : unlikedIcon,
                ),
              ),
            ],
          );
        } else if (state is MovieError) {
          return ErrorMessage(
            error: state.error,
            bloc: BlocProvider.of<MovieBloc>(context),
            event: state.event,
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
